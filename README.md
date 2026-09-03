# Youssif Mostafa — Flutter Developer Portfolio

A premium, responsive portfolio website built with Flutter Web, showcasing real-world projects with in-depth technical case studies.

**Live:** [youssifmostafa798-art.github.io/portfolio](https://youssifmostafa798-art.github.io/portfolio/)

---

## Highlights

- **Modern UI/UX** — Apple-inspired design system with Material 3, glassmorphism effects, and dark/light themes
- **Fully Responsive** — Optimized for mobile, tablet, desktop, and ultra-wide displays
- **Scroll-Triggered Animations** — Visibility-based reveals, hover effects, animated hero gradient, and dialog transitions
- **Three Case Studies** — Detailed technical breakdowns of VitaGuard, Hungryy, and MaxFashion
- **Contact Form Backend** — Supabase Edge Function with rate limiting, input sanitization, CAPTCHA support, and Resend email delivery
- **Clean Architecture** — Feature-based folder structure with clear separation of concerns

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Web) |
| Language | Dart ^3.11.1 |
| State Management | Riverpod |
| Routing | GoRouter |
| Animations | flutter_animate, Visibility Detector |
| Responsive Design | responsive_framework, flutter_screenutil |
| Fonts | Google Fonts (Inter) |
| Backend | Supabase (Edge Functions, Email via Resend) |
| Icons & SVGs | flutter_svg, Material Icons |
| CI/CD | GitHub Actions → GitHub Pages |

---

## Project Structure

```
lib/
├── main.dart                              # Entry point, Supabase init, ProviderScope
├── core/                                  # Shared infrastructure
│   ├── animations/                        # Animation constants and curves
│   ├── config/                            # Supabase configuration
│   ├── constants/                         # App-wide constants (name, links, etc.)
│   ├── extensions/                        # BuildContext responsive helpers
│   ├── router/                            # GoRouter route definitions
│   ├── services/                          # Supabase service wrapper
│   ├── theme/                             # Colors, typography, spacing, Material 3 themes
│   ├── utils/                             # URL and email launch helpers
│   └── widgets/                           # Shared reusable widgets
│       ├── animated_section.dart           # Scroll-triggered animation wrapper
│       ├── app_drawer.dart                 # Mobile navigation drawer
│       ├── app_feedback_dialog.dart        # Success/error feedback dialog
│       ├── app_nav_bar.dart                # Top navigation bar
│       ├── glass_card.dart                 # Frosted glass effect container
│       ├── project_card.dart               # Project showcase card
│       ├── project_image.dart              # Network image with fallback
│       ├── projects_section.dart           # Projects grid for home page
│       ├── section_label.dart              # Section header component
│       └── skill_card.dart                 # Skill display card
├── features/
│   ├── home/                              # Home page module
│   │   ├── data/
│   │   │   ├── models/                    # ContactRequest, ContactResponse DTOs
│   │   │   ├── repositories/              # ContactRepositoryImpl
│   │   │   └── services/                  # ContactRemoteService (Supabase Edge Function)
│   │   ├── domain/
│   │   │   └── repositories/              # ContactRepository abstract interface
│   │   ├── models/                        # Project, Skill models
│   │   └── presentation/
│   │       ├── pages/                     # HomePage (single-page scrollable layout)
│   │       ├── providers/                 # Theme and contact form providers
│   │       └── widgets/sections/          # Hero, About, Skills, Contact sections
│   └── project/                           # Case study module
│       ├── data/
│       │   ├── project_data.dart          # ProjectData abstract class
│       │   └── project_data_registry.dart # Static registry for project data
│       ├── hungryy/                       # Hungryy case study
│       │   ├── data/                      # HungryyData (content and metadata)
│       │   └── presentation/
│       │       ├── pages/                 # HungryyDetailPage
│       │       └── widgets/sections/      # 6 section widgets + colors + builders
│       ├── maxfashion/                    # MaxFashion case study
│       │   ├── data/                      # MaxfashionData (content and metadata)
│       │   └── presentation/
│       │       ├── pages/                 # MaxfashionDetailPage
│       │       └── widgets/sections/      # 5 section widgets + colors + builders
│       └── vitaguard/                     # VitaGuard case study
│           ├── data/                      # VitaguardData (content and metadata)
│           └── presentation/
│               ├── pages/                 # ProjectDetailPage (VitaGuard)
│               └── widgets/sections/      # 13 section widgets
```

---

## Architecture

The project follows a **feature-based architecture** with two primary layers:

### Core Layer (`lib/core/`)

