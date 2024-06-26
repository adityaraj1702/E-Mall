import 'package:e_mall/providers/cart_provider.dart';
import 'package:e_mall/providers/profile_data_provider.dart';
import 'package:e_mall/providers/saved_product_provider.dart';
import 'package:e_mall/screens/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        profileProvider.setImage(bytes);
      }
    }

    Future<void> _editProfileField(String field, String currentValue) async {
      TextEditingController controller = TextEditingController(text: currentValue);

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit $field'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: field,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (field == 'Name') {
                    profileProvider.setName(controller.text);
                  } else if (field == 'Mobile Number') {
                    profileProvider.setMobileNumber(controller.text);
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }

    void popAndPushAuthScreen(BuildContext context) {
      Navigator.popUntil(
          context, (route) => route.isFirst); // Pop until first screen
      Navigator.pushNamed(context, '/auth');
    }

    Future<void> logout() async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Logout?'),
                content: const Text(
                    'Do you want to logout? Items in cart and maked saved will be lost'),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<ProfileProvider>(context, listen: false)
                          .deleteProfileData();
                      Provider.of<SavedProductsProvider>(context, listen: false)
                          .deleteSavedProductsFromLocalStorage();
                      Provider.of<CartProvider>(context, listen: false)
                          .deleteCartFromLocalStorage();
                      await FirebaseAuth.instance.signOut();
                      // Navigator.popAndPushNamed(context, '/auth');
                      popAndPushAuthScreen(context);
                    },
                    child: const Text('Logout'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ]);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(
              Icons.logout,
            ),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profileProvider.image != null
                      ? MemoryImage(profileProvider.image!)
                      : const AssetImage('assets/images/user.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ProfileDetail(
              label: 'Name',
              value: profileProvider.name,
              onEdit: () => _editProfileField('Name', profileProvider.name),
            ),
            ProfileDetail(
              label: 'Email',
              value: profileProvider.email,
              onEdit: null,
            ),
            ProfileDetail(
              label: 'Mobile Number',
              value: profileProvider.mobileNumber,
              onEdit: () => _editProfileField(
                  'Mobile Number', profileProvider.mobileNumber),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onEdit;

  const ProfileDetail({super.key, required this.label, required this.value, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
      trailing: onEdit != null
          ? IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            )
          : null,
    );
  }
}
