# Urban Cart

Urban Cart is a Flutter-based e-commerce application that allows users to browse, save, and purchase products across various categories. The app integrates with Firebase for authentication and utilizes local storage to persist user data such as saved products and cart items.

## Features

- User Authentication (Login & Registration)
- Browse products by categories
- Save products for later
- Add products to cart
- View detailed product information
- Persistent storage for saved products, cart items and user profile 

## Screenshots

Add screenshots of your app here to showcase its UI and features.

![SplashScreen](https://drive.google.com/file/d/1gwFFTbwst1EXOtnW-kgN4eJc2ZwSDrzU/view?usp=sharing)
![RegisterScreen](https://drive.google.com/file/d/1gvcZ82ZfttWwjaeCfGracQb7qr0yDL1t/view?usp=sharing)
![LoginScreen](https://drive.google.com/file/d/1gtQbQha9UOzXjpDQJ9qhIZ04WQa1evNV/view?usp=sharing)
![HomePage](https://drive.google.com/file/d/1hLCPlV0uLAgvsxqHvfbZEjgfKlA-RYMC/view?usp=sharing)
![ProductDetailsScreen](https://drive.google.com/file/d/1hT_39EevtsZyXbMVwsm0NcB3DkI2yYdC/view?usp=sharing)
![Saved Product Page](https://drive.google.com/file/d/1h4M5sO2QrXsrkLinIPWCiyRwRhnsZd71/view?usp=sharing)
![CartPage](https://drive.google.com/file/d/1h0NX6SbALEsDWvq1a5MWRgL_NRb3S_8u/view?usp=sharing)
![ProfilePage](https://drive.google.com/file/d/1gs_DSPjXZUdd-ZIza7Egt0o5d4j76ogG/view?usp=sharing)
![ThemeSettingsPage](https://drive.google.com/file/d/1h-lWMcxnhSUL1tXhgz-UjpbPLuJzwGSJ/view?usp=sharing)
![HomePage_DarkMode](https://drive.google.com/file/d/1h-BLjrTrM67uGqu1nL4hRNtCInNS17hG/view?usp=sharing)



## Demo Video

[Demo Video](https://drive.google.com/file/d/1gkOW14G6rUQYLfdhqprJeZgsTRjyabfv/view?usp=sharing)

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/adityaraj1702/UrbanCart.git
   cd UrbanCart
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android app to your Firebase project and download the `google-services.json` file.
   - Place the `google-services.json` file in the `android/app` directory of your Flutter project.
   - Ensure that your `android/build.gradle` and `android/app/build.gradle` files are properly configured as shown in the setup instructions from Firebase.

4. **Run the app**

   ```bash
   flutter run
   ```

## Usage

- **Register**: Create a new account using your email and password.
- **Login**: Access your account by logging in.
- **Browse Products**: Browse products by categories.
- **Save Products**: Save products for later.
- **Add to Cart**: Add products to your cart.
- **View Cart**: View products added to your cart and proceed to checkout.
- **Edit User Profile**: View and edit user profile.

## Code Overview

### Main Files and Directories

- `lib/main.dart`: Entry point of the application. Contains route configurations and app initialization.
- `lib/screens/`: Contains all the screen widgets for the app.
  - `auth/`: Authentication screens (Login & Register).
  - `home_screen/`: Home screen and its sub-screens.
  - `product_details_screen/`: Product details screen.
- `lib/widgets/`: Reusable UI components such as product tiles.
- `lib/models/`: Product Data model used in the app.
- `lib/providers/`: State management using Provider.
  - `theme_provider.dart`: Manages app themes.
  - `cart_provider.dart`: Manages cart items.
  - `saved_product_provider.dart`: Manages saved products.
  - `category_provider.dart`: Manages selceted category.
  - `profile_data_provider.dart`: Manages profile data.
- `lib/data/`: Contains hardcoded data for products.

### State Management

State management in this application is handled using the `Provider` package.
- `theme_provider.dart`: Manages the app's theme, allowing users to switch between light and dark modes and defaults to system theme.
- `cart_provider.dart`: Manages the user's cart, including adding, removing, and updating cart items and there quantities.
- `saved_product_provider.dart`: Manages the user's saved products, allowing them to save products for later.
- `profile_data_provider.dart`: Manages the user's profile data, such as name, mobile number, and profile picture.
- `bottom_nav_providor.dart`: Manages the bottom nav bar, allowing users to switch between screens.
- `category_providor.dart`: Manages the selected category, allowing users to browse products by category.

## Credits
Product data is hardcoded in the app. The data is made from [Flipkart.com](https://www.flipkart.com).

## Contributing

Contributions are welcome! Please create an issue first to discuss what you would like to change.

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/yourFeature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/yourFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---