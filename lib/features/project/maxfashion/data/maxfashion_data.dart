import 'package:flutter/material.dart';

class MaxfashionFeature {
  final String title;
  final String description;
  final IconData? icon;
  const MaxfashionFeature(this.title, this.description, {this.icon});
}

class MaxfashionChallenge {
  final String title;
  final String problem;
  final String solution;
  const MaxfashionChallenge(this.title, this.problem, this.solution);
}

class MaxfashionArchitectureLayer {
  final String name;
  final String detail;
  const MaxfashionArchitectureLayer(this.name, this.detail);
}

class MaxfashionMetric {
  final String label;
  final String value;
  const MaxfashionMetric(this.label, this.value);
}

class MaxfashionData {
  const MaxfashionData();

  // ── Hero ──

  String get id => 'maxfashion';
  String get title => 'MaxFashion';
  String get tagline => 'Bilingual Fashion E-Commerce Application';
  String get role => 'Flutter Mobile Application Developer';
  String get status => 'Complete';
  String get teamSize => '1';
  String get timeline => '2025';
  String get platforms => 'Android (primary), iOS, Web';

  // ── Links ──

  String get githubUrl =>
      'https://github.com/youssifmostafa798-art/MaxFashion.git';

  String get screenshotsUrl =>
      'https://drive.google.com/drive/folders/1uqJ3wPhAzhErr3ErPGpSh0KwSqsQmO6x?usp=drive_link';

  String get videoUrl =>
      'https://drive.google.com/drive/folders/13iM-_QDUJ-I-9vh-h6JlycZFD2yP964R?usp=drive_link';

  List<String> get techStackTop => const [
        'Flutter',
        'Dart',
        'Riverpod',
        'Supabase',
        'PostgreSQL',
        'Clean Architecture',
      ];

  List<String> get techStack => const [
        'Flutter',
        'Dart',
        'Riverpod',
        'Supabase',
        'PostgreSQL',
        'Supabase Auth',
        'Supabase Storage',
        'Edge Functions',
        'Clean Architecture',
        'Repository Pattern',
        'flutter_screenutil',
        'flutter_svg',
        'SharedPreferences',
        'image_picker',
        'pinput',
        'flutter_credit_card',
        'ionicons',
        'flutter_dotenv',
      ];

  String get heroDescription =>
      'A production-grade fashion e-commerce mobile application with full '
      'English/Arabic bilingual support, RTL layout, and Supabase-powered '
      'backend. Features complete shopping flow from browsing through '
      'checkout to order tracking, secure authentication with OTP password '
      'reset, optimistic UI updates, and a custom shimmer loading system.';

  // ── Project Overview ──

  String get overviewBody =>
      'MaxFashion is a mobile fashion e-commerce application built with '
      'Flutter and Supabase. It provides a complete shopping experience — '
      'from browsing a curated product catalog through checkout to order '
      'tracking — with bilingual support (English/Arabic), full RTL layout, '
      'light/dark theme switching, and a Supabase-powered backend with '
      'authentication, database, storage, and edge functions.';

  String get overviewProblemBody =>
      'Building a production-grade fashion e-commerce mobile app requires '
      'solving multiple interconnected challenges simultaneously: real-time '
      'inventory and order management, secure authentication with password '
      'recovery, bilingual UI with RTL support, offline-to-online data '
      'migration, and a clean architecture that remains maintainable as the '
      'feature set grows.';

  String get overviewSolutionBody =>
      'MaxFashion delivers a full-featured shopping app backed by Supabase '
      '(PostgreSQL, Auth, Storage, Edge Functions). The app uses Riverpod for '
      'reactive, testable state management, Clean Architecture with a '
      'feature-first folder structure, repository pattern with abstract '
      'interfaces and Supabase implementations, 25 SQL migrations for schema '
      'evolution, 3 Edge Functions for secure server-side operations, full '
      'English/Arabic localization with RTL-aware layouts, and light/dark '
      'theme with runtime switching and persistence.';

