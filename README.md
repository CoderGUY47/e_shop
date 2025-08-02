# E-Shop Flutter App

A modern, responsive e-commerce Flutter application that runs on both Android and web platforms.

## Features

### 🛍️ Product Management
- Browse products with beautiful grid layout
- Product categories and filtering
- Search functionality
- Product details with image gallery
- Product specifications and ratings

### 🛒 Shopping Cart
- Add/remove products from cart
- Quantity management
- Real-time cart updates
- Cart persistence across sessions

### 💳 Checkout Process
- Complete checkout form
- Order summary
- Form validation
- Order confirmation

### 🎨 Modern UI/UX
- Material Design 3
- Responsive layout
- Smooth animations
- Loading states
- Error handling

### 📱 Cross-Platform
- Android support
- Web browser support
- Responsive design for different screen sizes

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Chrome browser (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd e_shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**

   **For Web:**
   ```bash
   flutter run -d chrome
   ```

   **For Android:**
   ```bash
   flutter run -d android
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── product.dart         # Product model
│   └── cart_item.dart       # Cart item model
├── providers/               # State management
│   ├── product_provider.dart # Product state
│   └── cart_provider.dart   # Cart state
├── screens/                 # App screens
│   ├── home_screen.dart     # Home page
│   ├── cart_screen.dart     # Shopping cart
│   ├── product_detail_screen.dart # Product details
│   └── checkout_screen.dart # Checkout
├── widgets/                 # Reusable widgets
│   ├── product_card.dart    # Product display card
│   ├── category_chip.dart   # Category filter
│   └── search_bar.dart      # Search functionality
└── utils/                   # Utilities
    └── theme.dart           # App theme configuration
```

## Dependencies

- **provider**: State management
- **http**: HTTP requests (for future API integration)
- **shared_preferences**: Local storage
- **cached_network_image**: Image caching
- **flutter_staggered_grid_view**: Grid layouts
- **intl**: Internationalization

## Features in Detail

### Home Screen
- Product grid with search and filtering
- Category chips for easy navigation
- Featured products carousel
- Pull-to-refresh functionality

### Product Details
- Image gallery with page indicators
- Product specifications
- Quantity selector
- Add to cart functionality
- Rating and review display

### Shopping Cart
- List of cart items with quantity controls
- Real-time total calculation
- Remove items functionality
- Proceed to checkout option

### Checkout
- Shipping information form
- Order summary
- Form validation
- Order confirmation

## Customization

### Theme
The app uses a custom theme defined in `lib/utils/theme.dart`. You can modify:
- Colors (primary, secondary, accent)
- Typography
- Button styles
- Card styles

### Sample Data
Sample products are loaded in `lib/providers/product_provider.dart`. You can:
- Add more products
- Modify product details
- Change categories
- Update images

## Future Enhancements

- [ ] User authentication
- [ ] Payment integration
- [ ] Order history
- [ ] Wishlist functionality
- [ ] Product reviews
- [ ] Push notifications
- [ ] Offline support
- [ ] Multi-language support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please open an issue in the repository.
