# Youssif Mostafa — Flutter Developer Portfolio

A premium, responsive portfolio website built with Flutter Web, showcasing real-world projects with in-depth technical case studies.

**Live:** [youssifmostafa798-art.github.io/portfolio](https://youssifmostafa798-art.github.io/portfolio/)

---

## Highlights

- **Modern UI/UX** — Apple-inspired design system with Material 3, glassmorphism effects, and dark/light themes
- **Fully Responsive** — Optimized for mobile, tablet, desktop, and ultra-wide displays via dual responsive systems
- **Scroll-Triggered Animations** — Visibility-based reveals, hover effects, animated hero gradient, and dialog transitions
- **Three Case Studies** — Detailed technical breakdowns of VitaGuard, Hungryy, and MaxFashion
- **Shared Case Study CTA** — Reusable, project-agnostic CTA widget used across all case studies
- **Contact Form Backend** — Supabase Edge Function with rate limiting, input sanitization, CAPTCHA support, and Resend email delivery
- **Clean Architecture** — Feature-based folder structure with clear separation of concerns

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Web) |
| Language | Dart ^3.11.1 |
| State Management | Riverpod (`flutter_riverpod: ^2.6.1`) |
| Routing | GoRouter (`go_router: ^14.8.1`) |
| Animations | flutter_animate, visibility_detector |
| Responsive Design | responsive_framework, flutter_screenutil |
| Fonts | Google Fonts (Inter) |
| Backend | Supabase (Edge Functions, Email via Resend) |
| Icons & SVGs | flutter_svg, Material Icons |
| CI/CD | GitHub Actions → GitHub Pages |

---

## Project Structure

```
lib/
├── main.dart                                    # Entry point, Supabase init, ProviderScope
├── core/                                        # Shared infrastructure
│   ├── animations/
│   │   └── app_animations.dart                  # Animation durations, curves, slide directions
│   ├── config/
│   │   └── supabase_config.dart                 # Supabase URL and anon key
│   ├── constants/
│   │   └── app_constants.dart                   # App name, email, social links, CV URL
│   ├── extensions/
│   │   └── context_extensions.dart              # 20+ responsive BuildContext helpers
│   ├── router/
│   │   └── app_router.dart                      # GoRouter with 4 named routes
│   ├── services/
│   │   └── supabase_service.dart                # Supabase initialization wrapper
│   ├── theme/
│   │   ├── app_colors.dart                      # Centralized color palette (dark/light/glass)
│   │   ├── app_spacing.dart                     # Responsive spacing tokens
│   │   ├── app_theme.dart                       # Material 3 dark/light ThemeData
│   │   └── app_typography.dart                  # Inter font with ScreenUtil responsive sizes
│   ├── utils/
│   │   └── url_utils.dart                       # URL and email launch helpers
│   └── widgets/                                 # Shared reusable UI components
│       ├── animated_section.dart                # Scroll-triggered animation wrapper
│       ├── app_drawer.dart                      # Mobile navigation drawer
│       ├── app_feedback_dialog.dart             # Success/error feedback dialog
│       ├── app_nav_bar.dart                     # Top navigation bar
│       ├── case_study_cta.dart                  # Shared Case Study CTA widget
│       ├── glass_card.dart                      # Frosted glass effect container
│       ├── project_card.dart                    # Project showcase card
│       ├── project_image.dart                   # Network image with fallback
│       ├── projects_section.dart                # Projects grid for home page
│       ├── section_label.dart                   # Section header component
│       └── skill_card.dart                      # Skill display card
├── features/
│   ├── home/                                    # Home page module
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── contact_request.dart         # Contact form request DTO
│   │   │   │   └── contact_response.dart        # Contact form response DTO
│   │   │   ├── repositories/
│   │   │   │   └── contact_repository_impl.dart # Contact repository implementation
│   │   │   └── services/
│   │   │       └── contact_remote_service.dart  # Supabase Edge Function caller
│   │   ├── domain/
│   │   │   └── repositories/
│   │   │       └── contact_repository.dart      # Contact repository abstract interface
│   │   ├── models/
│   │   │   ├── project.dart                     # Project model (17 fields)
│   │   │   └── skill.dart                       # Skill model with proficiency enum
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── home_page.dart               # Single-page scrollable portfolio
│   │       ├── providers/
│   │       │   ├── contact_provider.dart         # Contact form state (StateNotifier)
│   │       │   └── theme_provider.dart           # Theme mode state (StateProvider)
│   │       └── widgets/sections/
│   │           ├── about_section.dart
│   │           ├── contact_section.dart
│   │           ├── hero_section.dart
│   │           └── skills_section.dart
│   └── project/                                 # Case study module
│       ├── data/
│       │   ├── project_data.dart                # ProjectData abstract interface
│       │   └── project_data_registry.dart       # Static registry for project data
│       ├── hungryy/                             # Hungryy case study
│       │   ├── data/
│       │   │   └── hungryy_data.dart            # Content, metadata, and data models
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── hungryy_detail_page.dart # Full case study page
│       │       └── widgets/sections/
│       │           ├── hungryy_colors.dart       # Project-specific color tokens
│       │           ├── hungryy_section_builders.dart  # Reusable section widgets
│       │           ├── hs_architecture_section.dart
│       │           ├── hs_conclusion_section.dart
│       │           ├── hs_folder_structure_section.dart
│       │           └── hs_hero_section.dart
│       ├── maxfashion/                          # MaxFashion case study
│       │   ├── data/
│       │   │   └── maxfashion_data.dart         # Content, metadata, and data models
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── maxfashion_detail_page.dart  # Full case study page
│       │       └── widgets/sections/
│       │           ├── maxfashion_colors.dart    # Project-specific color tokens
│       │           ├── maxfashion_section_builders.dart  # Reusable section widgets
│       │           ├── ms_architecture_section.dart
│       │           ├── ms_conclusion_section.dart
│       │           └── ms_hero_section.dart
│       └── vitaguard/                           # VitaGuard case study
│           ├── data/
│           │   └── vitaguard_data.dart          # Content, metadata, and data models
│           └── presentation/
│               ├── pages/
│               │   └── vitaguard_detail_page.dart   # Full case study page (registry-based)
│               └── widgets/sections/
│                   ├── ps_architecture_section.dart
│                   ├── ps_challenges_section.dart
│                   ├── ps_contribution_section.dart
│                   ├── ps_features_section.dart
│                   ├── ps_future_section.dart
│                   ├── ps_gallery_section.dart
│                   ├── ps_hero_section.dart
│                   ├── ps_lessons_section.dart
│                   ├── ps_overview_section.dart
│                   ├── ps_performance_section.dart
│                   ├── ps_results_section.dart
│                   └── ps_tech_section.dart
```

