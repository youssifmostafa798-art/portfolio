import 'package:flutter/material.dart';

class HungryyCardItem {
  final String title;
  final String description;
  final IconData? icon;
  const HungryyCardItem(this.title, this.description, {this.icon});
}

class HungryyProblemSolution {
  final String title;
  final String problem;
  final String solution;
  const HungryyProblemSolution(this.title, this.problem, this.solution);
}

class HungryyArchitectureLayer {
  final String name;
  final String detail;
  final Color? color;
  const HungryyArchitectureLayer(this.name, this.detail, {this.color});
}

class HungryyPlaceholderItem {
  final String label;
  final Color color;
  const HungryyPlaceholderItem(this.label, this.color);
}

class HungryyData {
  const HungryyData();

  String get id => 'hungryy';
  String get title => 'Hungryy';
  String get tagline => 'Food Ordering Application';
  String get role => 'Flutter Mobile Application Developer';
  String get status => 'Complete';
  String get teamSize => '1';
  String get timeline => '2025';
  String get githubUrl => 'https://github.com/youssifmostafa798-art/hungryy';

  List<String> get techStackTop => const [
    'Flutter',
    'Dart',
    'Provider',
    'Dio',
    'REST API',
    'SharedPreferences',
  ];

  List<String> get techStack => const [
    'Flutter',
    'Dart',
    'Provider',
    'Dio',
    'REST API',
    'SharedPreferences',
    'Image Picker',
    'Flutter SVG',
    'Lottie',
    'Skeletonizer',
    'Clean Architecture',
    'Repository Pattern',
  ];

  String get heroDescription =>
      'A production-grade food ordering application built entirely in Flutter — '
      'featuring real-time product browsing, dynamic cart management, multi-step '
      'checkout, user authentication with persistent sessions, and a '
      'glassmorphism-driven UI system.';

  String get overviewBody =>
      'Hungryy is a fast-food ordering application that connects users to a '
      'RESTful backend API. Users can browse a menu of food products organized '
      'by category, customize their orders with toppings and side options, '
      'manage a shopping cart with real-time price calculations, and complete '
      'checkout with animated order confirmation. The application supports full '
      'user authentication (login, signup, guest mode, auto-login), profile '
      'management with image upload, and persistent session handling via JWT tokens.';

  String get businessProblemBody =>
      'Food ordering applications have become a core part of the modern dining '
      'experience. Users expect fast, intuitive interfaces that let them browse '
      'menus, customize orders, and checkout in seconds. Building such an '
      'application requires solving several engineering challenges simultaneously:';

  List<String> get businessProblemPoints => const [
        'Managing asynchronous API calls for products, toppings, and side options while keeping the UI responsive',
        'Handling authentication state across app restarts with token persistence',
        'Implementing a cart system that calculates taxes, delivery fees, and totals in real-time',
        'Creating a visually distinctive UI that stands apart from generic Material templates',
        'Organizing code in a way that scales as features are added',
      ];

  String get solutionBody =>
      'The application is built on a layered architecture with clear separation '
      'of concerns: UI Layer (Screens and widgets that consume state and render '
      'the interface), State Management (Provider-based reactive state using '
      'ChangeNotifier), Repository Layer (AuthRepo and ProductRepo that orchestrate '
      'API calls and data transformation), Service Layer (ApiService providing '
      'generic CRUD operations over Dio), Network Layer (DioClient with base URL '
      'configuration and JWT auth interceptor), and Storage Layer (SharedPreferences '
      'for token persistence). Each feature is organized into its own module under '
      'lib/features/ with dedicated data, screens, and widget subfolders.';

  String get stateManagementBody =>
      'The application uses Provider with ChangeNotifier for state management. '
      'A single CartProvider is initialized at the app root via '
      'ChangeNotifierProvider in main.dart and is accessible throughout the '
      'widget tree. CartProvider holds an internal List<FoodItem> representing '
      'cart items, with computed properties for itemCount, subtotal, tax (5%), '
      'deliveryFee (3.50 dollars), and total. All mutations call notifyListeners() to '
      'trigger UI rebuilds. Screens use context.watch for reactive rebuilds and '
      'context.read for one-shot method calls. All other screen-level state '
      '(loading, error, search query, selected category, form inputs) is '
      'managed via setState() in StatefulWidget classes.';

