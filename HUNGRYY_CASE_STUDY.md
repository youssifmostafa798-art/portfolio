# HUNGRYY — Flutter Food Ordering Application

## Case Study

**Developer:** Youssif Mostafa
**Platform:** Flutter (Android / iOS)
**Architecture:** Provider + Repository Pattern
**Backend:** RESTful API (Render)
**Repository:** [github.com/youssifmostafa798-art/hungryy](https://github.com/youssifmostafa798-art/hungryy)

---

## Hero

A production-grade food ordering application built entirely in Flutter — featuring real-time product browsing, dynamic cart management, multi-step checkout, user authentication with persistent sessions, and a glassmorphism-driven UI system. Hungryy demonstrates end-to-end mobile application development from network layer to pixel-perfect presentation.

---

## Project Overview

Hungryy is a fast-food ordering application that connects users to a RESTful backend API. Users can browse a menu of food products organized by category, customize their orders with toppings and side options, manage a shopping cart with real-time price calculations, and complete checkout with animated order confirmation. The application supports full user authentication (login, signup, guest mode, auto-login), profile management with image upload, and persistent session handling via JWT tokens.

The project was built as a comprehensive demonstration of Flutter development skills — covering architecture design, state management, networking, local storage, responsive UI, animation systems, and clean code organization across a feature-based folder structure.

---

## Business Problem

Food ordering applications have become a core part of the modern dining experience. Users expect fast, intuitive interfaces that let them browse menus, customize orders, and checkout in seconds. Building such an application requires solving several engineering challenges simultaneously:

- Managing asynchronous API calls for products, toppings, and side options while keeping the UI responsive
- Handling authentication state across app restarts with token persistence
- Implementing a cart system that calculates taxes, delivery fees, and totals in real-time
- Creating a visually distinctive UI that stands apart from generic Material templates
- Organizing code in a way that scales as features are added

Hungryy addresses each of these challenges with deliberate architectural decisions and a clean, maintainable codebase.

---

## Solution

The application is built on a layered architecture with clear separation of concerns:

1. **UI Layer** — Screens and widgets that consume state and render the interface
2. **State Management** — Provider-based reactive state using ChangeNotifier
3. **Repository Layer** — AuthRepo and ProductRepo that orchestrate API calls and data transformation
4. **Service Layer** — ApiService providing generic CRUD operations over Dio
5. **Network Layer** — DioClient with base URL configuration and JWT auth interceptor
6. **Storage Layer** — SharedPreferences for token persistence

Each feature is organized into its own module under `lib/features/` with dedicated data, screens, and widget subfolders. Shared components live in `lib/component/` and `lib/widget/`, while core infrastructure resides in `lib/core/`.

---

## User Journey

1. **Splash Screen** — The app launches with a fade/scale logo animation and a slide-up bottom illustration. Behind the scenes, it checks for a stored JWT token.
2. **Authentication Decision** — If a valid token exists, the user is auto-logged in and navigated to the home screen. If a guest token exists, the user enters as a guest. Otherwise, the login screen appears.
3. **Login / Signup** — Users authenticate with email and password. The signup form collects name, email, and password. Both forms include validation with real-time error feedback. A "Continue as Guest" option bypasses authentication entirely.
4. **Home Screen** — The main product browsing interface displays a 2-column grid of food items fetched from the API. Users can search by name or filter by category using horizontal pill selectors.
5. **Product Detail** — Tapping a product opens a detail view with a hero image, product info, spicy level slider, multi-select toppings, single-select side options, quantity control, and an "Add to Cart" button with live price calculation.
6. **Cart** — The cart screen lists all added items with emoji thumbnails, names, quantities, and line totals. Users can increment/decrement quantities inline. An empty cart state displays a friendly message.
7. **Checkout** — The checkout screen shows an order summary with subtotal, 5% tax, delivery fee, and total. Users select a payment method (Cash on Delivery or Visa) and confirm the order.
8. **Success** — An animated success screen with an elastic-scale checkmark and fade-in text confirms the order. A delivery estimate card shows 15-20 minutes. "Back to Home" returns to the product grid.
9. **Profile** — Authenticated users can view and edit their profile (name, email, address, VISA), upload a profile photo from the gallery, and log out. Guest users see a prompt to log in.

---

## My Role

I designed and developed the entire application from scratch — from architecture planning and folder structure to UI implementation and API integration. Every screen, widget, model, repository, and network configuration was built by me. The project represents a complete end-to-end Flutter development effort.

---

## Project Objectives

- Build a feature-complete food ordering application with real API integration
- Implement clean architecture with separation of concerns across UI, state, repository, and network layers
- Create a reusable component system that eliminates duplication across screens
- Design a distinctive glassmorphism UI with custom navigation and animations
- Handle authentication with persistent sessions, auto-login, and guest mode
- Build a cart system with real-time price calculations including tax and delivery fees
- Implement skeleton loading, error handling, and empty states for all data-driven screens
- Organize code in a scalable, feature-based folder structure

---

## Core Features

### Authentication Module
- Email/password login with form validation (email regex, minimum password length)
- User registration with name, email, and password fields
- Guest mode for anonymous browsing without authentication
- Auto-login on app startup by checking stored JWT token in SharedPreferences
- Token-based session management with automatic header injection
- Profile management with name, email, address, and VISA card fields
- Profile photo upload via device gallery using ImagePicker
- Logout with token invalidation and session cleanup

### Product Browsing
- 2-column responsive product grid fetched from the `/products` API endpoint
- Category filtering across 7 categories: All, Combos, Burgers, Sliders, Chicken, Fries, Drinks
- Real-time text search across product names
- Skeleton loading with shimmer effect while products load
- Error state with retry button on API failure
- Empty state with friendly message when no products match filters
- Product cards with gradient backgrounds, price, and rating display

### Product Customization
- Hero image display with network image and emoji fallback
- Spicy level selector with slider control (1-5 levels) and chili emoji indicators
- Multi-select toppings fetched from the `/toppings` API endpoint
- Single-select side options fetched from the `/side-options` API endpoint
- Quantity control with increment/decrement and min/max clamping
- Live price calculation in the "Add to Cart" button
- SnackBar confirmation on add-to-cart

### Cart Management
- Cart list displaying all items with emoji, name, quantity, and line total
- Inline quantity adjustment with auto-remove when quantity reaches zero
- Real-time total price computation including subtotal, tax, and delivery fee
- Item count badge in the navigation bar
- Empty cart state with placeholder message
- Checkout navigation button

### Checkout & Order Placement
- Order summary with line items, subtotal, 5% tax, and $3.50 delivery fee
- Estimated delivery card showing 15-20 minute delivery window
- Payment method selection between Cash on Delivery and Visa
- Save card option checkbox UI
- "Pay Now" button that clears the cart and navigates to success screen
- Animated success screen with elastic-scale checkmark and fade-in text
- "Back to Home" navigation after order completion

### Profile Management
- Profile photo display with gallery upload via ImagePicker
- Editable form fields for name, email, address, and VISA card
- VISA card display with gradient background when card is saved
- Pull-to-refresh for data reload
- Skeleton loading while profile data loads
- Guest mode fallback with login prompt
- Logout button with navigation to login screen

---

## Application Flow

```
SplashScreen
    │
    ├─ Auto-login (valid token) → Root (Home, Cart, Profile)
    │
    ├─ Guest token → Root (Home, Cart, Profile)
    │
    └─ No token → LoginView
                    │
                    ├─ Login → Root
                    ├─ Signup → Root
                    └─ Guest → Root

Root
    │
    ├─ HomeScreen (product grid, search, categories)
    │       │
    │       └─ ProductDetailScreen → Add to Cart → Back to Home
    │
    ├─ CartScreen → CheckoutScreen → SuccessScreen → HomeScreen
    │
    └─ ProfileScreen → Edit Profile / Logout → LoginView
```

---

## Technical Architecture

### Pattern: Provider + Repository Layer

The application follows a layered architecture with clear boundaries between concerns:

**UI Layer (Screens)** — Consumes providers and calls repositories. Each screen manages its own loading, error, and data states via setState.

**State Management (Provider)** — CartProvider (ChangeNotifier) holds cart state and exposes computed values. The Provider is initialized at the app root and accessed via context.watch and context.read.

**Repository Layer** — AuthRepo and ProductRepo orchestrate API calls, parse responses into models, and handle business logic like token storage and error transformation.

**Service Layer** — ApiService provides generic get/post/put/delete methods that delegate to DioClient. All HTTP errors are caught and transformed into ApiError objects.

**Network Layer** — DioClient configures Dio with the base URL, content type headers, and an interceptor that attaches the JWT token from SharedPreferences to every outgoing request.

**Storage Layer** — PrefHelper wraps SharedPreferences with simple save/get/clear methods for the auth token.

### Data Flow

1. Screen calls a method on a Repository (e.g., `ProductRepo.getProducts()`)
2. Repository calls `ApiService.get(endpoint)` which delegates to DioClient
3. DioClient attaches the auth token from SharedPreferences via interceptor
4. Dio makes the HTTP request to the Remote API
5. Response flows back: Dio → ApiService → Repository
6. Repository parses JSON into Models (ProductModel, UserModel, etc.)
7. Data is returned to the Screen which calls setState() or updates a Provider
8. UI rebuilds and displays the data (or error/loading state)

### State Flow (Cart)

```
User taps "Add to Cart"
    → ProductDetailScreen calls CartProvider.addItem()
    → CartProvider updates internal List<FoodItem>, calls notifyListeners()
    → CartScreen (watching CartProvider) rebuilds
    → CheckoutScreen reads cart totals via Provider
```

---

## Folder Structure

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
|--------|---------------|
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

## State Management

### Provider (ChangeNotifier)

The application uses **Provider** with `ChangeNotifier` for state management. A single `CartProvider` is initialized at the app root via `ChangeNotifierProvider` in `main.dart` and is accessible throughout the widget tree.

**CartProvider** is the sole state management class. It holds:
- An internal `List<FoodItem>` representing cart items
- Computed properties: `itemCount`, `subtotal`, `tax` (5%), `deliveryFee` ($3.50), `total`
- Methods: `addItem`, `increment`, `decrement`, `remove`, `clear`

All mutations call `notifyListeners()` to trigger UI rebuilds in consuming widgets. Screens use `context.watch<CartProvider>()` for reactive rebuilds and `context.read<CartProvider>()` for one-shot method calls.

**Why Provider was chosen:** For an application of this scope, Provider provides the right balance of simplicity and capability. It avoids the boilerplate of BLoC while still maintaining clear state boundaries. The cart is the only cross-screen mutable state, making a single ChangeNotifier appropriate.

### Local State Management

All other screen-level state (loading, error, search query, selected category, form inputs) is managed via `setState()` in `StatefulWidget` classes. This keeps the state close to the widgets that use it and avoids unnecessary global state.

---

## Repository Pattern

### AuthRepo

`AuthRepo` is the single source of truth for all authentication-related operations:

- **login(email, password)** — POSTs to `/login`, parses `UserModel` from response, stores JWT token via `PrefHelper.saveToken()`, returns the user
- **signup(name, email, password)** — POSTs to `/register`, handles both 200 and 201 status codes, stores JWT, returns the user
- **getProfileData()** — GETs `/profile` with the stored token, returns `UserModel`
- **updateProfileData(name, email, address, visa, imagePath)** — POSTs to `/update-profile` using `FormData` for multipart upload (profile image as `MultipartFile`)
- **logout()** — POSTs to `/logout`, clears token from storage, sets `isGuest = true`
- **autoLogin()** — Checks stored token; if valid, fetches profile; if invalid, clears token and returns null
- **continueAsGuest()** — Stores the string `"guest"` as the token

The repository maintains an in-memory `_currentUser` reference and an `isGuest` flag to track session state without requiring re-fetching on every access.

### ProductRepo

`ProductRepo` handles all product-related API calls:

- **getProducts()** — GETs `/products`, parses the `data` array into `List<ProductModel>`
- **getToppings()** — GETs `/toppings`, parses into `List<ToppingModel>`
- **getOption()** — GETs `/side-options`, parses into `List<ToppingModel>`

Both repos instantiate their own `ApiService` instance. This keeps the dependency chain simple without requiring dependency injection at this scale.

---

## Networking Layer

### DioClient

`DioClient` configures the Dio HTTP client:

- **Base URL:** `https://sonic-zdi0.onrender.com/api`
- **Default headers:** `Content-Type: application/json`
- **Auth interceptor:** An `InterceptorsWrapper` that runs on every request:
  1. Reads the stored token from `PrefHelper.getToken()`
  2. If the token is non-null, non-empty, and not `"guest"`, attaches `Authorization: Bearer <token>` to the request headers
  3. If the token is null or `"guest"`, no auth header is attached (allowing unauthenticated requests for products)

The interceptor is added in the `DioClient` constructor, so every `ApiService` instance automatically benefits from token injection.

### ApiService

`ApiService` wraps DioClient with four generic CRUD methods:

- `get(endPoint)` — HTTP GET
- `post(endPoint, body)` — HTTP POST
- `put(endPoint, body)` — HTTP PUT
- `delete(endPoint, body)` — HTTP DELETE

Each method catches `DioException` and delegates to `ApiExceptions.handleError()`, returning either the parsed response data or an `ApiError` object.

### Dio Configuration

The Dio instance is configured with:
- Base URL pointing to the Render-hosted REST API
- JSON content type header for all requests
- Auth interceptor for automatic token attachment
- Commented-out `LogInterceptor` for debugging (enabled during development)

### ApiExceptions

`ApiExceptions.handleError()` maps `DioException` types to user-friendly error messages:

- `connectionTimeout` → "Connection timeout. Please check your internet connection"
- `sendTimeout` → "Request timeout. Please try again"
- `receiveTimeout` → "Response timeout. Please try again"
- HTTP 302 → "This Email Already Taken"
- Default → "An unexpected error occurred. Please try again"

The handler also extracts the `message` field from API error response bodies when available, providing server-side error messages to the UI.

### ApiError

A simple value class holding `message` (String) and optional `statusCode` (int). This serves as the unified error type throughout the application, thrown by repositories and caught by screens.

---

## Authentication Flow

### Login Flow

1. User enters email and password in `LoginView`
2. Form validation runs (email regex, minimum 6 characters for password)
3. `AuthRepo.login()` is called with trimmed credentials
4. `ApiService.post("/login", {...})` sends the request
5. Response is parsed: `code == 200` and `data != null` indicates success
6. `UserModel.fromJson(data)` extracts user data including JWT token
7. Token is stored via `PrefHelper.saveToken(user.token!)`
8. `_currentUser` is set and `isGuest` is set to `false`
9. Navigator pushes to `Root` screen

### Signup Flow

1. User enters name, email, and password in `SignupView`
2. `AuthRepo.signup()` sends a POST to `/register`
3. Response is parsed: `code == 200` or `code == 201` indicates success
4. Token is stored, user is set, navigation to `Root`

### Auto-Login Flow

1. `SplashScreen` creates an `AuthRepo` instance
2. `_checkLogin()` calls `authRepo.autoLogin()`
3. `autoLogin()` reads token from `PrefHelper.getToken()`
4. If token is null or `"guest"`, returns null (navigates to LoginView)
5. If token exists, calls `getProfileData()` which GETs `/profile`
6. If profile fetch succeeds, returns `UserModel` (navigates to Root)
7. If profile fetch fails (expired/invalid token), clears token and returns null

### Guest Mode

1. User taps "Guest" on Login or Signup screen
2. `AuthRepo.continuAsGuest()` stores the string `"guest"` as the token
3. `SplashScreen` detects the guest token and navigates to Root
4. Profile screen shows a login prompt for guest users
5. The Dio interceptor skips the Authorization header for guest tokens

---

## SharedPreferences

`PrefHelper` provides a minimal wrapper around SharedPreferences:

- `saveToken(String token)` — Stores the JWT (or "guest") under the key `auth_token`
- `getToken()` — Retrieves the stored token or null
- `clearToken()` — Removes the token from storage

Each method creates its own `SharedPreferences.getInstance()` call. This is a deliberate choice for simplicity — at this application scale, the overhead is negligible and avoids managing a singleton.

---

## Product Customization

The product detail screen (`ProductDetailScreen`) implements a comprehensive customization system:

### Spicy Level Selector

A `Slider` widget with `divisions: 4` produces values 1-5. Five chili emoji indicators are rendered with opacity based on the current level — filled emojis for the active level, faded for inactive.

### Toppings (Multi-Select)

- Fetched from `/toppings` API endpoint via `ProductRepo.getToppings()`
- Stored in a `Set<int>` of selected topping IDs for O(1) lookup
- `_toggleTopping(id)` adds or removes the ID from the set
- Rendered as `_ChipOption` widgets with network images and animated borders

### Side Options (Single-Select)

- Fetched from `/side-options` API endpoint via `ProductRepo.getOption()`
- Stored as a nullable `int? _selectedSide`
- Tapping a selected option deselects it (toggle behavior)
- Same `_ChipOption` widget with selection state

### Quantity Control

- `QtyControl` widget with minus/plus buttons
- Quantity is clamped to minimum 1 (prevents zero or negative quantities)
- Price in the "Add to Cart" button updates in real-time: `price * qty`

### Add to Cart

1. `CartProvider.addItem()` is called with a `FoodItem` copy with the selected quantity
2. If the item already exists in the cart (same ID), its quantity is incremented
3. Otherwise, the item is added as a new entry
4. A floating SnackBar confirms the addition
5. Navigator pops back to the home screen

---

## Cart Management

### CartProvider

The cart system is implemented as a `ChangeNotifier` with the following API:

- **items** — `List.unmodifiable(_items)` prevents external mutation
- **itemCount** — Sum of all quantities across items
- **subtotal** — Sum of `price * quantity` for all items
- **tax** — 5% of subtotal
- **deliveryFee** — $3.50 if subtotal > 0, else $0
- **total** — `subtotal + tax + deliveryFee`

### Cart Operations

- **addItem(FoodItem)** — Checks if item exists by ID. If yes, increments quantity. If no, adds new item. Uses `copyWith` for immutable updates.
- **increment(id)** — Increases quantity by 1
- **decrement(id)** — Decreases quantity by 1. If quantity reaches 0, removes the item entirely.
- **remove(id)** — Removes item by ID
- **clear() — Empties the cart (called after successful checkout)

### Price Calculation

All price calculations are computed properties that recalculate on every access:

```dart
double get subtotal => _items.fold(0, (sum, item) => sum + item.price * item.quantity);
double get tax => subtotal * 0.05;
double get deliveryFee => subtotal > 0 ? 3.50 : 0.0;
double get total => subtotal + tax + deliveryFee;
```

This ensures the UI always reflects the current cart state without manual recalculation.

---

## Checkout Process

1. **Order Summary** — Lists all cart items with emoji, name, quantity, and line total
2. **Financial Breakdown** — Subtotal, 5% tax, $3.50 delivery fee, and grand total
3. **Estimated Delivery** — Card showing 15-20 minute delivery estimate
4. **Payment Selection** — Toggle between Cash on Delivery and Visa (stored in local state `_paymentMethod`)
5. **Save Card Option** — Checkbox-like UI for future payments
6. **Pay Now** — Clears the cart via `CartProvider.clear()` and navigates to `SuccessScreen` using `pushAndRemoveUntil` to clear the navigation stack
7. **Success Screen** — Animated checkmark (elastic scale), fade-in text, delivery estimate card, and "Back to Home" button

---

## Navigation Architecture

### Root-Level Navigation

`Root` uses a `PageView` with `NeverScrollableScrollPhysics` (disabling swipe navigation) controlled by a `GlassBottomNavBar`. Three screens are embedded:

1. `HomeScreen`
2. `CartScreen`
3. `ProfileScreen`

The `PageController` animates between pages with `Curves.easeOutExpo` over 300ms.

### Tab Navigation

The `GlassBottomNavBar` provides four tabs: Home, Cart, History (placeholder), and Profile. Animated icon transitions use `AnimationController` with `AnimatedIcons` — icons animate between outlined and filled states when selected.

### Screen Transitions

- Product detail: Standard `MaterialPageRoute` push
- Checkout: Push from cart
- Success: `pushAndRemoveUntil` to clear the stack back to the first route
- Back to home: `pushAndRemoveUntil` with `route => false` to clear everything
- Logout: `pushReplacement` to LoginView
- Back navigation: Custom styled back buttons using `Navigator.pop` or `popUntil`

---

## Responsive UI

### Product Grid

The home screen uses a `SliverGridDelegateWithFixedCrossAxisCount` with:
- `crossAxisCount: 2` — 2-column layout
- `crossAxisSpacing: 14` — Horizontal gap between cards
- `mainAxisSpacing: 14` — Vertical gap between rows
- `childAspectRatio: 0.78` — Cards are slightly taller than wide

This provides a consistent grid layout across different screen sizes.

### Search and Categories

- Search bar uses a full-width `TextField` with custom decoration
- Category pills are rendered in a horizontal `SingleChildScrollView` for overflow handling
- Both adapt naturally to different screen widths

### Cart and Checkout

- Cart items use `ListView.separated` for efficient scrolling
- Checkout uses `SingleChildScrollView` with padded content
- Total/price sections use fixed bottom containers

### Profile

- Profile form uses `SingleChildScrollView` with `Clip.none` to prevent overflow
- Pull-to-refresh via `RefreshIndicator`
- Image picker for gallery selection

---

## Glassmorphism Design

### GlassBottomNavBar

The bottom navigation bar is the centerpiece of the glassmorphism design system:

- **BackdropFilter** with `ImageFilter.blur(sigmaX: 50, sigmaY: 80)` creates the frosted glass effect
- **Semi-transparent white container** (`Colors.white.withOpacity(0.1)`) with rounded corners
- **Animated pill indicator** — A circular gradient container that slides between tabs using `AnimatedPositioned`
- **Animated icons** — Icons switch between outlined and filled states using `AnimationController` with `AnimatedIcons`
- **LayoutBuilder** calculates pill position based on tab width and current index

### GlassContainer

A reusable frosted glass wrapper function used on auth screens:

- Green gradient background with varying opacity
- `BackdropFilter` with blur sigma of 10 and 20
- White overlay with box shadow
- Applied to Login and Signup screens for a cohesive visual language

### Why Glassmorphism

Glassmorphism was chosen to create a distinctive visual identity that differentiates Hungryy from standard Material Design applications. The frosted glass effect adds depth and sophistication while maintaining readability. The approach uses Flutter's built-in `BackdropFilter` and `ImageFilter.blur` — no external packages required.

---

## Reusable Components

### Component Library (`lib/component/`)

| Widget | Description |
|--------|-------------|
| `CustomText` | Fully customizable text widget exposing all TextStyle properties (color, size, weight, textAlign, maxLines, overflow, height, letterSpacing, shadows, decoration). Uses `TextScaler.linear(1.0)` to prevent system font scaling. |
| `CustomButton` | Generic tap target with configurable width, height, color, border radius, text color, and optional child widget. Used for auth actions and general-purpose buttons. |
| `CustomTxtfield` | Auth-styled `TextFormField` with password toggle (eye icon), custom decoration (enabled/focused/error borders), and validator support. |
| `CustomSnack` | Factory function returning a styled floating `SnackBar` with icon and error message. Red background with rounded corners. |
| `GlassContainer` | Function returning a frosted glass container with gradient and blur. Used as a background wrapper for auth screens. |
| `GlassBottomNavBar` | Animated bottom navigation bar with glassmorphism, pill indicator, and animated icons. |

### Shared Widgets (`lib/widget/common_widgets.dart`)

| Widget | Description |
|--------|-------------|
| `PrimaryButton` | Full-width `ElevatedButton` with optional icon. Used for checkout, retry, and primary actions. |
| `QtyControl` | Quantity selector with minus/plus buttons and count display. Used in cart and product detail screens. |
| `CategoryPill` | Horizontal pill-shaped category filter with animated selection (color transition). |
| `SectionTitle` | Section header text with consistent styling (15px, weight 800). |
| `PaymentTile` | Payment method selector with icon, label, and radio-style indicator. Animated border and background on selection. |

### Auth Widgets (`lib/features/auth/widget/`)

| Widget | Description |
|--------|-------------|
| `CustomAuthBtn` | Auth action button with optional person icon. Used for Login/Signup/Guest navigation. |
| `CustomUserTxtField` | Profile form `TextField` with primary color styling and rounded borders. |

---

## Models

### FoodItem (`lib/models/food_item.dart`)

The core data model used across features for cart operations:

| Field | Type | Description |
|-------|------|-------------|
| `id` | `int` | Unique identifier |
| `name` | `String` | Product name |
| `category` | `String` | Computed category |
| `price` | `double` | Unit price |
| `rating` | `double` | Product rating |
| `emoji` | `String` | Display emoji fallback |
| `description` | `String` | Product description |
| `imageUrl` | `String?` | Network image URL |
| `quantity` | `int` | Quantity in cart (default 1) |

Implements `copyWith()` for immutable updates — essential for the cart system.

### ProductModel (`lib/features/home/data/models/product_model.dart`)

The API response model for products:

| Field | Type | Description |
|-------|------|-------------|
| `id` | `int` | Unique identifier |
| `name` | `String` | Product name |
| `image` | `String` | Raw image URL from API |
| `desc` | `String` | Product description |
| `price` | `String` | Price as string from API |
| `rate` | `String` | Rating as string from API |
| `priceValue` | `double` | Computed: parsed price |
| `ratingValue` | `double` | Computed: parsed rating |
| `imageUrl` | `String?` | Computed: normalized HTTPS URL |
| `category` | `String` | Computed: derived from product name |
| `fallbackEmoji` | `String` | Computed: emoji based on product name |

Key implementation details:
- `normalizedImageUrl` converts HTTP URLs to HTTPS for secure image loading
- `fallbackEmoji` uses keyword matching (juice, chicken, burger, combo, etc.) to select appropriate emojis
- `category` is computed from the product name using string matching
- `toFoodItem()` converts the API model to the cart-compatible `FoodItem` model
- `fromJson` handles nullable fields and type coercion via `int.tryParse` and `_stringValue` helper

### ToppingModel (`lib/features/home/data/models/topping_model.dart`)

| Field | Type | Description |
|-------|------|-------------|
| `id` | `int` | Unique identifier |
| `name` | `String` | Topping/side name |
| `image` | `String?` | Raw image URL |

Includes `normalizedImageUrl` getter for HTTP-to-HTTPS conversion.

### UserModel (`lib/features/auth/data/user_model.dart`)

| Field | Type | Description |
|-------|------|-------------|
| `name` | `String` | User's full name |
| `email` | `String` | User's email address |
| `image` | `String?` | Profile image URL |
| `token` | `String?` | JWT authentication token |
| `address` | `String?` | User's address |
| `visa` | `String?` | VISA card identifier |

Handles the `"null"` string case from the API by converting it to actual null.

---

## Validation

### Login Form

- **Email:** Required field with regex validation: `r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'`
- **Password:** Required field with minimum length of 6 characters
- Custom error messages displayed inline via `TextFormField.validator`

### Signup Form

- **Name:** Required field
- **Email:** Required field with same regex as login
- **Password:** Required field with minimum length of 6 characters

### Profile Form

- Uses `TextField` (not `TextFormField`) so validation is handled server-side
- Form fields are pre-populated with existing profile data

### Error Display

Form validation errors are displayed via the built-in `TextFormField` error styling with red text at 11px size.

---

## Image Loading Strategy

### Network Images

All network images use Flutter's built-in `Image.network()` with:

- **loadingBuilder** — Displays a centered `CircularProgressIndicator` with primary color while the image loads
- **errorBuilder** — Falls back to an emoji or broken image icon when the network image fails

### HTTP to HTTPS Normalization

Both `ProductModel` and `ToppingModel` implement `normalizedImageUrl` that converts HTTP URLs to HTTPS:

```dart
String? get normalizedImageUrl {
  final value = image.trim();
  if (value.isEmpty) return null;
  if (value.startsWith('http://')) {
    return value.replaceFirst('http://', 'https://');
  }
  return value;
}
```

This prevents mixed-content issues on iOS and ensures secure image loading.

### Emoji Fallback

When an image URL is null, empty, or fails to load, the product card and detail screen display an emoji derived from the product name. The `fallbackEmoji` getter in `ProductModel` uses keyword matching:

- Chicken → 🍗
- Burger → 🍔
- Juice/Smoothie/Shake → 🧃
- Sundae/Brownie/Dessert → 🍰
- Combo/Meal/Family/Box → 🍱
- Default → 🍽️

### Profile Image

Profile images support three states:
1. Selected local image (via ImagePicker) → displayed with `Image.file()`
2. API image URL → displayed with `Image.network()` with error fallback
3. No image → Icon placeholder (`Icons.person`)

---

## Skeleton Loading

The home screen implements skeleton loading using the `skeletonizer` package:

```dart
Skeletonizer(
  enabled: true,
  containersColor: AppColors.primary.withOpacity(0.12),
  child: GridView.builder(
    gridDelegate: _gridDelegate,
    itemCount: skeletonProducts.length,
    itemBuilder: (_, index) => _ProductCard(product: skeletonProducts[index]),
  ),
)
```

Six skeleton product cards are generated with placeholder data ("Loading product", "Loading description", price "0", rating "0"). The `Skeletonizer` widget automatically applies shimmer effects to all child widgets, creating a cohesive loading state that matches the actual product card layout.

---

## Loading States

Every data-driven screen implements three states:

### Loading State
- Home screen: Skeleton loading with shimmer effect
- Product detail: Loading indicators for toppings and side options sections
- Profile: Skeletonizer wrapping the entire form

### Error State
- Home screen: Cloud-off icon, error message, and retry button
- Auth operations: SnackBar with red background and error message
- Profile: SnackBar for profile fetch/update failures

### Empty State
- Home screen: Emoji and "No items found" or "No products available" message
- Cart: Shopping cart emoji with "Your cart is empty" and "Add some delicious items!"
- Toppings/Options: "No toppings available" / "No side options available"

---

## Error Handling

### Network Errors

`ApiExceptions.handleError()` catches all `DioException` types and maps them to user-friendly messages. The error flows through the repository layer as an `ApiError` object.

### API Errors

API responses with error codes are caught in repositories:

```dart
if (response is ApiError) throw response;
if (code != 200) throw ApiError(message: msg);
```

### Screen-Level Error Handling

Screens catch errors and update local state:

```dart
try {
  final products = await _productRepo.getProducts();
  setState(() { _products = products; _isLoading = false; });
} on ApiError catch (error) {
  setState(() { _errorMessage = error.message; _isLoading = false; });
} catch (_) {
  setState(() { _errorMessage = 'Failed to load products.'; _isLoading = false; });
}
```

### Mounted Checks

All asynchronous operations in `StatefulWidget` check `if (!mounted) return` before calling `setState()` to prevent memory leaks and framework errors.

---

## Performance Considerations

### Unmodifiable Lists

`CartProvider.items` returns `List.unmodifiable(_items)` to prevent external mutation of the internal cart state.

### Immutable Model Updates

`FoodItem.copyWith()` creates new instances rather than mutating existing ones, ensuring proper equality checks and preventing stale state.

### Efficient Filtering

`_filteredProducts` is computed as a getter that runs on every build. For the expected catalog size (dozens, not thousands), this is efficient without caching. The filter uses `where` with early termination.

### Image Loading

Network images use `loadingBuilder` and `errorBuilder` for graceful degradation. No pre-caching is implemented, but the `skeletonizer` package provides visual continuity during load.

### Animation Controllers

All `AnimationController` instances are properly disposed in `dispose()` methods. The glass nav bar uses `TickerProviderStateMixin` for multiple concurrent animations.

### PageView with NeverScrollableScrollPhysics

Disabling swipe navigation on the root PageView prevents accidental page changes and reduces gesture handling overhead.

---

## Technical Decisions

### Provider Over BLoC/Riverpod

For an application with a single cross-screen state (cart), Provider provides the right level of simplicity. BLoC would add unnecessary boilerplate, and Riverpod's learning curve doesn't justify the benefits at this scale.

### Feature-Based Folder Structure

Organizing code by feature (`features/auth/`, `features/home/`, etc.) rather than by type (`screens/`, `models/`, `repos/`) makes it easier to locate all code related to a feature and supports future feature extraction.

### Repository Pattern

The repository layer abstracts API calls from the UI, making it straightforward to swap the backend, add caching, or write tests without touching screen code.

### Dio Over http

Dio was chosen for its interceptor system (automatic token injection), built-in timeout configuration, and richer error types compared to the `http` package.

### Glassmorphism Over Standard Material

The glassmorphism design system was implemented to create a distinctive visual identity. Using Flutter's `BackdropFilter` and `ImageFilter.blur` keeps the implementation dependency-free.

### Emoji Fallbacks

Using emoji as image fallbacks ensures the UI always has visual content, even when network images fail or are slow to load. The keyword-based emoji selection in `ProductModel.fallbackEmoji` provides contextually appropriate placeholders.

### CopyWith Pattern

`FoodItem.copyWith()` enables immutable updates for cart operations, which is essential for ChangeNotifier-based state management where `notifyListeners()` depends on reference changes.

---

## Challenges

### API Response Format Inconsistencies

The backend returns prices and ratings as strings rather than numbers, requiring parsing in the model layer. Some fields return the string `"null"` instead of actual null, requiring special handling in `UserModel.fromJson()`.

**Solution:** Robust parsing with `int.tryParse`, `double.tryParse`, and `_stringValue()` helper that normalizes all input to strings. The `"null"` string case is explicitly checked in `UserModel`.

### HTTP to HTTPS Image URLs

The API returns some image URLs with `http://` protocol, which causes mixed-content issues on iOS and may be blocked by default.

**Solution:** `normalizedImageUrl` getter in both `ProductModel` and `ToppingModel` replaces `http://` with `https://` at the model level.

### Token Management Across Screens

Multiple screens and repositories need access to the auth token, but SharedPreferences is asynchronous.

**Solution:** The `DioClient` interceptor reads the token on every request, ensuring it's always fresh. Repositories don't need to pass tokens explicitly.

### Cart State Synchronization

The cart state needs to be accessible from HomeScreen (add to cart), CartScreen (view/modify), CheckoutScreen (read totals), and ProductDetailScreen (add to cart).

**Solution:** A single `CartProvider` at the app root makes the cart state available everywhere via `context.watch` and `context.read`.

### Navigation Stack Management

After checkout, the user should return to the home screen, not the checkout or cart screen.

**Solution:** `pushAndRemoveUntil` with appropriate route predicates clears the navigation stack to the desired point.

---

## Problems Faced

### 1. Debug Credentials in Login Screen

The login screen had pre-filled email and password for development purposes. These remained in the codebase.

**Resolution:** Identified in the README as a known debug artifact to be removed before production release.

### 2. Nunito Font Not Bundled

The theme declares `fontFamily: 'Nunito'` but no font files are present in the assets directory.

**Resolution:** The app falls back to the system font. Listed as a future improvement to bundle the font files.

### 3. Lottie Animations Not Integrated

Lottie JSON files exist in `assets/lottie/` (burger, login, chef, background wave) but are not rendered in any screen.

**Resolution:** Listed as a future improvement to integrate animations into auth and home screens.

### 4. 3D Model Not Rendered

GLB files exist in `assets/3dModel/` and `assets/test/` but no Dart widget renders them.

**Resolution:** Listed as a future improvement to integrate `model_viewer` or `flutter_cube`.

---

## Lessons Learned

### Architecture Planning Pays Off

Defining the folder structure and data flow before writing code prevented major refactoring later. The feature-based organization made it easy to add new screens and models without breaking existing code.

### Error Handling Must Be Comprehensive

Every API call can fail. Wrapping all network operations in try-catch blocks and providing meaningful error messages to the user is essential for a production-quality application.

### Model Design Drives the Application

The `ProductModel` and `FoodItem` models were designed with computed properties (`priceValue`, `imageUrl`, `fallbackEmoji`, `category`) that encapsulate business logic. This kept screen code clean and focused on presentation.

### Reusable Components Save Time

Investing in `CustomText`, `PrimaryButton`, `QtyControl`, and other shared widgets early eliminated duplication across screens and made UI changes propagate automatically.

### State Management Should Match Scope

Provider was the right choice for this application. Over-engineering with BLoC or Riverpod would have added complexity without proportional benefits.

---

## Skills Demonstrated

- **Flutter Development** — Complete application built with Flutter SDK 3.10.1+
- **Dart Programming** — Strong typing, async/await, collections, mixins, extension-like patterns
- **Architecture Design** — Layered architecture with repository pattern and feature-based organization
- **State Management** — Provider with ChangeNotifier for reactive state
- **Networking** — Dio with interceptors, generic CRUD service, error handling
- **Authentication** — JWT token management, persistent sessions, auto-login, guest mode
- **Local Storage** — SharedPreferences for token persistence
- **UI/UX Design** — Glassmorphism, animations, skeleton loading, responsive layouts
- **API Integration** — RESTful API consumption with JSON parsing and model transformation
- **Error Handling** — Comprehensive try-catch, user-friendly error messages, loading states
- **Code Organization** — Clean folder structure, reusable components, separation of concerns

---

## Responsibilities

- Designed and implemented the complete application architecture
- Built all screens, widgets, and reusable components
- Implemented the networking layer with Dio and auth interceptor
- Created the repository pattern for data access
- Built the cart system with Provider-based state management
- Implemented authentication flow with token persistence
- Designed the glassmorphism UI system
- Handled all error cases and loading states
- Organized the codebase into a scalable feature-based structure

---

## Key Achievements

- Complete end-to-end food ordering flow from browsing to checkout
- Real-time API integration with a hosted REST backend
- Glassmorphism navigation with animated pill indicator
- Skeleton loading for all data-driven screens
- Image fallback system using contextually appropriate emojis
- Profile management with image upload via gallery
- Auto-login with persistent JWT token sessions
- Cart system with tax and delivery fee calculations
- Clean, maintainable codebase with consistent patterns

---

## Future Improvements

1. **Order History Screen** — Currently commented out in `root.dart`; wire it up with an API endpoint and display past orders
2. **3D Model Rendering** — GLB files exist but are not rendered; integrate `model_viewer` or `flutter_cube`
3. **Lottie Animation Integration** — Add Lottie animations to auth and home screens for enhanced visual feedback
4. **Nunito Font Bundling** — Add `.ttf` font files and register in `pubspec.yaml`
5. **Push Notifications** — Add `firebase_messaging` for order status updates
6. **Localization** — Add `flutter_localizations` and ARB files for multi-language support
7. **Unit & Widget Tests** — Write meaningful tests for repositories, providers, and screens
8. **Dark Mode** — Extend `AppTheme` with a dark theme variant and add a toggle
9. **Pagination** — Add infinite scroll to the product grid for large catalogs
10. **CI/CD** — Add GitHub Actions workflow for automated build and test
11. **Remove Debug Artifacts** — Clean up `debugPrint()` calls and pre-filled credentials
12. **Form Validation Enhancement** — Extract validators into reusable helper functions

---

## Conclusion

Hungryy is a comprehensive Flutter application that demonstrates production-quality mobile development across every layer of the stack. From the Dio interceptor that automatically attaches JWT tokens, to the Provider-based cart system with real-time price calculations, to the glassmorphism UI with animated navigation — every component was built with deliberate architectural decisions and clean implementation.

The project showcases the ability to design and build a complete, feature-rich mobile application: handling authentication, networking, state management, local storage, UI design, error handling, and code organization in a single cohesive codebase. The feature-based folder structure and reusable component system ensure the application is maintainable and extensible.

This case study reflects every significant implementation decision and technical detail in the Hungryy codebase. The application stands as evidence of strong Flutter development skills applied to a real-world problem domain.

---

*All features documented in this case study are verified against the actual source code in the Hungryy repository.*