  String get overviewValueBody =>
      'The main product value is a polished, bilingual fashion shopping '
      'experience with a secure backend and maintainable codebase. Users can '
      'browse curated fashion collections, search products, manage their '
      'cart and wishlist, complete checkout with saved addresses and payment '
      'cards, and track their orders — all in English or Arabic with proper '
      'RTL layout.';

  // ── Target Users & Journey ──

  String get targetUsersBody =>
      'MaxFashion targets fashion-conscious mobile shoppers aged 18-35 who '
      'speak English and/or Arabic. The app is designed for mobile-first '
      'buyers expecting polished, fast retail app UX who browse curated '
      'fashion collections rather than mass marketplace listings.';

  String get userJourneyBody =>
      'Splash (animated logo with auth-state-aware navigation) → '
      'Authentication Decision (authenticated → Main, guest → Main, '
      'unauthenticated → Auth page) → Auth Page (Sign In, Create Account, '
      'or Guest) → Home Screen (cover image, category filter chips, product '
      'grid max 12, collections carousel) → Product Detail (images, sizes, '
      'pricing, add to cart) → Cart (items, quantity adjustment, subtotal) → '
      'Checkout (address selection, payment card selection, order placement) '
      '→ Order Success → Order History (status tracking with visual timeline).';

  // ── Core Features ──

  List<MaxfashionFeature> get authFeatures => const [
        MaxfashionFeature(
          'Email/Password Authentication',
          'Full signup and login with email/password, form validation, '
              '"Remember Me" checkbox for session persistence.',
          icon: Icons.login_rounded,
        ),
        MaxfashionFeature(
          '3-Step Password Reset',
          'Email entry → 6-digit OTP verification → new password. '
              'OTPs are SHA-256 hashed with rate limiting and attempt control.',
          icon: Icons.lock_reset_rounded,
        ),
        MaxfashionFeature(
          'Guest Mode',
          'Browse products, search, and view collections without an account. '
              'Protected actions trigger a GuestPromptDialog with sign-in options.',
          icon: Icons.person_outline_rounded,
        ),
        MaxfashionFeature(
          'Session Persistence',
          'Sessions are persisted automatically by supabase_flutter. '
              'Auth state stream listens to onAuthStateChange for real-time updates.',
          icon: Icons.sync_rounded,
        ),
        MaxfashionFeature(
          'Route-Level Auth Guards',
          'AuthGuard widget protects checkout, profile editing, addresses, '
              'and payment methods. Unauthenticated users are redirected to /auth.',
          icon: Icons.shield_rounded,
        ),
      ];

  List<MaxfashionFeature> get discoveryFeatures => const [
        MaxfashionFeature(
          'Home Screen',
          'Cover image, category filter chips, product grid (max 12), '
              'and curated collections carousel.',
          icon: Icons.home_rounded,
        ),
        MaxfashionFeature(
          'Category Filtering',
          'Dynamic categories loaded from Supabase with tap-to-filter '
              'on the home screen product grid.',
          icon: Icons.category_rounded,
        ),
        MaxfashionFeature(
          'Curated Collections',
          'Browse products organized into curated collections with '
              'dedicated collection detail pages.',
          icon: Icons.collections_rounded,
        ),
        MaxfashionFeature(
          'Product Detail',
          'Full product images, available sizes, pricing with discounts, '
              'and add-to-cart functionality.',
          icon: Icons.shopping_bag_rounded,
        ),
      ];

  List<MaxfashionFeature> get searchFeatures => const [
        MaxfashionFeature(
          'Full-Text Search',
          'Server-side full-text search via Supabase RPC using PostgreSQL '
              'trigram matching for fuzzy search.',
          icon: Icons.search_rounded,
        ),
        MaxfashionFeature(
          'Debounced Input',
          '300ms client-side debounce prevents excessive API calls '
              'while typing.',
          icon: Icons.timer_rounded,
        ),
        MaxfashionFeature(
          'Paginated Results',
          'Search results loaded in batches of 20 with load-more '
              'pagination.',
          icon: Icons.pageview_rounded,
        ),
        MaxfashionFeature(
          'Recent Searches',
          'Per-user recent search history persisted in SharedPreferences '
              'for quick re-execution.',
          icon: Icons.history_rounded,
        ),
      ];

