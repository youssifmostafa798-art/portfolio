# hungry 🍔

A feature-rich **food ordering Flutter application** with user authentication, product browsing, cart management, and checkout flow. Built with a clean architecture pattern using Provider for state management and Dio for networking against a RESTful backend.

---

## Features

### Authentication Module
| Feature | Description |
|---|---|
| **Login** | Email/password authentication with validation and loading state |
| **Signup** | User registration with name, email, and password |
| **Guest Mode** | Browse the app without signing in |
| **Auto-Login** | Persistent session via stored JWT token on splash screen |
| **Profile Management** | View/edit profile (name, email, address, VISA), upload profile photo via gallery |
| **Logout** | Token invalidation and session cleanup |

### Home / Product Browsing
| Feature | Description |
|---|---|
| **Product Grid** | 2-column grid display of food items from API |
| **Category Filtering** | Filter by: All, Combos, Burgers, Sliders, Chicken, Fries, Drinks |
| **Search** | Real-time text search across product names |
| **Skeleton Loading** | Shimmer placeholder while products load |
| **Error State** | Error message with retry button on API failure |
| **Empty State** | Friendly message when no products match the filter |

### Product Details & Customization
| Feature | Description |
|---|---|
| **Hero Image** | Network image display with emoji fallback |
| **Product Info** | Name, description, rating, and price display |
| **Spicy Level Selector** | Slider control (1-5 levels) with chili emoji indicators |
| **Toppings Selection** | Multi-select chips fetched from API with network images |
| **Side Options** | Single-select chips fetched from API |
| **Quantity Control** | Increment/decrement with min/max clamping |
| **Add to Cart** | Calculates total price and adds item to cart via Provider |
| **SnackBar Confirmation** | Floating confirmation on add-to-cart |

### Cart Management
| Feature | Description |
|---|---|
| **Cart List** | All added items with emoji, name, quantity, and line total |
| **Quantity Adjust** | Inline increment/decrement with auto-remove at zero |
| **Total Summary** | Displays total price at the bottom |
| **Item Count Badge** | Cart item count displayed in the AppBar |
| **Empty Cart** | Placeholder state with message and emoji |
| **Checkout Navigation** | Button to proceed to checkout screen |

### Checkout & Order Placement
| Feature | Description |
|---|---|
| **Order Summary** | Line items, subtotal, 5% tax, delivery fee, and total breakdown |
| **Estimated Delivery** | Card showing 15-20 minute delivery estimate |
| **Payment Selection** | Toggle between Cash on Delivery and Visa |
| **Save Card Option** | Checkbox-like UI for saving card details |
| **Pay Now** | Clears cart and navigates to success screen |
| **Success Animation** | Animated checkmark with elastic scale and fade transitions |
| **Back to Home** | Navigation back to home after order placement |

### Navigation & UI
| Feature | Description |
|---|---|
| **Glass Bottom Nav Bar** | Frosted glass-effect navigation with animated pill indicator |
| **Embedded Tab Navigation** | Home screen embeds Cart and Profile tabs internally |
| **PageView Navigation** | Root-level PageView for main screen swiping |
| **Splash Animation** | Logo fade/scale and image slide animation with auto-login |
| **Pull-to-Refresh** | Profile screen supports pull-to-refresh for data reload |
| **Glass Container** | Reusable frosted glass container wrapper (used in auth screens) |
| **Animated Icon Transitions** | Bottom nav icons animate between filled/outlined states |
| **Back Navigation** | Custom styled back buttons throughout the app |

---

## Tech Stack

| Technology | Version / Package |
|---|---|
| **Flutter** | (SDK constraint: `^3.10.1`) |
| **Dart** | SDK `^3.10.1` |
| **State Management** | `provider: ^6.1.2` (ChangeNotifier) |
| **Networking** | `dio: ^5.9.2` |
| **Local Storage** | `shared_preferences: ^2.5.4` |
| **Image Picker** | `image_picker: ^1.2.1` |
| **SVG Rendering** | `flutter_svg: ^2.2.4` |
| **Lottie Animations** | `lottie: ^3.3.2` |
| **Skeleton Loading** | `skeletonizer: ^2.1.3` |
| **Spacing Helpers** | `gap: ^3.0.1` |
| **Linting** | `flutter_lints: ^6.0.0` |