  String get repositoryBody =>
      'AuthRepo is the single source of truth for all authentication-related '
      'operations: login (POSTs to /login, parses UserModel, stores JWT), '
      'signup (POSTs to /register, handles 200/201 codes), getProfileData '
      '(GETs /profile), updateProfileData (POSTs multipart FormData to '
      '/update-profile), logout (POSTs /logout, clears token), autoLogin '
      '(checks stored token, fetches profile), and continueAsGuest (stores '
      'guest token). ProductRepo handles all product-related API calls: '
      'getProducts (GETs /products), getToppings (GETs /toppings), and '
      'getOption (GETs /side-options).';

  String get networkingBody =>
      'DioClient configures the Dio HTTP client with base URL '
      '(https://sonic-zdi0.onrender.com/api), JSON content type headers, '
      'and an auth interceptor that reads the stored token from '
      'PrefHelper.getToken() and attaches Authorization: Bearer token to '
      'every request (skipping for null or guest tokens). ApiService wraps '
      'DioClient with four generic CRUD methods (get, post, put, delete), '
      'each catching DioException and delegating to ApiExceptions.handleError(). '
      'ApiExceptions maps DioException types to user-friendly messages: '
      'connectionTimeout, sendTimeout, receiveTimeout, HTTP 302 (Email Already '
      'Taken), and a default unexpected error.';

  String get authenticationBody =>
      'The authentication flow supports four modes: Login (email/password with '
      'form validation via regex and minimum length), Signup (name, email, '
      'password with server-side validation), Guest Mode (bypasses auth by '
      'storing guest as the token), and Auto-Login (checks stored JWT on '
      'startup, fetches profile if valid, falls back to login screen). Token '
      'management uses PrefHelper wrapping SharedPreferences with save/get/clear '
      'methods under the key auth_token. The Dio interceptor automatically '
      'attaches the token to every outgoing request.';

  String get sharedPreferencesBody =>
      'PrefHelper provides a minimal wrapper around SharedPreferences: '
      'saveToken(String token) stores the JWT (or guest) under the key '
      'auth_token, getToken() retrieves the stored token or null, and '
      'clearToken() removes the token from storage. Each method creates its '
      'own SharedPreferences.getInstance() call — a deliberate choice for '
      'simplicity at this application scale.';

  String get productCustomizationBody =>
      'The product detail screen implements a comprehensive customization '
      'system: Spicy Level Selector (Slider with divisions: 4 producing values '
      '1-5 with chili emoji indicators), Toppings (multi-select fetched from '
      '/toppings endpoint, stored in Set<int> for O(1) lookup), Side Options '
      '(single-select fetched from /side-options endpoint), Quantity Control '
      '(increment/decrement with min 1), and Add to Cart (calculates total '
      'price, calls CartProvider.addItem(), shows floating SnackBar confirmation).';

  String get cartManagementBody =>
      'CartProvider implements the cart system as a ChangeNotifier with: '
      'items (List.unmodifiable to prevent external mutation), itemCount (sum '
      'of all quantities), subtotal (sum of price * quantity), tax (5% of '
      'subtotal), deliveryFee (3.50 dollars if subtotal > 0, else 0), and total '
      '(subtotal + tax + deliveryFee). Cart operations include addItem (checks '
      'by ID, increments or adds new), increment/decrement (with auto-remove '
      'at zero), remove, and clear. All price calculations are computed '
      'properties that recalculate on every access.';

  String get checkoutBody =>
      'The checkout process includes: Order Summary (line items with emoji, '
      'name, quantity, line total), Financial Breakdown (subtotal, 5% tax, '
      '3.50 dollars delivery fee, grand total), Estimated Delivery card (15-20 min), '
      'Payment Selection (toggle between Cash on Delivery and Visa), Save Card '
      'option, and Pay Now (clears cart via CartProvider.clear(), navigates to '
      'SuccessScreen using pushAndRemoveUntil). The success screen features an '
      'animated checkmark with elastic scale, fade-in text, delivery estimate '
      'card, and Back to Home button.';