  List<MaxfashionFeature> get shoppingFeatures => const [
        MaxfashionFeature(
          'Shopping Cart',
          'Add/remove items with quantity adjustment, real-time subtotal '
              'calculation, and optimistic UI updates.',
          icon: Icons.shopping_cart_rounded,
        ),
        MaxfashionFeature(
          'Wishlist',
          'Add/remove products with optimistic UI and automatic rollback '
              'on failure.',
          icon: Icons.favorite_rounded,
        ),
        MaxfashionFeature(
          'Address Management',
          'Add, edit, and delete shipping addresses with default address '
              'selection.',
          icon: Icons.location_on_rounded,
        ),
        MaxfashionFeature(
          'Payment Card Management',
          'Add and delete payment cards with default selection and '
              'automatic Visa/Mastercard detection.',
          icon: Icons.credit_card_rounded,
        ),
      ];

  List<MaxfashionFeature> get checkoutFeatures => const [
        MaxfashionFeature(
          'Checkout Flow',
          'Address selection, payment card selection, order summary, '
              'and order placement with success dialog.',
          icon: Icons.receipt_long_rounded,
        ),
        MaxfashionFeature(
          'Order History',
          'Order list with status tracking and visual timeline '
              'showing order progression.',
          icon: Icons.list_alt_rounded,
        ),
        MaxfashionFeature(
          'Order Details',
          'Individual order view with items, status timeline, '
              'and delivery information.',
          icon: Icons.assignment_rounded,
        ),
      ];

  List<MaxfashionFeature> get profileFeatures => const [
        MaxfashionFeature(
          'Profile Management',
          'View and edit profile with avatar upload and removal. '
              'Auto-created on signup via ensureProfileExists().',
          icon: Icons.person_rounded,
        ),
        MaxfashionFeature(
          'Theme Switching',
          'Light, Dark, and System theme options with runtime switching '
              'and SharedPreferences persistence.',
          icon: Icons.dark_mode_rounded,
        ),
        MaxfashionFeature(
          'Language Switching',
          'English and Arabic language selection with immediate UI update '
              'and persistence via SharedPreferences.',
          icon: Icons.language_rounded,
        ),
      ];

  // ── Bilingual RTL Support ──

  String get rtlBody =>
      'MaxFashion implements full English/Arabic bilingual support with '
      '~150+ translated keys. The localization system uses Flutter\'s built-in '
      'flutter_localizations with AppLocalizations generated from ARB files. '
      'Two ARB files (app_en.arb and app_ar.arb) contain all translations '
      'covering auth flow, home, products, cart, checkout, orders, profile, '
      'settings, search, error messages, and guest prompts.';

  String get rtlImplementationBody =>
      'RTL layout is achieved through several techniques: PositionedDirectional '
      'is used instead of Positioned for directional positioning. The bottom '
      'navigation tab order is reversed for Arabic (Profile, Cart, Menu, Home '
      'instead of Home, Menu, Cart, Profile). CustomText auto-selects the font '
      'family based on locale — Tenor Sans for English and Noto Sans Arabic '
      '(Regular + Bold) for Arabic. Directionality widgets are used where needed, '
      'and navigator transitions work in both LTR and RTL directions.';

  // ── Theme System ──

  String get themeBody =>
      'The theme system supports Light, Dark, and System modes with runtime '
      'switching and persistence via SharedPreferences. The light theme uses '
      'a white scaffold with black-on-white color scheme. The dark theme uses '
      'a #121212 scaffold background with white-on-dark colors and #181818 '
      'dark surface. Theme transitions animate over 300ms for smooth switching.';

  String get themeColorsBody =>
      'The color system is defined in AppColors with monochrome base colors '
      '(black, white, greys), a green accent (#2E7D32), and success/error '
      'states. Product-specific colors are kept in project-specific color files '
      'rather than the global AppColors to maintain separation of concerns.';

  // ── Authentication & Security ──

  String get authBody =>
      'Authentication is powered by Supabase Auth with email/password. The '
      'full auth flow includes signup, login with "Remember Me", logout, and '
      'guest mode. Sessions are persisted automatically by supabase_flutter '
      'and the auth state provider listens to onAuthStateChange for real-time '
      'updates. A GuestPromptDialog appears when unauthenticated users attempt '
      'protected actions like checkout or profile editing.';