---

## Project Structure

```
lib/
├── main.dart                          # App entry point, Provider setup, theme
├── root.dart                          # Root scaffold with PageView + glass nav
├── splash_screen.dart                 # Animated splash with auto-login
│
├── component/                         # Reusable UI components
│   ├── app_colors.dart                # AppColors palette definition
│   ├── custom_button.dart             # Generic button wrapper
│   ├── custom_snack.dart              # Custom snack bar factory
│   ├── custom_text.dart               # Highly customizable text widget
│   ├── custom_txtfield.dart           # Auth-styled text form field
│   ├── glass_container.dart           # Frosted-glass container decorator
│   └── glass_nav.dart                 # Glassmorphism bottom navigation bar
│
├── core/                              # Core infrastructure
│   ├── network/
│   │   ├── api_error.dart             # ApiError class (message + statusCode)
│   │   ├── api_exceptions.dart        # DioException handler
│   │   ├── api_service.dart           # Generic CRUD (get/post/put/delete)
│   │   └── dio_client.dart            # Dio config, base URL, auth interceptor
│   └── utils/
│       └── pref_helper.dart           # SharedPreferences token CRUD
│
├── features/                          # Feature modules
│   ├── auth/                          # Authentication
│   │   ├── data/
│   │   │   ├── auth_repo.dart         # Login, signup, profile, logout, guest
│   │   │   └── user_model.dart        # User data model
│   │   ├── screens/
│   │   │   ├── login.dart             # Login screen
│   │   │   ├── signup.dart            # Registration screen
│   │   │   └── profile_screen.dart    # User profile edit/view
│   │   └── widget/
│   │       ├── custom_btn.dart        # Auth button (Login/Signup/Guest)
│   │       └── custom_user_txt_field.dart  # Profile form field
│   │
│   ├── cart/                          # Shopping Cart
│   │   └── screens/
│   │       └── cart_screen.dart       # Cart list with qty controls
│   │
│   ├── checkout/                      # Checkout & Order
│   │   ├── screens/
│   │   │   └── checkout_screen.dart   # Order summary, payment, pay now
│   │   └── widget/
│   │       └── success_screen.dart    # Animated order success
│   │
│   ├── home/                          # Home / Product listing
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── product_model.dart # Product data model
│   │   │   │   └── topping_model.dart # Topping/side-option model
│   │   │   └── repo/
│   │   │       └── product_repo.dart  # Products, toppings, side-options API
│   │   └── screens/
│   │       └── home_screen.dart       # Product grid, search, categories
│   │
│   └── productDetail/                 # Product detail & customization
│       └── screens/
│           └── product_detail_screen.dart  # Detail view with add-to-cart
│
├── models/                            # App-level models
│   ├── cart_provider.dart             # Cart state (ChangeNotifier)
│   └── food_item.dart                 # FoodItem model used across features
│
├── theme/
│   └── app_theme.dart                 # AppColors + ThemeData definition
│
└── widget/                            # Shared widgets
    └── common_widgets.dart            # PrimaryButton, QtyControl, CategoryPill,
                                       # SectionTitle, PaymentTile
```

### Folder Responsibility

| Folder | Responsibility |
|---|---|
| `component/` | Independent reusable widgets (glass nav, buttons, text, text fields, snack bar) that are not tied to any single feature |
| `core/` | Application infrastructure: HTTP client, API service layer, error handling, local storage utilities |
| `features/auth/` | Complete authentication module: data layer (repo + model), presentation (screens), and auth-specific widgets |
| `features/cart/` | Cart display screen with quantity controls |
| `features/checkout/` | Order checkout flow including payment selection and success animation |
| `features/home/` | Product listing with search, filtering, and its own data layer (models, repo) |
| `features/productDetail/` | Individual product view with customization options and add-to-cart |
| `models/` | Application-level models and state (CartProvider, FoodItem) shared across features |
| `theme/` | Centralized color palette and Material theme configuration |
| `widget/` | Shared reusable widgets used across multiple features (buttons, quantity control, category pills, payment tiles) |