---

## Architecture

The project follows a **feature-based architecture** with two primary layers:

### Core Layer (`lib/core/`)

Shared infrastructure used across all features:

- **Theme** — Centralized color palette (`AppColors`), Material 3 themes (`AppTheme`), responsive typography (`AppTypography`), and spacing system (`AppSpacing`)
- **Router** — Declarative routing via GoRouter with named routes
- **Extensions** — `BuildContextX` extension providing 20+ responsive getters (breakpoint detection, responsive padding, font sizes, border radius, etc.)
- **Widgets** — Reusable UI components: navigation bar, drawer, glass cards, project cards, skill cards, animated sections, feedback dialogs, and the shared `CaseStudyCta`
- **Services** — Supabase initialization and configuration
- **Animations** — Standardized animation durations, curves, and slide directions
- **Utils** — URL and email launch helpers via `url_launcher`

### Feature Layer (`lib/features/`)

Domain-specific modules, each self-contained:

- **`home/`** — Home page with clean architecture (data/domain/presentation layers)
- **`project/`** — Case study module with three sub-features and a shared data registry

### Case Study Patterns

Two architectural patterns coexist for case studies:

| Pattern | Used By | Description |
|---------|---------|-------------|
| **Registry** | VitaGuard | `ProjectData` interface + `ProjectDataRegistry` + generic `ProjectDetailPage` |
| **Dedicated** | Hungryy, MaxFashion | Standalone data class + dedicated detail page + custom section builders |

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
| `/case-study/vitaguard` | `vitaguard` | `ProjectDetailPage` — health monitoring case study |

Navigation uses `context.goNamed()` and `context.pop()` for back navigation.

---

## Backend & Supabase Integration

### Edge Function: Contact Form

A Supabase Edge Function (`supabase/functions/contact/`) handles the contact form with production-grade safeguards:

- **Rate Limiting** — 5 requests per 60 seconds per IP (in-memory sliding window)
- **Input Sanitization** — HTML tag stripping, whitespace normalization
- **Validation** — Name required (max 100 chars), valid email regex, message length limits (max 5000 chars)
- **CAPTCHA** — Support for Cloudflare Turnstile and Google reCAPTCHA v3
- **Email Delivery** — Styled HTML template via Resend API
- **CORS** — Configurable cross-origin support
- **Logging** — Structured request logging with unique IDs, client IP extraction, and duration tracking

### Shared Utilities

TypeScript shared modules under `supabase/functions/_shared/`:

| Module | Purpose |
|--------|---------|
| `cors.ts` | CORS headers and preflight handling |
| `rate_limiter.ts` | IP-based rate limiting with automatic cleanup |
| `sanitizer.ts` | Input sanitization and HTML stripping |
| `captcha.ts` | CAPTCHA verification (Turnstile/reCAPTCHA) |
| `response.ts` | Standardized JSON response builders |
| `logger.ts` | Structured request logging |