  String get securityBody =>
      'The password reset flow implements multiple security layers: OTPs are '
      'generated server-side in Edge Functions and stored as SHA-256 hashes '
      '(plain text is never stored). Rate limiting enforces a 60-second cooldown '
      'between OTP requests. A maximum of 5 verification attempts is enforced '
      'before the code is invalidated. User enumeration protection returns '
      'success even if the email is not found. After a successful password reset, '
      'ALL sessions for the user are invalidated.';

  // ── Supabase Architecture ──

  List<MaxfashionArchitectureLayer> get architectureLayers => const [
        MaxfashionArchitectureLayer(
          'Flutter Client',
          'Material app with Riverpod providers, feature-first folder structure, '
              'and ScreenUtil responsive sizing',
        ),
        MaxfashionArchitectureLayer(
          'State Management (Riverpod)',
          '10+ providers using StateNotifier, FutureProvider, StateProvider, '
              'and StreamProvider patterns',
        ),
        MaxfashionArchitectureLayer(
          'Repository Layer',
          '10 abstract repository interfaces with Supabase implementations, '
              'enabling testability and backend swaps',
        ),
        MaxfashionArchitectureLayer(
          'Supabase Backend',
          'PostgreSQL database, Supabase Auth, Supabase Storage, '
              'and 3 Deno Edge Functions',
        ),
        MaxfashionArchitectureLayer(
          'Database (PostgreSQL)',
          '14 active tables with Row Level Security policies, '
              '25 SQL migrations, and 244 seeded products',
        ),
        MaxfashionArchitectureLayer(
          'Storage',
          '3 buckets: product-images (public read), avatars (authenticated write), '
              'collection-images (public read)',
        ),
        MaxfashionArchitectureLayer(
          'Edge Functions',
          '3 Deno functions for secure OTP password reset: send-reset-code, '
              'verify-reset-code, reset-password',
        ),
      ];

  // ── Database Design ──

  String get databaseBody =>
      'The database contains 14 active tables with Row Level Security (RLS) '
      'policies on all user-specific tables. Product and category tables are '
      'publicly readable. The schema evolved through 25 SQL migrations covering '
      'products, categories, cart items, wishlist items, orders, addresses, '
      'payment cards, profiles, collections, and password reset codes.';

  List<MaxfashionMetric> get databaseMetrics => const [
        MaxfashionMetric('Active Tables', '14'),
        MaxfashionMetric('SQL Migrations', '25'),
        MaxfashionMetric('Seeded Products', '244'),
        MaxfashionMetric('Categories', '22'),
        MaxfashionMetric('Curated Collections', '10'),
        MaxfashionMetric('Seed Product Sizes', '977'),
      ];

  // ── State Management ──

  String get stateManagementBody =>
      'MaxFashion uses Flutter Riverpod (2.6.1) with the StateNotifier pattern '
      'for state management. The state layer includes 10+ providers covering '
      'authentication, products, categories, cart, wishlist, orders, search, '
      'addresses, payment cards, theme, and locale. Each provider manages its '
      'own state class with AsyncValue handling for loading, error, empty, '
      'and success states.';

  List<MaxfashionFeature> get providerItems => const [
        MaxfashionFeature(
          'StateNotifier Pattern',
          'Used for Auth, Cart, Wishlist, Orders, Addresses, PaymentCards, '
              'and Search providers with dedicated State + Notifier classes.',
          icon: Icons.speed_rounded,
        ),
        MaxfashionFeature(
          'FutureProvider',
          'Used for HomeContent and Collections async data loading '
              'from Supabase.',
          icon: Icons.cloud_download_rounded,
        ),
        MaxfashionFeature(
          'StreamProvider',
          'Used for AuthState to listen to Supabase auth state changes '
              'in real-time.',
          icon: Icons.stream_rounded,
        ),
        MaxfashionFeature(
          'StateProvider',
          'Used for simple state like SelectedCategory on the home screen.',
          icon: Icons.toggle_on_rounded,
        ),
      ];