---

## Architecture

### Pattern: Provider + Repository Layer

The app follows a **layered architecture** with a clear separation of concerns:

```
┌─────────────────────────────────────────────────────────┐
│                    UI Layer (Screens)                    │
│  home_screen, product_detail_screen, cart_screen, ...   │
│  (Consumes providers, calls repositories)               │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                State Management (Provider)               │
│  CartProvider (ChangeNotifier)                           │
│  (Holds cart state, exposes computed values)             │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│              Repository Layer (Repos)                    │
│  AuthRepo, ProductRepo                                   │
│  (Orchestrates API calls, transforms data)              │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                Service Layer (Network)                   │
│  ApiService → DioClient → Dio                            │
│  (Generic CRUD, auth interceptor, error handling)       │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│               Remote API (REST Backend)                  │
│  https://sonic-zdi0.onrender.com/api                     │
└─────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Screen** calls a method on a **Repository** (e.g., `ProductRepo.getProducts()`)
2. **Repository** calls `ApiService.get(endpoint)` which delegates to **DioClient**
3. **DioClient** attaches the auth token from `SharedPreferences` via interceptor
4. **Dio** makes the HTTP request to the **Remote API**
5. Response flows back: `Dio → ApiService → Repository`
6. **Repository** parses JSON into **Models** (`ProductModel`, `UserModel`, etc.)
7. Data is returned to the **Screen** which calls `setState()` or updates a **Provider**
8. **UI** rebuilds and displays the data (or error/loading state)

### State Flow (Cart)

```
User taps "Add to Cart"
    → ProductDetailScreen calls CartProvider.addItem()
    → CartProvider updates internal List<FoodItem>, calls notifyListeners()
    → CartScreen (watching CartProvider) rebuilds
    → CheckoutScreen reads cart totals via Provider
```

---

## API Integration

**Base URL:** `https://sonic-zdi0.onrender.com/api`

### Authentication Endpoints

| Method | Endpoint | Responsibility |
|---|---|---|
| `POST` | `/login` | Authenticate user with email/password, returns user data + JWT token |
| `POST` | `/register` | Create a new user account, returns user data + JWT token |
| `GET` | `/profile` | Fetch authenticated user's profile data |
| `POST` | `/update-profile` | Update user profile (multipart: name, email, address, visa, image) |
| `POST` | `/logout` | Invalidate current session/token |

### Product Endpoints

| Method | Endpoint | Responsibility |
|---|---|---|
| `GET` | `/products` | Fetch all food products with id, name, image, description, price, rating |
| `GET` | `/toppings` | Fetch available toppings (id, name, image) for product customization |
| `GET` | `/side-options` | Fetch available side options (id, name, image) for product customization |

### Auth Strategy

- JWT token is stored in `SharedPreferences` under key `auth_token`
- `DioClient` interceptor automatically attaches `Authorization: Bearer <token>` on every request
- Guest mode stores `"guest"` as the token string to differentiate from logged-in users
- `SplashScreen` checks stored token on startup and redirects to `Root` (authenticated/guest) or `LoginView`

---

## Screens

### SplashScreen
- **Purpose:** App entry point with branded animation and session check
- **Functionality:** Logo fade/scale-in animation, image slide-up animation, auto-login decision (navigate to Home or Login)
- **Files:** `lib/splash_screen.dart`

### LoginView
- **Purpose:** User authentication
- **Functionality:** Email/password form with validation, login button with loading indicator, guest mode button, signup navigation, pre-filled dev credentials
- **Files:** `lib/features/auth/screens/login.dart`

### SignupView
- **Purpose:** New user registration
- **Functionality:** Name/email/password form, signup with loading state, guest mode, login navigation, glass container background
- **Files:** `lib/features/auth/screens/signup.dart`