  String get navigationBody =>
      'Root uses a PageView with NeverScrollableScrollPhysics (disabling swipe) '
      'controlled by a GlassBottomNavBar. Three screens are embedded: HomeScreen, '
      'CartScreen, and ProfileScreen. The PageController animates between pages '
      'with Curves.easeOutExpo over 300ms. The GlassBottomNavBar provides four '
      'tabs with animated icon transitions using AnimationController with '
      'AnimatedIcons. Screen transitions use MaterialPageRoute for standard pushes, '
      'pushAndRemoveUntil for success/checkout flows, and pushReplacement for logout.';

  String get responsiveUIBody =>
      'The product grid uses SliverGridDelegateWithFixedCrossAxisCount with '
      'crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, and '
      'childAspectRatio: 0.78. The search bar uses a full-width TextField with '
      'custom decoration. Category pills render in a horizontal '
      'SingleChildScrollView for overflow handling. Cart items use '
      'ListView.separated for efficient scrolling. Profile form uses '
      'SingleChildScrollView with Clip.none and RefreshIndicator for pull-to-refresh.';

  String get glassmorphismBody =>
      'The GlassBottomNavBar is the centerpiece: BackdropFilter with '
      'ImageFilter.blur(sigmaX: 50, sigmaY: 80) creates the frosted glass effect, '
      'semi-transparent white container (Colors.white.withOpacity(0.1)) with rounded '
      'corners, animated pill indicator (circular gradient container sliding between '
      'tabs), and animated icons switching between outlined and filled states. '
      'GlassContainer is a reusable frosted glass wrapper used on auth screens with '
      'green gradient background and BackdropFilter blur.';

  String get reusableComponentsBody =>
      'Component Library (lib/component/): CustomText (fully customizable text '
      'widget with all TextStyle properties), CustomButton (generic tap target '
      'with configurable styling), CustomTxtfield (auth-styled TextFormField with '
      'password toggle), CustomSnack (factory function returning styled SnackBar), '
      'GlassContainer (frosted glass container function), GlassBottomNavBar (animated '
      'bottom navigation with glassmorphism). Shared Widgets (lib/widget/): '
      'PrimaryButton, QtyControl, CategoryPill, SectionTitle, PaymentTile.';

  String get modelsBody =>
      'FoodItem: core data model with id, name, category, price, rating, emoji, '
      'description, imageUrl, quantity, and copyWith() for immutable updates. '
      'ProductModel: API response model with computed properties (priceValue, '
      'ratingValue, imageUrl via normalizedImageUrl for HTTP-to-HTTPS conversion, '
      'category via keyword matching, fallbackEmoji via keyword matching, '
      'toFoodItem() converter). ToppingModel: id, name, image with '
      'normalizedImageUrl. UserModel: name, email, image, token, address, visa '
      'with null string handling.';

  String get validationBody =>
      'Login Form: email required with regex validation '
      '(r^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}\$), password required with '
      'minimum 6 characters. Signup Form: name, email, password required with '
      'same validation. Profile Form uses TextField (not TextFormField) with '
      'server-side validation. Errors display via TextFormField built-in error '
      'styling with red text at 11px.';

  String get imageLoadingBody =>
      'Network Images: Flutter built-in Image.network() with loadingBuilder '
      '(centered CircularProgressIndicator) and errorBuilder (emoji fallback or '
      'broken image icon). HTTP to HTTPS Normalization: normalizedImageUrl getter '
      'in ProductModel and ToppingModel converts http:// to https://. Emoji '
      'Fallback: fallbackEmoji getter uses keyword matching (juice maps to smoothie emoji, '
      'chicken maps to poultry emoji, burger maps to burger emoji, combo maps to bento emoji, '
      'default maps to plate emoji). Profile Images: three '
      'states — selected local image (Image.file), API image (Image.network with '
      'error fallback), no image (Icon placeholder).';

  String get skeletonLoadingBody =>
      'The home screen implements skeleton loading using the skeletonizer package. '
      'Six skeleton product cards are generated with placeholder data (Loading '
      'product, Loading description, price 0, rating 0). The Skeletonizer '
      'widget automatically applies shimmer effects to all child widgets, creating '
      'a cohesive loading state that matches the actual product card layout.';