  // ── Search Implementation ──

  String get searchBody =>
      'Product search uses a Supabase RPC function (search_products) that '
      'leverages PostgreSQL full-text search with trigram matching for fuzzy '
      'search support. The client implements a 300ms debounce to prevent '
      'excessive API calls while typing. Results are paginated server-side '
      'with 20 results per page. Recent searches are persisted per user in '
      'SharedPreferences and can be tapped to re-execute a previous search.';

  // ── Shopping Flow ──

  String get shoppingFlowBody =>
      'The shopping flow covers the complete purchase journey: Product '
      'discovery (home screen with category filtering, collections), Product '
      'detail (images, sizes, pricing, add to cart), Cart management (quantity '
      'adjustment, subtotal calculation, optimistic updates), Checkout (address '
      'selection, payment card selection, order placement), Order confirmation '
      '(success dialog with navigation), and Order history (status tracking '
      'with visual timeline).';

  // ── Custom Shimmer Loading ──

  String get shimmerBody =>
      'MaxFashion implements a custom shimmer loading system built entirely '
      'from scratch without any third-party loading package. The system '
      'includes a core ShimmerEffect animation and 13 feature-specific skeleton '
      'variants: Home, Cart, Wishlist, Orders, Profile, Search, PaymentMethods, '
      'Addresses, AllCategories, CategoryChips, CollectionsGrid, ProductListing, '
      'and a generic skeleton.';

  List<MaxfashionFeature> get skeletonItems => const [
        MaxfashionFeature(
          'ShimmerEffect Core',
          'Custom shimmer animation with animation controllers providing '
              'the base shimmer movement effect.',
          icon: Icons.animation_rounded,
        ),
        MaxfashionFeature(
          'Reusable Skeleton Components',
          'SkeletonBox, SkeletonCircle, SkeletonText, SkeletonCard, '
              'SkeletonButton, and SkeletonContainer for composable skeletons.',
          icon: Icons.view_module_rounded,
        ),
        MaxfashionFeature(
          'Feature-Specific Skeletons',
          '13 dedicated skeleton widgets matching the exact layout of each '
              'feature screen for accurate loading placeholders.',
          icon: Icons.dashboard_rounded,
        ),
        MaxfashionFeature(
          'Empty State Widgets',
          'Dedicated empty state widgets for cart, wishlist, orders, '
              'categories, collections, addresses, and payment methods.',
          icon: Icons.inbox_rounded,
        ),
      ];

  // ── Guest Mode ──

  String get guestModeBody =>
      'Unauthenticated users can browse products, search, and view '
      'collections without creating an account. When a guest attempts a '
      'protected action (checkout, add address, add card, edit profile), a '
      'GuestPromptDialog appears with options to Sign In, Create Account, or '
      'Cancel. The AuthState.isGuest flag tracks guest status and the AuthGuard '
      'widget wraps protected routes to enforce authentication.';

  // ── Optimistic UI Updates ──

  String get optimisticBody =>
      'Cart and wishlist operations use optimistic updates for instant user '
      'feedback. When an item is added or removed, the UI updates immediately '
      'before the network call completes. If the network call fails, the '
      'previous state is restored automatically with a localized error message. '
      'This pattern makes the app feel responsive even on slow connections.';

  // ── Data Migration ──

  String get migrationBody =>
      'MaxFashion includes an OrdersMigrationService that handles the migration '
      'of locally-stored orders to Supabase. The service checks a per-user '
      'migration flag, deduplicates orders by order_number and user_id, and '
      'performs bulk inserts with order_items. This ensures users who started '
      'with locally-stored data retain their order history after migrating to '
      'the Supabase backend.';

  // ── Engineering Challenges ──