### Root (Main Shell)
- **Purpose:** Application shell with page-based navigation
- **Functionality:** `PageView` controller with `GlassBottomNavBar`, embeds Home, Cart, and Profile screens, animated icon transitions
- **Files:** `lib/root.dart`

### HomeScreen
- **Purpose:** Product discovery and browsing
- **Functionality:** Search bar, category pills (7 categories), 2-column product grid with images, skeleton loading, error/retry, empty state, embedded tab switching (Home/Cart/Orders/Profile via local state)
- **Files:** `lib/features/home/screens/home_screen.dart`

### ProductDetailScreen
- **Purpose:** Product customization and add-to-cart
- **Functionality:** Hero image with emoji fallback, product info, spicy level slider, toppings multi-select, side options single-select, quantity control, price calculation, add to cart with snackbar
- **Files:** `lib/features/productDetail/screens/product_detail_screen.dart`

### CartScreen
- **Purpose:** View and manage cart items
- **Functionality:** Cart item list with emoji, quantity increment/decrement with auto-remove, total display, checkout button, empty cart state, optional back button
- **Files:** `lib/features/cart/screens/cart_screen.dart`

### CheckoutScreen
- **Purpose:** Order review and payment
- **Functionality:** Order summary with line items, subtotal/tax(5%)/delivery fee breakdown, estimated delivery card, payment method selection (Cash/Visa), save card option, pay now button
- **Files:** `lib/features/checkout/screens/checkout_screen.dart`

### SuccessScreen
- **Purpose:** Order confirmation
- **Functionality:** Animated checkmark (elastic scale), fade-in text, estimated delivery card (15-20 min), "Back to Home" button
- **Files:** `lib/features/checkout/widget/success_screen.dart`

### ProfileScreen
- **Purpose:** User profile management
- **Functionality:** Profile photo display with gallery upload, name/email/address fields, VISA card display with gradient, edit profile button, logout button, guest mode fallback, skeleton loading, pull-to-refresh
- **Files:** `lib/features/auth/screens/profile_screen.dart`

---

## Models

### `FoodItem` (`lib/models/food_item.dart`)
| Field | Type | Description |
|---|---|---|
| `id` | `int` | Unique identifier |
| `name` | `String` | Product name |
| `category` | `String` | Computed category |
| `price` | `double` | Unit price |
| `rating` | `double` | Product rating |
| `emoji` | `String` | Display emoji |
| `description` | `String` | Product description |
| `imageUrl` | `String?` | Network image URL |
| `quantity` | `int` | Quantity in cart (default 1) |

### `ProductModel` (`lib/features/home/data/models/product_model.dart`)
| Field | Type | Description |
|---|---|---|
| `id` | `int` | Unique identifier |
| `name` | `String` | Product name |
| `image` | `String` | Raw image URL from API |
| `desc` | `String` | Product description |
| `price` | `String` | Price as string from API |
| `rate` | `String` | Rating as string from API |
| `priceValue` | `double` | Parsed price |
| `ratingValue` | `double` | Parsed rating |
| `imageUrl` | `String?` | Normalized HTTPS image URL |
| `category` | `String` | Computed category from name |
| `fallbackEmoji` | `String` | Emoji derived from product name |

### `ToppingModel` (`lib/features/home/data/models/topping_model.dart`)
| Field | Type | Description |
|---|---|---|
| `id` | `int` | Unique identifier |
| `name` | `String` | Topping/side name |
| `image` | `String?` | Raw image URL |
| `normalizedImageUrl` | `String?` | Normalized HTTPS image URL |

### `UserModel` (`lib/features/auth/data/user_model.dart`)
| Field | Type | Description |
|---|---|---|
| `name` | `String` | User's full name |
| `email` | `String` | User's email address |
| `image` | `String?` | Profile image URL |
| `token` | `String?` | JWT authentication token |
| `address` | `String?` | User's address |
| `visa` | `String?` | VISA card identifier |

---

## Repositories & Services