  String get loadingStatesBody =>
      'Every data-driven screen implements three states: Loading State (home screen '
      'skeleton loading, product detail loading indicators for toppings/options, '
      'profile skeletonizer), Error State (home screen cloud-off icon with retry '
      'button, auth SnackBar with error message, profile SnackBar), and Empty State '
      '(home No items found, cart Your cart is empty, toppings No toppings '
      'available).';

  String get errorHandlingBody =>
      'Network Errors: ApiExceptions.handleError() catches all DioException types '
      'and maps to user-friendly messages. API Errors: repositories catch and '
      'transform to ApiError objects. Screen-Level: try-catch blocks update local '
      'loading/error state. Mounted Checks: all async operations in StatefulWidget '
      'check if (!mounted) return before calling setState().';

  String get performanceBody =>
      'Unmodifiable Lists: CartProvider.items returns List.unmodifiable(). '
      'Immutable Model Updates: FoodItem.copyWith() creates new instances. '
      'Efficient Filtering: _filteredProducts computed as getter (efficient for '
      'expected catalog size). Image Loading: loadingBuilder and errorBuilder for '
      'graceful degradation. Animation Controllers: all properly disposed in '
      'dispose(). PageView with NeverScrollableScrollPhysics prevents accidental '
      'page changes.';

  String get technicalDecisionsBody =>
      'Provider Over BLoC/Riverpod: for a single cross-screen state (cart), '
      'Provider provides the right simplicity level. Feature-Based Folder Structure: '
      'organizing by feature rather than type makes feature location easier. '
      'Repository Pattern: abstracts API calls from UI for backend swapping and '
      'testability. Dio Over http: chosen for interceptor system, timeout config, '
      'and richer error types. Glassmorphism Over Standard Material: using '
      'BackdropFilter keeps implementation dependency-free. Emoji Fallbacks: '
      'ensures UI always has visual content. CopyWith Pattern: enables immutable '
      'updates for cart operations.';

  List<HungryyArchitectureLayer> get architectureLayers => const [
        HungryyArchitectureLayer(
          'UI Layer (Screens)',
          'home_screen, product_detail_screen, cart_screen — consumes providers, calls repositories',
        ),
        HungryyArchitectureLayer(
          'State Management (Provider)',
          'CartProvider (ChangeNotifier) — holds cart state, exposes computed values',
        ),
        HungryyArchitectureLayer(
          'Repository Layer',
          'AuthRepo, ProductRepo — orchestrates API calls, transforms data',
        ),
        HungryyArchitectureLayer(
          'Service Layer (Network)',
          'ApiService → DioClient → Dio — generic CRUD, auth interceptor, error handling',
        ),
        HungryyArchitectureLayer(
          'Remote API (REST)',
          'https://sonic-zdi0.onrender.com/api',
        ),
      ];

  List<HungryyCardItem> get folderStructureItems => const [
        HungryyCardItem('main.dart', 'App entry point, Provider setup, theme configuration'),
        HungryyCardItem('root.dart', 'Root scaffold with PageView + glass navigation bar'),
        HungryyCardItem('splash_screen.dart', 'Animated splash with auto-login check'),
        HungryyCardItem('component/', 'Reusable widgets: GlassNav, buttons, text, text fields, snack bar'),
        HungryyCardItem('core/network/', 'DioClient, ApiService, ApiExceptions, ApiError'),
        HungryyCardItem('core/utils/', 'PrefHelper — SharedPreferences token CRUD'),
        HungryyCardItem('features/auth/', 'Login, Signup, Profile screens + AuthRepo + UserModel'),
        HungryyCardItem('features/cart/', 'CartScreen with quantity controls'),
        HungryyCardItem('features/checkout/', 'CheckoutScreen + SuccessScreen with animation'),
        HungryyCardItem('features/home/', 'HomeScreen + ProductRepo + ProductModel + ToppingModel'),
        HungryyCardItem('features/productDetail/', 'ProductDetailScreen with customization'),
        HungryyCardItem('models/', 'CartProvider + FoodItem shared across features'),
        HungryyCardItem('theme/', 'AppColors + ThemeData definition'),
        HungryyCardItem('widget/', 'PrimaryButton, QtyControl, CategoryPill, PaymentTile'),
      ];