Shared infrastructure used across all features:

- **Theme** — Centralized color palette (`AppColors`), Material 3 themes (`AppTheme`), responsive typography (`AppTypography`), and spacing system (`AppSpacing`)
- **Router** — Declarative routing via GoRouter with named routes
- **Extensions** — `BuildContextX` extension providing 20+ responsive getters (breakpoint detection, responsive padding, font sizes, etc.)
- **Widgets** — Reusable UI components: navigation bar, drawer, glass cards, project cards, skill cards, animated sections, and feedback dialogs
- **Services** — Supabase initialization and configuration
- **Animations** — Standardized animation durations, curves, and slide directions

### Feature Layer (`lib/features/`)

Domain-specific modules, each self-contained:

- **`home/`** — Home page with clean architecture (data/domain/presentation)
- **`project/`** — Case study module with three sub-features and a shared data registry

---

## State Management

**Riverpod** is used throughout the application:

| Provider | Type | Purpose |
|----------|------|---------|
| `themeModeProvider` | `StateProvider<ThemeMode>` | Dark/light theme state |
| `themeToggleProvider` | `Provider` | Theme toggle function |
| `contactFormProvider` | `StateNotifierProvider` | Contact form submission state |
| `contactRepositoryProvider` | `Provider` | Dependency injection for contact repository |

Widgets use `ConsumerWidget` and `ConsumerStatefulWidget` for reactive rendering.

---

## Routing

**GoRouter** with named routes:

| Route | Name | Page |
|-------|------|------|
| `/` | `home` | `HomePage` — single-page scrollable portfolio |
| `/case-study/hungryy` | `hungryy` | `HungryyDetailPage` — food ordering case study |
| `/case-study/maxfashion` | `maxfashion` | `MaxfashionDetailPage` — e-commerce case study |

Navigation uses `context.goNamed()` and `context.pop()` for back navigation.

---

## Backend & Supabase Integration

### Edge Function: Contact Form

A Supabase Edge Function (`supabase/functions/contact/`) handles the contact form with production-grade safeguards:

- **Rate Limiting** — 5 requests per 60 seconds per IP (in-memory)
- **Input Sanitization** — HTML tag stripping, whitespace normalization
- **Validation** — Name required, valid email regex, message length limits
- **CAPTCHA** — Support for Cloudflare Turnstile and Google reCAPTCHA v3
- **Email Delivery** — Styled HTML template via Resend API
- **CORS** — Configurable cross-origin support
- **Logging** — Structured request logging with unique IDs and duration tracking

### Shared Utilities

TypeScript shared modules under `supabase/functions/_shared/`:

- `cors.ts` — CORS headers and preflight handling
- `rate_limiter.ts` — IP-based rate limiting with automatic cleanup
- `sanitizer.ts` — Input sanitization and HTML stripping
- `captcha.ts` — CAPTCHA verification (Turnstile/reCAPTCHA)
- `response.ts` — Standardized JSON response builders
- `logger.ts` — Structured request logging

---

## Theme System

Dual Material 3 themes with runtime switching:

- **Dark Mode** — `#0A0A0A` background, `#1C1C1E` surface, semi-transparent elements
- **Light Mode** — `#F5F5F7` background, `#FFFFFF` surface, clean minimal aesthetic
- **Default** — Dark mode on first load

The theme system includes:
- 3-level text color hierarchy (primary, secondary, tertiary) for both modes
- Status colors (success, warning, error)
- Glassmorphism helper methods for frosted glass effects
- Responsive typography using `flutter_screenutil`

---

## Responsive Design

Four breakpoint tiers with adaptive layouts:

| Breakpoint | Range | Behavior |
|-----------|-------|----------|
| Mobile | < 600px | Single column, hamburger menu + drawer |
| Tablet | 600–1023px | Adapted layouts, condensed spacing |
| Desktop | 1024–1439px | Multi-column, inline navigation |
| Ultra-Wide | 1440px+ | Max-width containers, expanded padding |

Responsive helpers are available via `BuildContext` extensions (`context.isMobile`, `context.isDesktop`, `context.responsivePadding`, etc.).

---

## Case Studies

### VitaGuard — Real-Time Health Monitoring System

A production-grade medical monitoring application integrating ESP32 wearable hardware with a Flutter mobile app.