### `AuthRepo` (`lib/features/auth/data/auth_repo.dart`)
| Method | Description |
|---|---|
| `login(email, password)` | Authenticates user, stores JWT, returns `UserModel` |
| `signup(name, email, password)` | Registers new user, stores JWT, returns `UserModel` |
| `getProfileData()` | Fetches profile from `/profile` endpoint |
| `updateProfileData(name, email, address, visa, imagePath)` | Updates profile via multipart POST to `/update-profile` |
| `logout()` | Calls `/logout` API, clears token from storage |
| `autoLogin()` | Checks stored token, fetches profile if valid, falls back to guest |
| `continueAsGuest()` | Stores `"guest"` token for anonymous browsing |

### `ProductRepo` (`lib/features/home/data/repo/product_repo.dart`)
| Method | Description |
|---|---|
| `getProducts()` | Fetches all products from `/products`, returns `List<ProductModel>` |
| `getToppings()` | Fetches toppings from `/toppings`, returns `List<ToppingModel>` |
| `getOption()` | Fetches side options from `/side-options`, returns `List<ToppingModel>` |

### `CartProvider` (`lib/models/cart_provider.dart`)
| Property/Method | Description |
|---|---|
| `items` | Unmodifiable list of `FoodItem` in cart |
| `itemCount` | Sum of all quantities |
| `subtotal` | Sum of `price * quantity` for all items |
| `tax` | 5% of subtotal |
| `deliveryFee` | $3.50 if subtotal > 0, else $0 |
| `total` | `subtotal + tax + deliveryFee` |
| `addItem(item)` | Add item or increment if already exists |
| `increment(id)` | Increase quantity by 1 |
| `decrement(id)` | Decrease quantity by 1, remove if reaches 0 |
| `remove(id)` | Removes item from cart |
| `clear()` | Empties the cart |

### `ApiService` (`lib/core/network/api_service.dart`)
| Method | Description |
|---|---|
| `get(endPoint)` | HTTP GET request |
| `post(endPoint, body)` | HTTP POST request |
| `put(endPoint, body)` | HTTP PUT request |
| `delete(endPoint, body)` | HTTP DELETE request |

### `DioClient` (`lib/core/network/dio_client.dart`)
- Configures `Dio` with base URL `https://sonic-zdi0.onrender.com/api`
- Adds interceptor to attach `Authorization: Bearer <token>` from `PrefHelper`
- Default content type: `application/json`

### `PrefHelper` (`lib/core/utils/pref_helper.dart`)
- `saveToken(token)` — stores JWT in SharedPreferences
- `getToken()` — retrieves stored token or `null`
- `clearToken()` — removes token from storage

### `ApiExceptions` (`lib/core/network/api_exceptions.dart`)
- Maps `DioException` types (connection timeout, send timeout, receive timeout) to user-friendly `ApiError` messages
- Handles HTTP 302 as "Email Already Taken"

---

## Reusable Components

### Custom Widgets (`lib/component/`)

| Widget | Description |
|---|---|
| `CustomText` | Fully customizable text widget with all `TextStyle` properties exposed |
| `CustomButton` | Generic tap target with background, border radius, and optional child widget |
| `CustomTxtfield` | Auth-styled `TextFormField` with password toggle, validation, and custom decoration |
| `CustomSnack` | Factory function returning a styled `SnackBar` with icon and error message |
| `GlassContainer` | Frosted-glass effect container with gradient and blur |
| `GlassBottomNavBar` | Animated bottom navigation bar with glassmorphism, pill indicator, and animated icons |

### Shared Widgets (`lib/widget/`)

| Widget | Description |
|---|---|
| `PrimaryButton` | Full-width `ElevatedButton` with optional icon, used for checkout/retry actions |
| `QtyControl` | Quantity selector with minus/plus buttons and count display |
| `CategoryPill` | Horizontal pill-shaped category filter with animated selection |
| `SectionTitle` | Section header text with consistent styling |
| `PaymentTile` | Payment method selector with icon, label, and radio-style indicator |

### Auth Widgets (`lib/features/auth/widget/`)

| Widget | Description |
|---|---|
| `CustomAuthBtn` | Auth action button (Login/Signup/Guest) with optional person icon |
| `CustomUserTxtField` | Profile form `TextField` with primary color styling and rounded borders |