  List<HungryyCardItem> get coreFeatureItems => const [
        HungryyCardItem(
          'Authentication Module',
          'Email/password login with validation, user registration, guest mode for anonymous browsing, auto-login on startup via stored JWT token, profile management with image upload, logout with session cleanup.',
          icon: Icons.verified_user_rounded,
        ),
        HungryyCardItem(
          'Product Browsing',
          '2-column responsive product grid from /products API, category filtering across 7 categories, real-time text search, skeleton loading with shimmer effect, error state with retry, empty state with message.',
          icon: Icons.storefront_rounded,
        ),
        HungryyCardItem(
          'Product Customization',
          'Hero image with network/emoji fallback, spicy level slider (1-5), multi-select toppings from /toppings API, single-select side options from /side-options API, quantity control, live price calculation.',
          icon: Icons.tune_rounded,
        ),
        HungryyCardItem(
          'Cart Management',
          'Cart list with emoji/name/quantity/line total, inline quantity adjustment with auto-remove, real-time total with subtotal + 5% tax + delivery fee, item count badge, empty cart state.',
          icon: Icons.shopping_cart_rounded,
        ),
        HungryyCardItem(
          'Checkout & Order',
          'Order summary with line items, financial breakdown, estimated delivery (15-20 min), payment selection (Cash/Visa), animated success screen with elastic checkmark, Back to Home navigation.',
          icon: Icons.receipt_long_rounded,
        ),
        HungryyCardItem(
          'Profile Management',
          'Profile photo with gallery upload via ImagePicker, editable name/email/address/VISA fields, VISA card display with gradient, pull-to-refresh, skeleton loading, guest mode fallback.',
          icon: Icons.person_rounded,
        ),
      ];

  List<HungryyPlaceholderItem> get screenshotPlaceholders => const [
        HungryyPlaceholderItem('Hero Screenshot', Color(0xFF1B4D2E)),
        HungryyPlaceholderItem('Login Screen', Color(0xFF2D6A4F)),
        HungryyPlaceholderItem('Home Screen', Color(0xFF52B788)),
        HungryyPlaceholderItem('Product Details', Color(0xFF1B4D2E)),
        HungryyPlaceholderItem('Cart Screen', Color(0xFF2D6A4F)),
        HungryyPlaceholderItem('Checkout Screen', Color(0xFF52B788)),
        HungryyPlaceholderItem('Profile Screen', Color(0xFF1B4D2E)),
        HungryyPlaceholderItem('Architecture Diagram', Color(0xFF2D6A4F)),
        HungryyPlaceholderItem('User Flow Diagram', Color(0xFF52B788)),
        HungryyPlaceholderItem('Component Showcase', Color(0xFF1B4D2E)),
      ];

  List<HungryyCardItem> get reusableComponentItems => const [
        HungryyCardItem('CustomText', 'Fully customizable text widget exposing all TextStyle properties. Uses TextScaler.linear(1.0) to prevent system font scaling.'),
        HungryyCardItem('CustomButton', 'Generic tap target with configurable width, height, color, border radius, text color, and optional child widget.'),
        HungryyCardItem('CustomTxtfield', 'Auth-styled TextFormField with password toggle (eye icon), custom decoration (enabled/focused/error borders), and validator support.'),
        HungryyCardItem('CustomSnack', 'Factory function returning a styled floating SnackBar with icon and error message. Red background with rounded corners.'),
        HungryyCardItem('GlassContainer', 'Function returning a frosted glass container with gradient and blur. Used as background wrapper for auth screens.'),
        HungryyCardItem('GlassBottomNavBar', 'Animated bottom navigation bar with glassmorphism, pill indicator, and animated icons.'),
        HungryyCardItem('PrimaryButton', 'Full-width ElevatedButton with optional icon. Used for checkout, retry, and primary actions.'),
        HungryyCardItem('QtyControl', 'Quantity selector with minus/plus buttons and count display. Used in cart and product detail.'),
        HungryyCardItem('CategoryPill', 'Horizontal pill-shaped category filter with animated selection (color transition).'),
        HungryyCardItem('PaymentTile', 'Payment method selector with icon, label, and radio-style indicator with animated borders.'),
      ];