---

## Theme System

Dual Material 3 themes with runtime switching:

- **Dark Mode** — `#0A0A0A` background, `#1C1C1E` surface, semi-transparent elements
- **Light Mode** — `#F5F5F7` background, `#FFFFFF` surface, clean minimal aesthetic
- **Default** — Dark mode on first load (no persistence across sessions)

The theme system includes:

- 3-level text color hierarchy (primary, secondary, tertiary) for both modes
- Status colors (success, warning, error)
- Glassmorphism helper methods for frosted glass effects
- Responsive typography using `flutter_screenutil` with Inter font

---

## Responsive Design

Four breakpoint tiers with adaptive layouts:

| Breakpoint | Range | Behavior |
|-----------|-------|----------|
| Mobile | < 600px | Single column, hamburger menu + drawer |
| Tablet | 600–1023px | Adapted layouts, condensed spacing |
| Desktop | 1024–1439px | Multi-column, inline navigation |
| Ultra-Wide | 1440px+ | Max-width containers (1440px), expanded padding |

Responsive helpers are available via `BuildContext` extensions:

- `context.isMobile`, `context.isTablet`, `context.isDesktop`
- `context.responsivePadding`, `context.responsiveSectionVertical`, `context.responsiveSectionGap`
- `context.responsiveTitleSize`, `context.responsiveSubtitleSize`, `context.responsiveBodySize`
- `context.responsiveBorderRadius`, `context.responsiveButtonMinHeight`
- `context.responsive` — returns a `ResponsiveData` object with all breakpoint info

---

## Case Studies

### VitaGuard — Real-Time Health Monitoring System

A production-grade medical monitoring application integrating ESP32 wearable hardware with a Flutter mobile app.

**Key Technical Features:**

- Real-time vital signs (BPM, SpO2, temperature) via WebSocket connection to ESP32 sensors
- On-device AI X-ray analysis using DenseNet121 (TFLite) with GPU delegate and CPU fallback
- 4-role authentication system (Patient, Doctor, Companion, Facility) with Supabase RLS
- Offline-first architecture with Drift SQLite and sync queue with retry tracking
- Intelligent multi-tier alert system with 45-second onset delay and stale-sensor watchdog
- Two-phase medical review workflow (FDA SaMD-inspired) with clinical feedback overlay
- 13 Supabase Edge Functions for hardware telemetry, AI, and admin workflows

**Tech:** Flutter, Riverpod, Supabase (Auth, DB, Realtime, Storage, Edge Functions), TFLite, Drift, ESP32

**Architecture:** 5-layer — Flutter App → State Management → Repository Layer → Supabase Backend → Hardware & AI

**Case Study Sections:** 12 section widgets covering hero, overview, contributions, features, architecture, tech stack, challenges, performance, gallery, results, lessons, and future roadmap.

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

**Case Study Sections:** Custom section builders with text, card grid, problem-solution, bullet list, and image placeholder variants. Includes hero, architecture, folder structure, and conclusion sections.

---

### MaxFashion — Bilingual Fashion E-Commerce

A fashion e-commerce application with full English/Arabic bilingual support and RTL layout.

**Key Technical Features:**

- 150+ translation keys with ARB-based localization (English/Arabic)
- 3-step password reset with SHA-256 hashed OTPs and rate limiting
- Custom shimmer loading system (13 skeleton variants, zero third-party packages)
- Optimistic UI updates with automatic rollback on failure
- PostgreSQL full-text search with trigram matching, debounced and paginated
- Supabase backend: 14 tables, 25 migrations, 244 seeded products, 22 categories
- Guest mode with progressive enhancement to authenticated experience
- Local-to-Supabase data migration with deduplication

**Tech:** Flutter, Riverpod, Supabase (PostgreSQL, Auth, Storage, Edge Functions), flutter_screenutil, pinput

**Architecture:** 7-layer — Flutter App → State Management → Repository → Service → Supabase Client → PostgreSQL/Storage → Edge Functions

**Case Study Sections:** Custom section builders with text, card grid, problem-solution, bullet list, and metrics variants. Includes hero, architecture, and conclusion sections.

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
- Shared CTA with Back to Portfolio, GitHub, Demo, and Contact Me actions

### Shared Case Study CTA

A reusable `CaseStudyCta` widget in `lib/core/widgets/` provides a consistent call-to-action across all case studies:

- Gradient container with "Interested in this project?" header
- Configurable actions: Back to Portfolio, GitHub (nullable), Demo (nullable), Contact Me
- Hover animation on buttons with semantic accessibility
- Responsive layout for all viewport sizes

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