---

## Assets

```
assets/
├── logo.png                     # Raster logo fallback
├── logo/
│   └── logo.svg                 # Vector logo (used in splash + auth screens)
├── splash/
│   └── splash.png               # Splash screen bottom illustration
├── icon/
│   ├── shadow.png               # Shadow effect asset
│   ├── profileVisa.png          # VISA card icon (profile screen)
│   └── cash.png                 # Cash icon
├── test/
│   ├── test.png                 # Test/sample image
│   ├── tomato.png               # Topping sample image
│   ├── kunckles.jpg             # Sample food image
│   └── burger.glb              # 3D burger model (not rendered in UI)
├── detail/
│   └── sandwitch_detail.png     # Sandwich detail image
├── banner/
│   ├── banner.gif               # Animated banner
│   └── Offers.gif               # Offers animated banner
├── lottie/
│   ├── burger.json              # Burger Lottie animation
│   ├── Login.json               # Login screen Lottie animation
│   ├── chef.json                # Chef Lottie animation
│   └── background lines wave.json  # Background wave Lottie animation
└── 3dModel/
    └── burger.glb              # 3D burger model

Note: No custom font files (.ttf/.otf) are bundled.
The theme declares fontFamily: 'Nunito' but no Nunito font files
are present in the assets. The app will fall back to the system
font or fail silently at runtime.
```

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.1` or compatible
- Dart SDK `^3.10.1`
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

```bash
# Clone the repository
git clone https://github.com/youssifmostafa798-art/hungryy.git
cd hungryy

# Install dependencies
flutter pub get

# Run the app
flutter run

# Build APK (Android)
flutter build apk --release

# Build IPA (iOS)
flutter build ios --release
```

### Dependencies

All dependencies are declared in `pubspec.yaml` and will be installed via `flutter pub get`.

| Package | Version | Purpose |
|---|---|---|
| `provider` | ^6.1.2 | State management |
| `dio` | ^5.9.2 | HTTP networking |
| `shared_preferences` | ^2.5.4 | Local token storage |
| `flutter_svg` | ^2.2.4 | SVG rendering |
| `lottie` | ^3.3.2 | Lottie animations |
| `skeletonizer` | ^2.1.3 | Skeleton loading effects |
| `image_picker` | ^1.2.1 | Gallery image selection |
| `gap` | ^3.0.1 | SizedBox shorthand |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

### Run Configuration

```bash
# Debug mode
flutter run

# Profile mode
flutter run --profile

# Release mode
flutter run --release

# Web
flutter run -d chrome

# Specific device
flutter run -d <device-id>
```

---

## Future Improvements

Based on the current codebase architecture, these enhancements would be natural next steps:

1. **Order History Screen** — Currently commented out in `root.dart`; wire it up with an API endpoint and display past orders
2. **3D Model Rendering** — GLB files exist in `assets/3dModel/` and `assets/test/` but no Dart widget renders them; integrate `model_viewer` or `flutter_cube`
3. **Lottie Animation Integration** — Lottie JSON files exist but are not yet rendered in any screen; add them to auth/home screens
4. **Nunito Font Bundling** — Add `.ttf` font files to `assets/fonts/` and register them in `pubspec.yaml`
5. **Push Notifications** — Add `firebase_messaging` for order status updates
6. **Localization** — Add `flutter_localizations` and ARB files for multi-language support
7. **Unit & Widget Tests** — Replace the default counter test with meaningful tests for repositories, providers, and screens
8. **Dark Mode** — Extend `AppTheme` with a dark theme variant and add a toggle
9. **Pagination** — Add infinite scroll to the product grid for large product catalogs
10. **CI/CD** — Add GitHub Actions workflow for automated build and test
11. **Remove Debug Artifacts** — Clean up `debugPrint()` calls and dummy pre-filled credentials before production release
12. **Form Validation Enhancement** — Extract validators into reusable helper functions

---

## License

This project is licensed under the MIT License — see the LICENSE file for details.

---

*Generated from codebase analysis. All documented features have been verified against the actual Dart source files in `lib/`.*