  List<HungryyCardItem> get modelItems => const [
        HungryyCardItem('FoodItem', 'Core cart model: id, name, category, price, rating, emoji, description, imageUrl, quantity. Implements copyWith() for immutable updates.'),
        HungryyCardItem('ProductModel', 'API model with computed properties: priceValue, ratingValue, normalizedImageUrl (HTTP to HTTPS), category (keyword matching), fallbackEmoji, toFoodItem() converter.'),
        HungryyCardItem('ToppingModel', 'Topping/side model: id, name, image with normalizedImageUrl getter for HTTP-to-HTTPS conversion.'),
        HungryyCardItem('UserModel', 'User model: name, email, image, token, address, visa. Handles null string from API by converting to actual null.'),
      ];

  List<HungryyProblemSolution> get challenges => const [
        HungryyProblemSolution(
          'API Response Format Inconsistencies',
          'The backend returns prices and ratings as strings rather than numbers, requiring parsing in the model layer. Some fields return the string null instead of actual null.',
          'Robust parsing with int.tryParse, double.tryParse, and _stringValue() helper. The null string case is explicitly checked in UserModel.fromJson().',
        ),
        HungryyProblemSolution(
          'HTTP to HTTPS Image URLs',
          'The API returns some image URLs with http:// protocol, causing mixed-content issues on iOS.',
          'normalizedImageUrl getter in ProductModel and ToppingModel replaces http:// with https:// at the model level.',
        ),
        HungryyProblemSolution(
          'Token Management Across Screens',
          'Multiple screens and repositories need access to the auth token, but SharedPreferences is asynchronous.',
          'DioClient interceptor reads the token on every request, ensuring it is always fresh. Repositories do not need to pass tokens explicitly.',
        ),
        HungryyProblemSolution(
          'Cart State Synchronization',
          'Cart state needs to be accessible from HomeScreen, CartScreen, CheckoutScreen, and ProductDetailScreen simultaneously.',
          'A single CartProvider at the app root makes cart state available everywhere via context.watch and context.read.',
        ),
        HungryyProblemSolution(
          'Navigation Stack Management',
          'After checkout, the user should return to the home screen, not the checkout or cart screen.',
          'pushAndRemoveUntil with appropriate route predicates clears the navigation stack to the desired point.',
        ),
      ];

  List<HungryyProblemSolution> get problemsFaced => const [
        HungryyProblemSolution(
          'Debug Credentials in Login Screen',
          'The login screen had pre-filled email and password for development purposes that remained in the codebase.',
          'Identified in the README as a known debug artifact to be removed before production release.',
        ),
        HungryyProblemSolution(
          'Nunito Font Not Bundled',
          'The theme declares fontFamily Nunito but no font files are present in the assets directory.',
          'The app falls back to the system font. Listed as a future improvement to bundle the font files.',
        ),
        HungryyProblemSolution(
          'Lottie Animations Not Integrated',
          'Lottie JSON files exist in assets/lottie/ but are not rendered in any screen.',
          'Listed as a future improvement to integrate animations into auth and home screens.',
        ),
        HungryyProblemSolution(
          '3D Model Not Rendered',
          'GLB files exist in assets/3dModel/ but no Dart widget renders them.',
          'Listed as a future improvement to integrate model_viewer or flutter_cube.',
        ),
      ];

  List<String> get lessonsLearned => const [
        'Architecture Planning Pays Off: Defining the folder structure and data flow before writing code prevented major refactoring later. The feature-based organization made it easy to add new screens and models without breaking existing code.',
        'Error Handling Must Be Comprehensive: Every API call can fail. Wrapping all network operations in try-catch blocks and providing meaningful error messages to the user is essential for a production-quality application.',
        'Model Design Drives the Application: The ProductModel and FoodItem models were designed with computed properties (priceValue, imageUrl, fallbackEmoji, category) that encapsulate business logic. This kept screen code clean and focused on presentation.',
        'Reusable Components Save Time: Investing in CustomText, PrimaryButton, QtyControl, and other shared widgets early eliminated duplication across screens and made UI changes propagate automatically.',
        'State Management Should Match Scope: Provider was the right choice for this application. Over-engineering with BLoC or Riverpod would have added complexity without proportional benefits.',
      ];

