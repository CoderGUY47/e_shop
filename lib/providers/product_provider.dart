import 'package:flutter/foundation.dart';
import 'package:e_shop/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  List<String> get categories {
    final categories = _products
        .map((product) => product.category)
        .toSet()
        .toList();
    categories.insert(0, 'All');
    return categories;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setProducts(List<Product> products) {
    _products = products;
    _applyFilters();
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  List<Product> getFeaturedProducts() {
    return _products.where((product) => product.rating >= 4.0).take(6).toList();
  }

  void loadSampleProducts() {
    setLoading(true);

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final sampleProducts = [
        // Headphones Products
        Product(
          id: '1',
          name: 'Wireless Bluetooth Headphones',
          description:
              'High-quality wireless headphones with noise cancellation and 30-hour battery life.',
          price: 89.99,
          imageUrl: 'assets/images/headphone.jpg',
          category: 'Electronics',
          rating: 4.5,
          reviewCount: 128,
          inStock: true,
          images: [
            'assets/images/headphone.jpg',
            'assets/images/headphone1.jpg',
            'assets/images/headphone2.jpg',
            'assets/images/headphone3.jpg',
            'assets/images/headphone4.jpg',
            'assets/images/headphone5.jpg',
          ],
          specifications: {
            'Brand': 'AudioTech',
            'Connectivity': 'Bluetooth 5.0',
            'Battery Life': '30 hours',
            'Weight': '250g',
          },
        ),
        Product(
          id: '2',
          name: 'Premium Noise Cancelling Headphones',
          description:
              'Professional-grade headphones with active noise cancellation.',
          price: 199.99,
          imageUrl: 'assets/images/headphone1.jpg',
          category: 'Electronics',
          rating: 4.7,
          reviewCount: 89,
          inStock: true,
          images: [
            'assets/images/headphone1.jpg',
            'assets/images/headphone2.jpg',
            'assets/images/headphone3.jpg',
            'assets/images/headphone4.jpg',
            'assets/images/headphone5.jpg',
          ],
          specifications: {
            'Brand': 'SoundMaster',
            'Connectivity': 'Bluetooth 5.2',
            'Battery Life': '40 hours',
            'Weight': '280g',
          },
        ),
        Product(
          id: '3',
          name: 'Sport Wireless Headphones',
          description:
              'Sweat-resistant headphones perfect for workouts and outdoor activities.',
          price: 79.99,
          imageUrl: 'assets/images/headphone2.jpg',
          category: 'Electronics',
          rating: 4.3,
          reviewCount: 156,
          inStock: true,
          images: [
            'assets/images/headphone2.jpg',
            'assets/images/headphone3.jpg',
            'assets/images/headphone4.jpg',
            'assets/images/headphone5.jpg',
          ],
          specifications: {
            'Brand': 'FitAudio',
            'Connectivity': 'Bluetooth 5.0',
            'Battery Life': '25 hours',
            'Water Resistance': 'IPX4',
          },
        ),
        Product(
          id: '19',
          name: 'Sport Wireless Headphones',
          description:
              'Sweat-resistant headphones perfect for workouts and outdoor activities.',
          price: 79.99,
          imageUrl: 'assets/images/headphone3.jpg',
          category: 'Electronics',
          rating: 4.3,
          reviewCount: 156,
          inStock: true,
          images: [
            'assets/images/headphone2.jpg',
            'assets/images/headphone3.jpg',
            'assets/images/headphone4.jpg',
            'assets/images/headphone5.jpg',
          ],
          specifications: {
            'Brand': 'FitAudio',
            'Connectivity': 'Bluetooth 5.0',
            'Battery Life': '25 hours',
            'Water Resistance': 'IPX4',
          },
        ),
        Product(
          id: '20',
          name: 'Sport Wireless Headphones',
          description:
              'Sweat-resistant headphones perfect for workouts and outdoor activities.',
          price: 79.99,
          imageUrl: 'assets/images/headphone4.jpg',
          category: 'Electronics',
          rating: 4.3,
          reviewCount: 156,
          inStock: true,
          images: [
            'assets/images/headphone2.jpg',
            'assets/images/headphone3.jpg',
            'assets/images/headphone4.jpg',
            'assets/images/headphone5.jpg',
          ],
          specifications: {
            'Brand': 'FitAudio',
            'Connectivity': 'Bluetooth 5.0',
            'Battery Life': '25 hours',
            'Water Resistance': 'IPX4',
          },
        ),
        Product(
          id: '21',
          name: 'Sport Wireless Headphones',
          description:
              'Sweat-resistant headphones perfect for workouts and outdoor activities.',
          price: 79.99,
          imageUrl: 'assets/images/headphone5.jpg',
          category: 'Electronics',
          rating: 4.3,
          reviewCount: 156,
          inStock: true,
          images: [
            'assets/images/headphone2.jpg',
            'assets/images/headphone3.jpg',
            'assets/images/headphone4.jpg',
            'assets/images/headphone5.jpg',
          ],
          specifications: {
            'Brand': 'FitAudio',
            'Connectivity': 'Bluetooth 5.0',
            'Battery Life': '25 hours',
            'Water Resistance': 'IPX4',
          },
        ),

        // Smart Watches Products
        Product(
          id: '4',
          name: 'Smart Fitness Watch',
          description:
              'Advanced fitness tracking with heart rate monitor and GPS.',
          price: 199.99,
          imageUrl: 'assets/images/watch.jpg',
          category: 'Electronics',
          rating: 4.3,
          reviewCount: 89,
          inStock: true,
          images: [
            'assets/images/watch.jpg',
            'assets/images/watch1.jpg',
            'assets/images/watch2.jpg',
            'assets/images/watch3.jpg',
            'assets/images/watch4.jpg',
            'assets/images/watch5.jpg',
          ],
          specifications: {
            'Brand': 'FitTech',
            'Display': '1.4" AMOLED',
            'Battery Life': '7 days',
            'Water Resistance': '5ATM',
          },
        ),
        Product(
          id: '5',
          name: 'Premium Smart Watch',
          description:
              'Luxury smartwatch with premium materials and advanced features.',
          price: 399.99,
          imageUrl: 'assets/images/watch1.jpg',
          category: 'Electronics',
          rating: 4.8,
          reviewCount: 67,
          inStock: true,
          images: [
            'assets/images/watch1.jpg',
            'assets/images/watch2.jpg',
            'assets/images/watch3.jpg',
            'assets/images/watch4.jpg',
            'assets/images/watch5.jpg',
          ],
          specifications: {
            'Brand': 'LuxWatch',
            'Display': '1.6" Retina',
            'Battery Life': '5 days',
            'Material': 'Stainless Steel',
          },
        ),
        Product(
          id: '6',
          name: 'Sport Smart Watch',
          description:
              'Rugged smartwatch designed for extreme sports and outdoor activities.',
          price: 149.99,
          imageUrl: 'assets/images/watch2.jpg',
          category: 'Electronics',
          rating: 4.2,
          reviewCount: 234,
          inStock: true,
          images: [
            'assets/images/watch2.jpg',
            'assets/images/watch3.jpg',
            'assets/images/watch4.jpg',
            'assets/images/watch5.jpg',
          ],
          specifications: {
            'Brand': 'SportTech',
            'Display': '1.3" LCD',
            'Battery Life': '10 days',
            'Water Resistance': '10ATM',
          },
        ),

        // T-Shirts Products
        Product(
          id: '7',
          name: 'Organic Cotton T-Shirt',
          description:
              'Comfortable and eco-friendly cotton t-shirt available in multiple colors.',
          price: 24.99,
          imageUrl: 'assets/images/tshirt.jpg',
          category: 'Clothing',
          rating: 4.7,
          reviewCount: 256,
          inStock: true,
          images: [
            'assets/images/tshirt.jpg',
            'assets/images/tshirt1.jpg',
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
          specifications: {
            'Material': '100% Organic Cotton',
            'Fit': 'Regular',
            'Care': 'Machine washable',
            'Sizes': 'XS, S, M, L, XL',
          },
        ),
        Product(
          id: '8',
          name: 'Premium Cotton T-Shirt',
          description:
              'High-quality cotton t-shirt with superior comfort and durability.',
          price: 34.99,
          imageUrl: 'assets/images/tshirt1.jpg',
          category: 'Clothing',
          rating: 4.6,
          reviewCount: 189,
          inStock: true,
          images: [
            'assets/images/tshirt1.jpg',
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
          specifications: {
            'Material': 'Premium Cotton',
            'Fit': 'Slim',
            'Care': 'Cold wash',
            'Sizes': 'S, M, L, XL, XXL',
          },
        ),
        Product(
          id: '9',
          name: 'Graphic Print T-Shirt',
          description:
              'Stylish t-shirt with unique graphic designs and modern fit.',
          price: 29.99,
          imageUrl: 'assets/images/tshirt2.jpg',
          category: 'Clothing',
          rating: 4.4,
          reviewCount: 167,
          inStock: true,
          images: [
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
          specifications: {
            'Material': 'Cotton Blend',
            'Fit': 'Modern',
            'Care': 'Machine washable',
            'Sizes': 'XS, S, M, L, XL',
          },
        ),
        Product(
          id: '15',
          name: 'Graphic Print T-Shirt',
          description:
              'Stylish t-shirt with unique graphic designs and modern fit.',
          price: 29.99,
          imageUrl: 'assets/images/tshirt3.jpg',
          category: 'Clothing',
          rating: 4.4,
          reviewCount: 167,
          inStock: true,
          images: [
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
        ),
        Product(
          id: '16',
          name: 'Graphic Print T-Shirt',
          description:
              'Stylish t-shirt with unique graphic designs and modern fit.',
          price: 29.99,
          imageUrl: 'assets/images/tshirt4.jpg',
          category: 'Clothing',
          rating: 4.4,
          reviewCount: 167,
          inStock: true,
          images: [
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
        ),
        Product(
          id: '17',
          name: 'Graphic Print T-Shirt',
          description:
              'Stylish t-shirt with unique graphic designs and modern fit.',
          price: 29.99,
          imageUrl: 'assets/images/tshirt5.jpg',
          category: 'Clothing',
          rating: 4.4,
          reviewCount: 167,
          inStock: true,
          images: [
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
        ),
        Product(
          id: '18',
          name: 'Graphic Print T-Shirt',
          description:
              'Stylish t-shirt with unique graphic designs and modern fit.',
          price: 29.99,
          imageUrl: 'assets/images/tshirt6.jpg',
          category: 'Clothing',
          rating: 4.4,
          reviewCount: 167,
          inStock: true,
          images: [
            'assets/images/tshirt2.jpg',
            'assets/images/tshirt3.jpg',
            'assets/images/tshirt4.jpg',
            'assets/images/tshirt5.jpg',
            'assets/images/tshirt6.jpg',
          ],
        ),

        // Water Bottles Products
        Product(
          id: '10',
          name: 'Stainless Steel Water Bottle',
          description:
              'Insulated water bottle that keeps drinks cold for 24 hours.',
          price: 34.99,
          imageUrl: 'assets/images/bottle.jpg',
          category: 'Home & Garden',
          rating: 4.6,
          reviewCount: 189,
          inStock: true,
          images: [
            'assets/images/bottle.jpg',
            'assets/images/bottle1.jpg',
            'assets/images/bottle2.jpg',
            'assets/images/bottle3.jpg',
            'assets/images/bottle4.jpg',
            'assets/images/bottle5.jpg',
          ],
          specifications: {
            'Capacity': '32 oz',
            'Material': 'Stainless Steel',
            'Insulation': 'Double-wall vacuum',
            'Lid Type': 'Screw-on',
          },
        ),
        Product(
          id: '11',
          name: 'Premium Insulated Bottle',
          description:
              'High-end insulated bottle with advanced temperature control.',
          price: 49.99,
          imageUrl: 'assets/images/bottle1.jpg',
          category: 'Home & Garden',
          rating: 4.8,
          reviewCount: 145,
          inStock: true,
          images: [
            'assets/images/bottle1.jpg',
            'assets/images/bottle2.jpg',
            'assets/images/bottle3.jpg',
            'assets/images/bottle4.jpg',
            'assets/images/bottle5.jpg',
          ],
          specifications: {
            'Capacity': '40 oz',
            'Material': 'Premium Steel',
            'Insulation': 'Triple-wall vacuum',
            'Lid Type': 'Flip-top',
          },
        ),
        Product(
          id: '12',
          name: 'Compact Travel Bottle',
          description:
              'Lightweight and compact bottle perfect for travel and daily use.',
          price: 24.99,
          imageUrl: 'assets/images/bottle2.jpg',
          category: 'Home & Garden',
          rating: 4.3,
          reviewCount: 278,
          inStock: true,
          images: [
            'assets/images/bottle2.jpg',
            'assets/images/bottle3.jpg',
            'assets/images/bottle4.jpg',
            'assets/images/bottle5.jpg',
          ],
          specifications: {
            'Capacity': '20 oz',
            'Material': 'Aluminum',
            'Insulation': 'Single-wall',
            'Lid Type': 'Push-pull',
          },
        ),
        Product(
          id: '13',
          name: 'Compact Travel Bottle',
          description:
              'Lightweight and compact bottle perfect for travel and daily use.',
          price: 24.99,
          imageUrl: 'assets/images/bottle3.jpg',
          category: 'Home & Garden',
          rating: 4.3,
          reviewCount: 278,
          inStock: true,
          images: [
            'assets/images/bottle3.jpg',
            'assets/images/bottle4.jpg',
            'assets/images/bottle5.jpg',
          ],
          specifications: {
            'Capacity': '20 oz',
            'Material': 'Aluminum',
            'Insulation': 'Single-wall',
            'Lid Type': 'Push-pull',
          },
        ),
        Product(
          id: '14',
          name: 'Compact Travel Bottle',
          description:
              'Lightweight and compact bottle perfect for travel and daily use.',
          price: 24.99,
          imageUrl: 'assets/images/bottle4.jpg',
          category: 'Home & Garden',
          rating: 4.3,
          reviewCount: 278,
          inStock: true,
          images: [
            'assets/images/bottle4.jpg',
            'assets/images/bottle5.jpg',
          ],
          specifications: {
            'Capacity': '20 oz',
            'Material': 'Aluminum',
            'Insulation': 'Single-wall',
            'Lid Type': 'Push-pull',
          },
        ),
      ];

      setProducts(sampleProducts);
      setLoading(false);
    });
  }
}
