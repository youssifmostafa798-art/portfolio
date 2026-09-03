# MaxFashion Flutter Application — Complete Color System Audit

**Date:** September 3, 2026
**Scope:** Analysis-only audit of the entire MaxFashion Flutter codebase
**Purpose:** Document the exact visual color palette for portfolio reuse

---

## 1. Executive Summary

MaxFashion uses a **minimal, monochromatic color system** with a single accent color (warm orange-brown). The design is predominantly **black-and-white** with a carefully curated grey scale. The visual identity is defined by:

- **High-contrast black/white core** — the entire UI is built on black text on white surfaces (light) and white text on dark surfaces (dark)
- **Warm orange-brown accent (#DD8560)** — used exclusively for prices, favorite/wishlist states, and badge counters
- **Green accent (#2E7D32)** — used for success states, free delivery labels, and destructive action indicators
- **Full dark theme support** — with dedicated dark surfaces (#121212, #181818)
- **No primary brand color** — the app deliberately avoids a dominant hue, relying on neutrality

The app uses **20 distinct color values** across the global theme system, plus **5 hardcoded colors** in widgets, and **12 Material `Colors.*` references** for semantic/destructive states.

---

## 2. Global/Theme Colors

### 2.1 `AppColors` Class (Source of Truth)

**File:** `lib/core/theme/app_colors.dart`

| Constant Name       | HEX Value  | Role                          |
| ------------------- | ---------- | ----------------------------- |
| `black`             | `#000000`  | Primary text (light mode)     |
| `blackMedium`       | `#2D2D2D`  | Dark surface variant          |
| `white`             | `#FFFFFF`  | Background (light mode)       |
| `grey100`           | `#F5F5F5`  | Lightest background/surface   |
| `grey200`           | `#EEEEEE`  | Borders, dividers (light)     |
| `grey400`           | `#BDBDBD`  | Unselected icons (dark mode)  |
| `grey500`           | `#9E9E9E`  | Secondary text, unselected    |
| `grey800`           | `#424242`  | Dark grey, dividers (dark)    |
| `darkSurface`       | `#181818`  | Dark AppBar/nav backgrounds   |
| `accent`            | `#2E7D32`  | Green accent, success, free   |
| `successGreen50`    | `#E8F5E9`  | Success container background  |
| `successGreen200`   | `#A5D6A7`  | Success border                |
| `successGreen700`   | `#388E3C`  | Success icon                  |
| `successGreen800`   | `#2E7D32`  | Success text (== accent)      |
| `errorRed200`       | `#EF9A9A`  | Error price display           |
| `errorRed400`       | `#EF5350`  | Error text, destructive btn   |
| `cardGrey800`       | `#424242`  | Credit card background        |

### 2.2 Hardcoded in Theme (not in AppColors)

| Value        | Location                    | Role                          |
| ------------ | --------------------------- | ----------------------------- |
| `#121212`    | `app_theme.dart` (x4)      | Dark scaffold + nav bar color |

---

## 3. Complete Color Inventory

### 3.1 All Unique Color Values Used in the App

| #  | Color Name / Constant         | HEX/RGB        | ARGB (Flutter)              | Source File                     | Global? |
| -- | ----------------------------- | -------------- | --------------------------- | ------------------------------- | ------- |
| 1  | `black`                       | `#000000`      | `Color(0xFF000000)`         | `app_colors.dart`               | Yes     |
| 2  | `blackMedium`                 | `#2D2D2D`      | `Color(0xFF2D2D2D)`         | `app_colors.dart`               | Yes     |
| 3  | `white`                       | `#FFFFFF`      | `Color(0xFFFFFFFF)`         | `app_colors.dart`               | Yes     |
| 4  | `grey100`                     | `#F5F5F5`      | `Color(0xFFF5F5F5)`         | `app_colors.dart`               | Yes     |
| 5  | `grey200`                     | `#EEEEEE`      | `Color(0xFFEEEEEE)`         | `app_colors.dart`               | Yes     |
| 6  | `grey400`                     | `#BDBDBD`      | `Color(0xFFBDBDBD)`         | `app_colors.dart`               | Yes     |
| 7  | `grey500`                     | `#9E9E9E`      | `Color(0xFF9E9E9E)`         | `app_colors.dart`               | Yes     |
| 8  | `grey800`                     | `#424242`      | `Color(0xFF424242)`         | `app_colors.dart`               | Yes     |
| 9  | `darkSurface`                 | `#181818`      | `Color(0xFF181818)`         | `app_colors.dart`               | Yes     |
| 10 | `accent`                      | `#2E7D32`      | `Color(0xFF2E7D32)`         | `app_colors.dart`               | Yes     |
| 11 | `successGreen50`              | `#E8F5E9`      | `Color(0xFFE8F5E9)`         | `app_colors.dart`               | Yes     |
| 12 | `successGreen200`             | `#A5D6A7`      | `Color(0xFFA5D6A7)`         | `app_colors.dart`               | Yes     |
| 13 | `successGreen700`             | `#388E3C`      | `Color(0xFF388E3C)`         | `app_colors.dart`               | Yes     |
| 14 | `successGreen800`             | `#2E7D32`      | `Color(0xFF2E7D32)`         | `app_colors.dart`               | Yes     |
| 15 | `errorRed200`                 | `#EF9A9A`      | `Color(0xFFEF9A9A)`         | `app_colors.dart`               | Yes     |
| 16 | `errorRed400`                 | `#EF5350`      | `Color(0xFFEF5350)`         | `app_colors.dart`               | Yes     |
| 17 | `cardGrey800`                 | `#424242`      | `Color(0xFF424242)`         | `app_colors.dart`               | Yes     |
| 18 | Dark scaffold                 | `#121212`      | `Color(0xFF121212)`         | `app_theme.dart`                | Yes     |
| 19 | **Orange price**              | `#DD8560`      | `Color(0xFFDD8560)`         | 5 widget files (hardcoded)      | No      |
| 20 | **Gold star rating**          | `#FFB800`      | `Color(0xFFFFB800)`         | `order_rating_widget.dart`      | No      |
| 21 | `Colors.red.shade300`         | `#EF9A9A`      | Material shade               | 4 widget files                  | No      |
| 22 | `Colors.grey.shade800`        | `#424242`      | Material shade               | `shimmer_effect.dart`           | No      |
| 23 | `Colors.grey.shade700`        | `#616161`      | Material shade               | `shimmer_effect.dart`           | No      |
| 24 | `Colors.grey.shade300`        | `#E0E0E0`      | Material shade               | `shimmer_effect.dart`           | No      |
| 25 | `Colors.grey.shade100`        | `#F5F5F5`      | Material shade               | `shimmer_effect.dart`           | No      |
| 26 | `Colors.blue.shade100`        | `#BBDEFB`      | Material shade               | `order_status_chip.dart`        | No      |
| 27 | `Colors.blue.shade800`        | `#1565C0`      | Material shade               | `order_status_chip.dart`        | No      |
| 28 | `Colors.green.shade100`       | `#C8E6C9`      | Material shade               | `order_status_chip.dart`        | No      |
| 29 | `Colors.green.shade800`       | `#2E7D32`      | Material shade               | `order_status_chip.dart`        | No      |
| 30 | `Colors.orange`               | `#FF9800`      | Material constant            | `app_message_dialog.dart`       | No      |
| 31 | `Colors.transparent`          | `#00000000`    | Material constant            | Multiple files                  | No      |

---

## 4. Hardcoded Color Audit

### A. Core/Brand Colors

These colors define the visual identity and appear across multiple files:

| Color       | Value      | Files Using It                                                                                     | Purpose                    |
| ----------- | ---------- | -------------------------------------------------------------------------------------------------- | -------------------------- |
| `#DD8560`   | Warm orange | `card_widget.dart`, `product_grid_card.dart`, `favorite_button.dart`, `badge_widget.dart`, `search_results_list.dart` | Prices, favorites, badges  |
| `#2E7D32`   | Green      | `app_colors.dart` (as `accent` and `successGreen800`)                                              | Accent, success, "free"    |
| `#FFB800`   | Gold       | `order_rating_widget.dart`                                                                         | Star ratings               |

### B. Semantic Colors

| Color          | Value      | Files Using It                                                  | Purpose               |
| -------------- | ---------- | --------------------------------------------------------------- | --------------------- |
| `#EF9A9A`      | Light red  | `app_colors.dart`, `action_chip_widget.dart`, `app_confirmation_dialog.dart`, `wishlist_item_card.dart`, `cart_item_card.dart` | Destructive bg, error |
| `#EF5350`      | Red        | `app_colors.dart`, `verify_reset_code_page.dart`, `profile_form_section.dart`, `edit_profile_page.dart` | Error text, borders   |
| `#388E3C`      | Dark green | `app_colors.dart`                                               | Success icon          |
| `#E8F5E9`      | Pale green | `app_colors.dart`                                               | Success container bg  |
| `#A5D6A7`      | Soft green | `app_colors.dart`                                               | Success border        |

### C. UI/Supporting Colors

| Color          | Value      | Files Using It                | Purpose                    |
| -------------- | ---------- | ----------------------------- | -------------------------- |
| `#F5F5F5`      | Grey 100   | `app_colors.dart`             | Light surfaces             |
| `#EEEEEE`      | Grey 200   | `app_colors.dart`             | Borders, dividers          |
| `#BDBDBD`      | Grey 400   | `app_colors.dart`             | Unselected nav (dark)      |
| `#9E9E9E`      | Grey 500   | `app_colors.dart`             | Secondary text, inactive   |
| `#424242`      | Grey 800   | `app_colors.dart`             | Dark grey, credit card bg  |
| `#181818`      | Dark surface | `app_colors.dart`           | Dark AppBar, nav bar       |
| `#2D2D2D`      | Black medium | `app_colors.dart`           | Dark surface variant       |
| `#121212`      | Darkest    | `app_theme.dart`              | Dark scaffold, dark nav    |

### D. One-off/Local Colors

| Color          | Value      | Files Using It                                                  | Purpose                    |
| -------------- | ---------- | --------------------------------------------------------------- | -------------------------- |
| `#BBDEFB`      | Blue 100   | `order_status_chip.dart`                                        | "Shipped" status bg        |
| `#1565C0`      | Blue 800   | `order_status_chip.dart`                                        | "Shipped" status text      |
| `#C8E6C9`      | Green 100  | `order_status_chip.dart`                                        | "Delivered" status bg      |
| `#616161`      | Grey 700   | `shimmer_effect.dart`                                           | Dark shimmer highlight     |
| `#E0E0E0`      | Grey 300   | `shimmer_effect.dart`                                           | Light shimmer base         |
| `#FF9800`      | Orange     | `app_message_dialog.dart`                                       | Warning dialog icon        |

### E. Package/Framework Default Colors

| Value        | Source                               | Purpose                       |
| ------------ | ------------------------------------ | ----------------------------- |
| `Colors.transparent` | `flutter/material.dart`     | Status bar, system overlays   |
| `Colors.white` | `flutter/material.dart`     | Dark mode icon, destructive bg text |
| `Colors.black` | `flutter/material.dart`    | AppBar background (dark mode) |
| `Colors.blue` | `flutter/material.dart`     | Shipped order status          |
| `Colors.green` | `flutter/material.dart`    | Delivered order status        |
| `Colors.yellow` | `flutter/material.dart`   | Cart color swatch             |
| `Colors.orange` | `flutter/material.dart`   | Warning dialogs               |
| `Colors.pink` | `flutter/material.dart`     | Cart color swatch             |
| `Colors.purple` | `flutter/material.dart`   | Cart color swatch             |
| `Colors.grey` | `flutter/material.dart`     | Default cart color swatch     |
| `Colors.brown` | `flutter/material.dart`    | Cart color swatch             |
| `Colors.red` | `flutter/material.dart`     | Destructive swatch            |

---

## 5. Final Recommended MaxFashion Palette

These are the colors that define the MaxFashion visual identity:

| Role           | Color Name              | HEX/ARGB        | Usage                                             | Source                    |
| -------------- | ----------------------- | --------------- | ------------------------------------------------- | ------------------------- |
| **Primary Text (Light)** | `black`        | `#000000`       | Headings, body text, icons in light mode          | `app_colors.dart`         |
| **Primary Text (Dark)**  | `white`        | `#FFFFFF`       | Headings, body text, icons in dark mode           | `app_colors.dart`         |
| **Background (Light)**   | `white`        | `#FFFFFF`       | Page scaffold background                          | `app_colors.dart`         |
| **Background (Dark)**    | Dark scaffold  | `#121212`       | Page scaffold background (dark mode)              | `app_theme.dart`          |
| **Surface (Light)**      | `white`        | `#FFFFFF`       | Cards, sheets, dialogs                            | `app_colors.dart`         |
| **Surface (Dark)**       | `darkSurface`  | `#181818`       | AppBar, nav bar, elevated surfaces (dark)         | `app_colors.dart`         |
| **Surface Container**    | `grey100`      | `#F5F5F5`       | Search bar bg, chips, light containers            | `app_colors.dart`         |
| **Text Secondary**       | `grey500`      | `#9E9E9E`       | Hints, subtitles, inactive nav items              | `app_colors.dart`         |
| **Border (Light)**       | `grey200`      | `#EEEEEE`       | Dividers, input borders, card borders             | `app_colors.dart`         |
| **Border (Dark)**        | `grey800`      | `#424242`       | Dividers, input borders (dark mode)               | `app_colors.dart`         |
| **Accent (Brand)**       | Orange price   | `#DD8560`       | Prices, favorite hearts, badge counters           | Hardcoded in widgets      |
| **Accent (Green)**       | `accent`       | `#2E7D32`       | "Free" label, language selection, destructive UI  | `app_colors.dart`         |
| **Success (Primary)**    | `successGreen700` | `#388E3C`     | Success icons, snackbar backgrounds               | `app_colors.dart`         |
| **Success (Container)**  | `successGreen50` | `#E8F5E9`      | Success message background                        | `app_colors.dart`         |
| **Error (Primary)**      | `errorRed400`  | `#EF5350`       | Error text, validation borders, delete buttons    | `app_colors.dart`         |
| **Error (Light)**        | `errorRed200`  | `#EF9A9A`       | Price highlights, error message backgrounds       | `app_colors.dart`         |
| **Disabled**             | `onSurface` w/ alpha 0.5 | `#000000` @ 50% | Disabled button text                      | `custom_button.dart`      |
| **Star Rating**          | Gold          | `#FFB800`       | Selected star in order rating                     | `order_rating_widget.dart`|

---

## 6. Semantic Color Mapping

### 6.1 Color → Role Relationships

| Semantic Role           | Light Mode Color                | Dark Mode Color                 | Files                                 |
| ----------------------- | ------------------------------- | ------------------------------- | ------------------------------------- |
| **Page background**     | `#FFFFFF` (white)               | `#121212`                       | `app_theme.dart`, `main_screen.dart`  |
| **AppBar background**   | `#FFFFFF`                       | `#181818` (darkSurface)         | `app_theme.dart`, `custom_appbar.dart`|
| **Primary text**        | `#000000` (black/onSurface)     | `#FFFFFF` (white/onSurface)     | All files via `colorScheme.onSurface` |
| **Secondary text**      | `#9E9E9E` (grey500)             | `#BDBDBD` (grey400)             | All files via `colorScheme.onSurfaceVariant` |
| **Primary button bg**   | `#000000` (onSurface)           | `#FFFFFF` (onSurface)           | `custom_button.dart`, `custom_auth_button.dart` |
| **Primary button text** | `#FFFFFF` (surface)             | `#121212` (surface)             | `custom_button.dart`, `custom_auth_button.dart` |
| **Card background**     | `#FFFFFF` (surface)             | `#121212` (surface)             | Cards, dialogs, sheets                |
| **Card border**         | `#EEEEEE` (grey200/outline)     | `#424242` (grey800/outline)     | All card widgets                      |
| **Search bar bg**       | `#F5F5F5` (surfaceContainerHighest) | `#2D2D2D` (blackMedium)    | `custom_appbar.dart`, `menu_search_bar.dart` |
| **Category chip (selected)** | `#000000` (onSurface)     | `#FFFFFF` (onSurface)           | `home_category_filter.dart`           |
| **Category chip (unselected)** | `#F5F5F5` (surfaceContainerHighest) | `#2D2D2D` (blackMedium) | `home_category_filter.dart`           |
| **Divider**             | `#EEEEEE` (grey200)             | `#424242` (grey800)             | `app_theme.dart`                      |
| **Navigation active**   | `#000000` (black)               | `#FFFFFF` (white)               | `main_screen.dart`                    |
| **Navigation inactive** | `#9E9E9E` (grey500)             | `#BDBDBD` (grey400)             | `main_screen.dart`                    |
| **Price text**          | `#DD8560` (orange)              | `#DD8560` (orange)              | 5+ widget files (hardcoded)           |
| **Favorite active**     | `#DD8560` (orange)              | `#DD8560` (orange)              | `favorite_button.dart`                |
| **Badge counter**       | `#DD8560` (orange) bg, white text | Same                          | `badge_widget.dart`                   |
| **Success message bg**  | `#E8F5E9` (successGreen50)      | Same                            | `forgot_password_page.dart`, `signup_page.dart`, `reset_password_page.dart` |
| **Success icon**        | `#388E3C` (successGreen700)     | Same                            | Same as above                         |
| **Success text**        | `#2E7D32` (successGreen800/accent) | Same                         | Same as above                         |
| **Error text**          | `#EF5350` (errorRed400)         | Same                            | `verify_reset_code_page.dart`, `profile_form_section.dart`, `edit_profile_page.dart` |
| **Error container bg**  | `#EF9A9A` (errorRed200)         | Same                            | `place_order.dart`, `product_detail_page.dart` |
| **Destructive button**  | `#EF9A9A` (Colors.red.shade300) | Same                            | `app_confirmation_dialog.dart`        |
| **Destructive text/icon** | `#EF9A9A` (red.shade300)      | Same                            | `profile_menu_item.dart`, `settings_tile.dart` (as `AppColors.accent`) |
| **Free delivery text**  | `#2E7D32` (accent)              | Same                            | `cart_bottom_section.dart`            |
| **Warning icon**        | `#FF9800` (Colors.orange)       | Same                            | `app_message_dialog.dart`             |
| **Star rating**         | `#FFB800` (gold)                | Same                            | `order_rating_widget.dart`            |
| **Shimmer base (light)**| `#E0E0E0` (grey.shade300)       | `#424242` (grey.shade800)       | `shimmer_effect.dart`                 |
| **Shimmer highlight (light)** | `#F5F5F5` (grey.shade100) | `#616161` (grey.shade700)       | `shimmer_effect.dart`                 |
| **Credit card bg**      | `#424242` (cardGrey800)         | Same                            | `add_card.dart`                       |
| **Shipped chip bg**     | `#BBDEFB` (blue.shade100)       | Same                            | `order_status_chip.dart`              |
| **Shipped chip text**   | `#1565C0` (blue.shade800)       | Same                            | `order_status_chip.dart`              |
| **Delivered chip bg**   | `#C8E6C9` (green.shade100)      | Same                            | `order_status_chip.dart`              |
| **Delivered chip text** | `#2E7D32` (green.shade800)      | Same                            | `order_status_chip.dart`              |

---

## 7. Light/Dark Theme Analysis

### 7.1 Light Theme

```dart
ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: #FFFFFF,
  colorScheme: ColorScheme.light(
    surface: #FFFFFF,
    onSurface: #000000,
    surfaceContainerHighest: #F5F5F5,
    outline: #EEEEEE,
    onSurfaceVariant: #9E9E9E,
    surfaceContainerHigh: #F5F5F5,
    surfaceContainerLow: #FFFFFF,
  ),
  appBarTheme: backgroundColor: #FFFFFF, elevation: 1
  bottomNavigationBarTheme: backgroundColor: #FFFFFF, selectedItem: #000000, unselected: #9E9E9E
  dividerColor: #EEEEEE
  iconTheme: #000000
)
```

### 7.2 Dark Theme

```dart
ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: #121212,
  colorScheme: ColorScheme.dark(
    surface: #121212,
    onSurface: #FFFFFF,
    surfaceContainerHighest: #2D2D2D,
    outline: #424242,
    onSurfaceVariant: #BDBDBD,
    surfaceContainerHigh: #181818,
    surfaceContainerLow: #121212,
  ),
  appBarTheme: backgroundColor: #181818, elevation: 1
  bottomNavigationBarTheme: backgroundColor: #181818, selectedItem: #FFFFFF, unselected: #BDBDBD
  dividerColor: #424242
  iconTheme: #FFFFFF
)
```

### 7.3 Theme Toggle Mechanism

- **State management:** Riverpod `StateNotifier<ThemeMode>` via `themeProvider`
- **Persistence:** `SharedPreferences` key `theme_mode` with values `light`/`dark`/`system`
- **Animation:** 300ms theme transition (`themeAnimationDuration`)
- **Options:** Light, Dark, System (follows device setting)
- **UI:** `SegmentedButton<ThemeMode>` in settings page

### 7.4 Custom Theme Extensions

None. The app uses standard Flutter `ThemeData` and `ColorScheme` properties only. There are no `ThemeExtension` classes.

### 7.5 Opacity/Transparency Values

| Opacity | Where Used                    | Purpose                        |
| ------- | ----------------------------- | ------------------------------ |
| 0.6     | `splash.dart` pulse loader    | Animated loading dots          |
| 0.5     | `custom_button.dart`          | Disabled button background     |
| 0.5     | `cart_item_card.dart`         | Disabled qty button            |
| 0.5     | `edit_profile_page.dart`      | Disabled camera icon           |
| 0.4     | `cart_item_card.dart`         | Disabled qty button icon       |
| 0.3     | `collections_grid_skeleton.dart` | Skeleton shimmer            |
| 0.3     | `home_collections_section.dart` | "See more" arrow             |
| 0.2     | `settings_tile.dart`          | Destructive tile bg            |
| 0.2     | `profile_menu_item.dart`      | Destructive menu item border   |
| 0.0     | `Colors.transparent`         | Status bar, nav bar overlays   |

---

## 8. Color Usage by UI Component

### 8.1 Navigation (Bottom Bar)

- **Background:** Light = `#FFFFFF`, Dark = `#181818` (darkSurface)
- **Active icon/text:** Light = `#000000`, Dark = `#FFFFFF`
- **Inactive icon/text:** Light = `#9E9E9E`, Dark = `#BDBDBD`
- **Badge:** `#DD8560` background, `#FFFFFF` text

### 8.2 AppBar

- **Background:** Light = `#FFFFFF`, Dark = `#181818`
- **Elevation:** 1 (both themes)
- **Surface tint:** Transparent (no tint on scroll)
- **Scrolled elevation:** 0
- **Icon color:** Light = `#000000`, Dark = `#FFFFFF`
- **Logo:** SVG with `colorFilter: onSurface` (adapts to theme)

### 8.3 Buttons

- **Primary (filled):** `onSurface` background (black in light, white in dark), `surface` text (white in light, dark in dark)
- **Outlined:** Transparent bg, `onSurface` text, `outline` border
- **Disabled:** `onSurface` at 0.5 opacity
- **Destructive confirm:** `Colors.red.shade300` bg, white text
- **Destructive cancel:** `surfaceContainerHighest` bg, `onSurface` text

### 8.4 Input Fields

- **Auth fields:** Filled with `surfaceContainerHighest` (#F5F5F5 light / #2D2D2D dark), `outline` border, `onSurface` focus border
- **General fields:** Underline border only, `outline` enabled, `onSurface` focused
- **Cursor:** `onSurface`
- **Hint text:** `onSurfaceVariant`
- **Error border:** `onSurfaceVariant` (auth) or `errorRed400` (profile)

### 8.5 Cards

- **Background:** `surface` (theme-aware)
- **Border:** `outline` (theme-aware)
- **Product card price:** `#DD8560` (hardcoded orange)
- **Category icon bg:** `surfaceContainerHighest`
- **Profile header bg:** `surfaceContainerHighest`
- **Collection card bg:** `surfaceContainerHighest`

### 8.6 Dialogs

- **Background:** `surface`
- **Title:** `onSurface`, bold, uppercase
- **Message:** `onSurfaceVariant`
- **Divider line:** `onSurface` (SVG line asset)
- **Confirm button:** `onSurface` bg (normal) or `red.shade300` bg (destructive)
- **Cancel button:** `surfaceContainerHighest` bg, `onSurface` text

### 8.7 Skeleton Loading

- **Base color (light):** `Colors.grey.shade300` (#E0E0E0)
- **Highlight color (light):** `Colors.grey.shade100` (#F5F5F5)
- **Base color (dark):** `Colors.grey.shade800` (#424242)
- **Highlight color (dark):** `Colors.grey.shade700` (#616161)
- **Skeleton box bg:** `surfaceContainerHighest`

### 8.8 Swatches / Color Pickers

The cart item card (`cart_item_card.dart:252-278`) uses Material `Colors.*` directly for product color swatches:
- Black, White, Red, Blue, Green, Yellow, Orange, Pink, Purple, Grey, Brown
- These are **data-driven** (from product data) and not part of the design palette

---

## 9. Color Inconsistencies

### 9.1 Duplicate Values Under Different Names

| Value   | Constants                     | Issue                                    |
| ------- | ----------------------------- | ---------------------------------------- |
| `#2E7D32` | `accent` AND `successGreen800` | Same color defined twice with different semantic names |
| `#424242` | `grey800` AND `cardGrey800`   | Same color defined twice with different semantic names |
| `#F5F5F5` | `grey100` AND `Colors.grey.shade100` | Same effective value, used in different contexts |
| `#EF9A9A` | `errorRed200` AND `Colors.red.shade300` | Same effective value, used in different contexts |
| `#424242` | `grey800` AND `Colors.grey.shade800` | Same effective value, used in different contexts |

### 9.2 Hardcoded vs Theme Colors

| Issue | Details |
| ----- | ------- |
| Orange price color `#DD8560` hardcoded in 5 files | Should be in `AppColors` for consistency and single-source-of-truth |
| Gold star color `#FFB800` hardcoded in 1 file | Should be in `AppColors` |
| Dark scaffold `#121212` hardcoded in `app_theme.dart` (4 occurrences) and `main_screen.dart` (1 occurrence) | Not defined in `AppColors` despite being used 5 times |
| `Colors.red.shade300` used in 4 files | Not mapped to any `AppColors` constant |
| `Colors.orange` used in `app_message_dialog.dart` | Not mapped to any `AppColors` constant |
| `Colors.blue.shade100/800` used in `order_status_chip.dart` | Not mapped to any `AppColors` constant |
| `Colors.green.shade100/800` used in `order_status_chip.dart` | Not mapped to any `AppColors` constant |

### 9.3 Inconsistent Destructive Color Usage

The "destructive" action color is inconsistent across the codebase:

| File | Destructive Color Used |
| ---- | ---------------------- |
| `app_confirmation_dialog.dart` | `Colors.red.shade300` |
| `action_chip_widget.dart` | `Colors.red.shade300` |
| `wishlist_item_card.dart` | `Colors.red.shade300` |
| `cart_item_card.dart` | `Colors.red.shade300` |
| `settings_tile.dart` | `AppColors.accent` (#2E7D32 green) |
| `profile_menu_item.dart` | `AppColors.accent` (#2E7D32 green) |

The profile/settings pages use **green** for destructive actions while the rest of the app uses **red**.

### 9.4 AppBar Background Inconsistency

The AppBar background is defined differently in multiple places:
- `app_theme.dart` (light): `AppColors.white` (#FFFFFF)
- `app_theme.dart` (dark): `AppColors.darkSurface` (#181818)
- `custom_appbar.dart` (light): `Colors.white`
- `custom_appbar.dart` (dark): `Colors.black` (#000000, NOT #181818)
- `profile_page.dart`: `colorScheme.surface` (light = #FFFFFF, dark = #121212)
- `settings_page.dart`: `colorScheme.surface` (light = #FFFFFF, dark = #121212)

The dark mode AppBar uses **three different values**: `#181818` (theme), `#000000` (custom_appbar), and `#121212` (profile/settings).

### 9.5 `errorRed200` Used for Price Display

`AppColors.errorRed200` (#EF9A9A) is used in:
- `place_order.dart:350` — for the total price text
- `product_detail_page.dart:149` — for the estimated total price text

This is semantically confusing — a color named "error" is used for normal price display. This appears to be an intentional design choice to highlight price totals, but the naming is misleading.

---

## 10. Visual Identity Summary

### Design Characteristics

| Characteristic     | Assessment                                                                 |
| ------------------ | -------------------------------------------------------------------------- |
| **Warm vs Cool**   | Neutral with warm accents (orange-brown #DD8560 is the signature warm tone) |
| **Minimal vs Colorful** | **Minimal** — predominantly black, white, and grey with sparse color use |
| **High vs Low Contrast** | **High contrast** — pure black on white (light) / white on near-black (dark) |
| **Neutral-Heavy**  | **Yes** — ~90% of the UI is black/white/grey                             |
| **Accent-Heavy**   | **No** — only 2 accent colors (orange and green) used sparingly            |
| **Light vs Dark**  | **Dual-mode** — full light and dark theme with dedicated color schemes     |
| **Dominant Surface** | White (light) / Near-black #121212 (dark)                                |

### Signature Visual Elements

1. **Orange price highlights** (#DD8560) — The most distinctive color in the app. Used on every product card, search result, and checkout summary. This is the primary "brand color."

2. **High-contrast monochrome** — The stark black-on-white (light) / white-on-near-black (dark) creates a premium, fashion-forward aesthetic.

3. **Grey scale for depth** — 5 grey values (#F5F5F5, #EEEEEE, #BDBDBD, #9E9E9E, #424242) create visual hierarchy without color.

4. **Green for positive states** (#2E7D32) — Used for success messages, "free" delivery labels, and language selection. Provides a calm, trustworthy feel.

5. **Glass navigation bar** — The `glass_bottom_navigation_bar` package provides a frosted-glass effect, adding subtle transparency to the nav bar.

6. **Decorative line dividers** — SVG/PNG line assets (`assets/svgs/line.png`) are tinted with `onSurface` color, used as section separators in dialogs and the home page.

### Brand Personality

The color system communicates:
- **Sophistication** — through the monochrome palette and high contrast
- **Warmth** — through the orange-brown accent
- **Trustworthiness** — through the green success states
- **Simplicity** — through the minimal use of color (only 3 hues: orange, green, grey scale)

---

## 11. Files/Locations Where Colors Are Defined

### Primary Color Definition Files

| File | Purpose |
| ---- | ------- |
| `lib/core/theme/app_colors.dart` | **Master color constants** — 17 named colors |
| `lib/core/theme/app_theme.dart` | **ThemeData definitions** — light + dark themes, ColorScheme |
| `lib/core/theme/theme_provider.dart` | Theme mode state management |
| `lib/core/theme/theme_storage.dart` | Theme persistence (SharedPreferences) |

### Files with Hardcoded Colors (Not in AppColors)

| File | Hardcoded Colors |
| ---- | ---------------- |
| `lib/features/checkout/presentation/widgets/card_widget.dart` | `#DD8560` (price) |
| `lib/features/product/presentation/widgets/product_grid_card.dart` | `#DD8560` (price) |
| `lib/features/checkout/presentation/widgets/favorite_button.dart` | `#DD8560` (favorite) |
| `lib/core/widgets/badge_widget.dart` | `#DD8560` (badge bg), `Colors.white` (badge text) |
| `lib/features/search/presentation/widgets/search_results_list.dart` | `#DD8560` (price) |
| `lib/features/checkout/presentation/widgets/order_rating_widget.dart` | `#FFB800` (star) |
| `lib/core/widgets/custom_appbar.dart` | `Colors.white`, `Colors.black`, `Colors.transparent` |
| `lib/features/main/presentation/pages/main_screen.dart` | `#121212`, `Colors.transparent` |
| `lib/core/widgets/dialog/app_message_dialog.dart` | `Colors.orange` (warning) |
| `lib/core/widgets/dialog/app_confirmation_dialog.dart` | `Colors.red.shade300` (destructive) |
| `lib/core/widgets/action_chip_widget.dart` | `Colors.red.shade300` (destructive) |
| `lib/features/wishlist/presentation/widgets/wishlist_item_card.dart` | `Colors.red.shade300` (swipe bg), `Colors.white` (icon) |
| `lib/features/cart/presentation/widgets/cart_item_card.dart` | `Colors.red.shade300` (swipe bg), `Colors.white` (icon), 11 `Colors.*` swatches |
| `lib/core/widgets/skeletons/shimmer_effect.dart` | `Colors.grey.shade800/700/300/100` |
| `lib/features/orders/presentation/widgets/order_status_chip.dart` | `Colors.blue.shade100/800`, `Colors.green.shade100/800` |

### Files Using Theme Colors Exclusively (no hardcoded colors)

All other files in the project use `Theme.of(context).colorScheme.*` or `AppColors.*` exclusively, making them fully theme-aware. This includes:
- `custom_button.dart`, `custom_auth_button.dart`
- `custom_text_field.dart`, `custom_auth_text_field.dart`
- All card widgets (except those listed above)
- All skeleton widgets (except `shimmer_effect.dart`)
- All profile, settings, cart, checkout, and collection widgets

---

## Portfolio Color Identity

The **5–10 most important colors** that define the MaxFashion visual identity:

| #  | Role                   | Color Name       | HEX/ARGB        | Why It Belongs                                                                      |
| -- | ---------------------- | ---------------- | --------------- | ----------------------------------------------------------------------------------- |
| 1  | **Primary Text (Light)** | Pure Black     | `#000000`       | The dominant foreground color; creates the high-contrast minimalist aesthetic        |
| 2  | **Background (Light)** | Pure White      | `#FFFFFF`       | The canvas for the entire light-mode UI; 50% of the visual identity                 |
| 3  | **Accent / Brand**     | Warm Orange     | `#DD8560`       | **THE signature color** — every price, every favorite heart, every badge uses this  |
| 4  | **Dark Background**    | Near-Black      | `#121212`       | The dark-mode foundation; creates the premium dark aesthetic                         |
| 5  | **Dark Surface**       | Dark Surface    | `#181818`       | Elevated elements in dark mode (AppBar, nav bar); adds depth                        |
| 6  | **Text Secondary**     | Medium Grey     | `#9E9E9E`       | Hints, subtitles, inactive nav items; provides the secondary information layer      |
| 7  | **Border / Divider**   | Light Grey      | `#EEEEEE`       | The subtle separator that defines card boundaries and section breaks                |
| 8  | **Surface Container**  | Off-White       | `#F5F5F5`       | Search bars, chips, light containers; provides subtle depth without color            |
| 9  | **Success / Green**    | Forest Green    | `#2E7D32`       | "Free" labels, success states, language selection; the trust/positive color         |
| 10 | **Error / Destructive**| Soft Red        | `#EF5350`       | Error text, validation, destructive actions; the safety/warning color               |

### Color Palette Summary (for quick reference)

```
Brand:       #DD8560 (warm orange-brown)
Success:     #2E7D32 (forest green)
Error:       #EF5350 (soft red)
Black:       #000000
White:       #FFFFFF
Dark:        #121212
Dark Surface:#181818
Grey 100:    #F5F5F5
Grey 200:    #EEEEEE
Grey 400:    #BDBDBD
Grey 500:    #9E9E9E
Grey 800:    #424242
```