  List<MaxfashionChallenge> get challenges => const [
        MaxfashionChallenge(
          'Bilingual UI with RTL Support',
          'The app needed to support both English and Arabic with proper RTL '
              'layout, including reversed navigation, direction-aware positioning, '
              'and locale-specific fonts.',
          'Custom CustomText widget auto-selects font family based on locale. '
              'PositionedDirectional used instead of Positioned. Bottom nav tab '
              'order reversed for Arabic. ARB-based localization with 150+ '
              'translation keys.',
        ),
        MaxfashionChallenge(
          'Secure Password Reset Flow',
          'Password reset needed to be secure against brute force, user '
              'enumeration, and session hijacking.',
          '3-step flow (email → OTP → new password) with SHA-256 hashed OTPs, '
              '60-second rate limiting, max 5 verification attempts, user '
              'enumeration protection, and full session invalidation after reset.',
        ),
        MaxfashionChallenge(
          'Optimistic UI Updates',
          'Cart and wishlist operations need to feel instant, but network '
              'requests take time.',
          'Optimistic updates: UI updates immediately before network call. '
              'Rollback on failure: if network call fails, revert to previous '
              'state. Error display: show localized error message after rollback.',
        ),
        MaxfashionChallenge(
          'Guest Mode with Progressive Enhancement',
          'Users should be able to browse without an account but be prompted '
              'to sign in for protected actions.',
          'AuthState.isGuest flag allows browsing. AuthGuard widget protects '
              'sensitive routes. GuestPromptDialog appears when guests try '
              'protected actions. Cart/wishlist accessible but require sign-in '
              'for checkout.',
        ),
        MaxfashionChallenge(
          'Full-Text Search with Pagination',
          'Product search needed to be fast, accurate, and support Arabic text.',
          'Supabase RPC function search_products using PostgreSQL full-text '
              'search with trigram matching. Server-side pagination (20 results '
              'per page). Client-side debouncing (300ms). Recent searches '
              'persisted per user.',
        ),
        MaxfashionChallenge(
          'Local-to-Supabase Data Migration',
          'Users who started with locally-stored orders needed their data '
              'migrated to Supabase without duplicates.',
          'OrdersMigrationService checks per-user migration flag. Deduplication '
              'by order_number + user_id. Bulk insert with order_items. Detailed '
              'result reporting.',
        ),
        MaxfashionChallenge(
          'Custom Shimmer Loading System',
          'The app needed loading skeletons but wanted to avoid adding a '
              'third-party loading package.',
          'Custom ShimmerEffect with animation controllers. 13 feature-specific '
              'skeleton widgets. Reusable skeleton components (box, circle, text, '
              'card, button). Full control over animation and appearance.',
        ),
      ];

  // ── Results & Achievements ──

  List<MaxfashionMetric> get resultsMetrics => const [
        MaxfashionMetric('Seeded Products', '244'),
        MaxfashionMetric('Categories', '22'),
        MaxfashionMetric('Curated Collections', '10'),
        MaxfashionMetric('Database Migrations', '25'),
        MaxfashionMetric('Edge Functions', '3'),
        MaxfashionMetric('Test Files', '18'),
        MaxfashionMetric('Test Cases', '87'),
        MaxfashionMetric('Localization Keys', '150+'),
      ];

  List<String> get resultsHighlights => const [
        'Full English/Arabic bilingual support with RTL layout',
        'Light/dark theme with system theme option',
        'Guest mode with progressive enhancement',
        'Secure 3-step password reset with OTP hashing',
        'Custom shimmer loading with 13 skeleton variants',
        'Optimistic UI updates for cart and wishlist',
        'Complete shopping flow from browsing to order tracking',
        'Clean Architecture with 10 repository interfaces',
      ];

  // ── Lessons & Key Decisions ──