  List<String> get skillsDemonstrated => const [
        'Flutter Development — Complete application built with Flutter SDK 3.10.1+',
        'Dart Programming — Strong typing, async/await, collections, mixins, extension-like patterns',
        'Architecture Design — Layered architecture with repository pattern and feature-based organization',
        'State Management — Provider with ChangeNotifier for reactive state',
        'Networking — Dio with interceptors, generic CRUD service, error handling',
        'Authentication — JWT token management, persistent sessions, auto-login, guest mode',
        'Local Storage — SharedPreferences for token persistence',
        'UI/UX Design — Glassmorphism, animations, skeleton loading, responsive layouts',
        'API Integration — RESTful API consumption with JSON parsing and model transformation',
        'Error Handling — Comprehensive try-catch, user-friendly error messages, loading states',
        'Code Organization — Clean folder structure, reusable components, separation of concerns',
      ];

  List<String> get responsibilities => const [
        'Designed and implemented the complete application architecture',
        'Built all screens, widgets, and reusable components',
        'Implemented the networking layer with Dio and auth interceptor',
        'Created the repository pattern for data access',
        'Built the cart system with Provider-based state management',
        'Implemented authentication flow with token persistence',
        'Designed the glassmorphism UI system',
        'Handled all error cases and loading states',
        'Organized the codebase into a scalable feature-based structure',
      ];

  List<String> get keyAchievements => const [
        'Complete end-to-end food ordering flow from browsing to checkout',
        'Real-time API integration with a hosted REST backend',
        'Glassmorphism navigation with animated pill indicator',
        'Skeleton loading for all data-driven screens',
        'Image fallback system using contextually appropriate emojis',
        'Profile management with image upload via gallery',
        'Auto-login with persistent JWT token sessions',
        'Cart system with tax and delivery fee calculations',
        'Clean, maintainable codebase with consistent patterns',
      ];

  List<HungryyCardItem> get futureImprovements => const [
        HungryyCardItem('Order History Screen', 'Currently commented out in root.dart; wire it up with an API endpoint and display past orders.', icon: Icons.history_rounded),
        HungryyCardItem('3D Model Rendering', 'GLB files exist but are not rendered; integrate model_viewer or flutter_cube.', icon: Icons.view_in_ar_rounded),
        HungryyCardItem('Lottie Animation Integration', 'Add Lottie animations to auth and home screens for enhanced visual feedback.', icon: Icons.animation_rounded),
        HungryyCardItem('Nunito Font Bundling', 'Add .ttf font files and register in pubspec.yaml.', icon: Icons.font_download_rounded),
        HungryyCardItem('Push Notifications', 'Add firebase_messaging for order status updates.', icon: Icons.notifications_rounded),
        HungryyCardItem('Localization', 'Add flutter_localizations and ARB files for multi-language support.', icon: Icons.language_rounded),
        HungryyCardItem('Unit & Widget Tests', 'Write meaningful tests for repositories, providers, and screens.', icon: Icons.science_rounded),
        HungryyCardItem('Dark Mode', 'Extend AppTheme with a dark theme variant and add a toggle.', icon: Icons.dark_mode_rounded),
        HungryyCardItem('Pagination', 'Add infinite scroll to the product grid for large catalogs.', icon: Icons.swipe_rounded),
        HungryyCardItem('CI/CD Pipeline', 'Add GitHub Actions workflow for automated build and test.', icon: Icons.rocket_launch_rounded),
      ];

  String get conclusionBody =>
      'Hungryy is a comprehensive Flutter application that demonstrates '
      'production-quality mobile development across every layer of the stack. '
      'From the Dio interceptor that automatically attaches JWT tokens, to the '
      'Provider-based cart system with real-time price calculations, to the '
      'glassmorphism UI with animated navigation — every component was built '
      'with deliberate architectural decisions and clean implementation. The '
      'project showcases the ability to design and build a complete, feature-rich '
      'mobile application: handling authentication, networking, state management, '
      'local storage, UI design, error handling, and code organization in a '
      'single cohesive codebase.';
}