**Key Technical Features:**
- Real-time vital signs via WebSocket connection to ESP32 sensors
- On-device AI X-ray analysis using DenseNet121 (TFLite) with GPU delegate and CPU fallback
- 4-role authentication system (Patient, Doctor, Admin, Technician)
- Offline-first architecture with Drift SQLite sync queue
- Intelligent multi-tier alert system with 45-second onset delay
- Two-phase medical review workflow with clinical feedback overlay
- 13 Edge Functions on Supabase backend

**Tech:** Flutter, Riverpod, Supabase (Auth, DB, Realtime, Storage), TFLite, Drift, ESP32

**Architecture:** 5-layer — Flutter App → State Management → Repository Layer → Supabase Backend → Hardware & AI

---

### Hungryy — Food Ordering Application

A complete food ordering application with real-time browsing, cart management, and checkout.

**Key Technical Features:**
- Full ordering flow: splash → auth → browse → customize → cart → checkout → confirmation
- Glassmorphism UI with animated bottom navigation and page transitions
- Provider-based state management with cart tax/delivery calculations
- JWT authentication with persistent sessions and guest mode
- Skeleton loading with shimmer effects via Skeletonizer
- Repository pattern with Dio networking layer and interceptors
- Reusable component library across the application

**Tech:** Flutter, Provider, Dio, REST API, SharedPreferences, Lottie, Skeletonizer

**Architecture:** 5-layer — UI → State Management → Repository → Service/Network → Remote API

---

### MaxFashion — Bilingual Fashion E-Commerce

A fashion e-commerce application with full English/Arabic bilingual support and RTL layout.

**Key Technical Features:**
- 150+ translation keys with ARB-based localization
- 3-step password reset with SHA-256 hashed OTPs and rate limiting
- Custom shimmer loading system (13 skeleton variants, zero third-party packages)
- Optimistic UI updates with automatic rollback on failure
- PostgreSQL full-text search with trigram matching, debounced and paginated
- Supabase backend: 14 tables, 25 migrations, 244 products, 22 categories
- Guest mode with progressive enhancement to authenticated experience
- Local-to-Supabase data migration with deduplication

**Tech:** Flutter, Riverpod, Supabase (PostgreSQL, Auth, Storage, Edge Functions), flutter_screenutil, pinput

**Architecture:** 7-layer — Flutter App → State Management → Repository → Service → Supabase Client → PostgreSQL/Storage → Edge Functions

---

## Features

### Home Page

- **Hero Section** — Animated gradient background, profile photo, name, title, social links, and CTA buttons
- **About Section** — Bio, Communications Engineering background, profile card, and key stats
- **Skills Section** — 13 skills across 5 categories with proficiency dot indicators
- **Projects Section** — Project cards with tech highlights, demo links, and case study navigation
- **Contact Section** — Form with name, email, phone, and message fields backed by Supabase Edge Function

### Case Study Pages

Each case study renders a full-page breakdown with scroll-triggered animations:

- Hero with status badge, meta info, and tech stack
- Overview, features, and contribution details
- Technical architecture with layered diagrams
- Challenges and solutions
- Performance considerations and results
- Lessons learned and future roadmap
- Conclusion with action buttons

### Additional

- **Dark / Light Mode** — Toggle via nav bar icon (desktop) or drawer switch (mobile)
- **Responsive Navigation** — Inline links on desktop, hamburger menu with drawer on mobile
- **SEO Optimized** — Open Graph, Twitter Cards, iOS PWA meta tags, and theme color
- **PWA Capable** — Web manifest with standalone display mode
- **CI/CD** — Automated deployment to GitHub Pages via GitHub Actions on push to `main`

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or later)
- [Dart SDK](https://dart.dev/get-dart) (bundled with Flutter)

### Setup

```bash
# Clone the repository
git clone https://github.com/youssifmostafa798-art/portfolio.git
cd portfolio

# Install dependencies
flutter pub get

# Run in development (Chrome)
flutter run -d chrome

# Build for production
flutter build web --release --base-href "/portfolio/"
```

---

## CI/CD

Automated deployment via GitHub Actions (`.github/workflows/deploy.yml`):

1. **Build** — Checkout, setup Flutter (stable), `flutter pub get`, `flutter build web --release`
2. **Deploy** — Upload artifact and deploy to GitHub Pages

Triggers on push to `main` or manual workflow dispatch.

---

## Testing

```bash
flutter test
```

Currently includes a smoke test verifying the app renders without errors.

---

## Contact

- **GitHub:** [youssifmostafa798-art](https://github.com/youssifmostafa798-art)
- **LinkedIn:** [Youssif Mostafa](https://www.linkedin.com/in/youssif-mostafa-7342a8357)
- **Email:** youssifmostafa798@gmail.com