  List<MaxfashionChallenge> get lessons => const [
        MaxfashionChallenge(
          'Riverpod over Provider/BLoC',
          'Provider and BLoC were considered, but Riverpod provides '
              'compile-time safety, better testability, and more flexible '
              'dependency injection. StateNotifier pattern provides clear state '
              'management without boilerplate.',
          'Riverpod was chosen for its compile-time safety, better testability, '
              'and more flexible dependency injection compared to Provider. '
              'StateNotifier pattern provides clear state management without '
              'boilerplate.',
        ),
        MaxfashionChallenge(
          'Repository Pattern with Abstract Interfaces',
          'Every data source has an abstract interface, which was a deliberate '
              'architectural decision.',
          'Abstract interfaces enable easy testing with mock implementations, '
              'future backend swaps (e.g., switching from Supabase to another '
              'backend), and clear separation of concerns.',
        ),
        MaxfashionChallenge(
          'Feature-First Architecture',
          'The codebase is organized by feature rather than by type.',
          'Each feature is self-contained with its own data/domain/presentation '
              'layers, making it easy to find related code, understand feature '
              'boundaries, and refactor individual features without affecting '
              'others.',
        ),
        MaxfashionChallenge(
          'Custom Shimmer over Third-Party',
          'A loading skeleton system was needed but a third-party package was '
              'avoided.',
          'Custom shimmer avoids dependency on third-party loading packages, '
              'provides full control over animation and appearance, and keeps '
              'the dependency list smaller.',
        ),
        MaxfashionChallenge(
          'Supabase over Custom Backend',
          'A backend was needed for auth, database, storage, and server-side '
              'logic.',
          'Supabase provides authentication, database, storage, and edge '
              'functions in a single platform, reducing backend development '
              'time while providing RLS for security.',
        ),
      ];

  // ── Future Work ──

  List<MaxfashionFeature> get futureItems => const [
        MaxfashionFeature(
          'Fix ProductModel ID',
          'Change ProductModel ID from String with "p" prefix to int for '
              'correct database writes.',
          icon: Icons.build_rounded,
        ),
        MaxfashionFeature(
          'CartItemModel toInsertJson',
          'Add toInsertJson() method for proper Supabase insert operations.',
          icon: Icons.code_rounded,
        ),
        MaxfashionFeature(
          'Clean Up Swallowed Exceptions',
          'Address 24 silently swallowed exceptions (catch (_){}) across '
              'multiple files by adding proper logging.',
          icon: Icons.cleaning_services_rounded,
        ),
        MaxfashionFeature(
          'Extract Hardcoded URLs',
          'Move hardcoded Supabase storage URLs to configuration constants.',
          icon: Icons.link_rounded,
        ),
        MaxfashionFeature(
          'Product Reviews & Ratings',
          'Add a reviews and ratings system for products.',
          icon: Icons.star_rounded,
        ),
        MaxfashionFeature(
          'Push Notifications',
          'Implement push notifications for order status updates.',
          icon: Icons.notifications_rounded,
        ),
        MaxfashionFeature(
          'Order Cancellation',
          'Add order cancellation functionality.',
          icon: Icons.cancel_rounded,
        ),
        MaxfashionFeature(
          'Real Payment Gateway',
          'Integrate a real payment gateway for actual transactions.',
          icon: Icons.payment_rounded,
        ),
        MaxfashionFeature(
          'Product Image Gallery with Zoom',
          'Add a full product image gallery with pinch-to-zoom.',
          icon: Icons.zoom_in_rounded,
        ),
        MaxfashionFeature(
          'Multi-Currency Support',
          'Add support for multiple currencies.',
          icon: Icons.attach_money_rounded,
        ),
        MaxfashionFeature(
          'Admin Dashboard',
          'Implement a seller/vendor admin dashboard.',
          icon: Icons.admin_panel_settings_rounded,
        ),
      ];

  // ── Conclusion ──

  String get conclusionBody =>
      'MaxFashion is a comprehensive Flutter e-commerce application that '
      'demonstrates production-quality mobile development across every layer '
      'of the stack. From the Supabase Auth integration with SHA-256 hashed '
      'OTPs, to the Riverpod state management with optimistic updates, to the '
      'full English/Arabic bilingual support with RTL layout — every component '
      'was built with deliberate architectural decisions and clean '
      'implementation. The project showcases the ability to design and build '
      'a complete, feature-rich mobile e-commerce application: handling '
      'authentication, database design, state management, localization, '
      'theme switching, search, shopping flow, and code organization in a '
      'single cohesive codebase.';

  // ── Screenshots ──

  List<String> get screenshotLabels => const [
        'Home Screen',
        'Product Detail',
        'Cart & Checkout',
        'Order History',
      ];

  List<Color> get screenshotColors => const [
        Color(0xFF000000),
        Color(0xFF2D2D2D),
        Color(0xFF424242),
        Color(0xFF9E9E9E),
      ];
}
