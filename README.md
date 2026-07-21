# Youssif Mostafa — Portfolio

A modern, responsive portfolio website built with Flutter Web, showcasing projects, skills, and a detailed case study of the VitaGuard health monitoring system.

**Live:** [youssifmostafa.dev](https://youssifmostafa.dev)

## Highlights

- **Modern UI/UX** — Clean Apple-inspired design with Material 3, dark and light themes
- **Fully Responsive** — Optimized layouts for mobile, tablet, and desktop
- **Smooth Animations** — Scroll-triggered reveals, hover effects, animated hero gradient, and dialog transitions
- **Case Study Section** — In-depth project breakdown with architecture, challenges, performance, and results
- **Contact Form** — Validated form with Supabase Edge Function backend, rate limiting, and email delivery
- **Clean Architecture** — Feature-based folder structure with reusable widgets and separation of concerns

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Web) |
| Language | Dart |
| State Management | Riverpod |
| Routing | GoRouter |
| Animations | flutter_animate |
| Responsive Design | responsive_framework, flutter_screenutil |
| Fonts | Google Fonts (Inter) |
| Backend | Supabase (Edge Functions, Email via Resend) |
| Icons & SVGs | flutter_svg, Material Icons |

## Project Structure

```
lib/
  main.dart
  core/
    animations/        # Animation constants and curves
    config/            # Supabase configuration
    constants/         # App-wide constants (name, links, etc.)
    extensions/        # BuildContext extensions (responsive helpers)
    router/            # GoRouter route definitions
    services/          # Supabase service wrapper
    theme/             # Colors, typography, spacing, Material 3 themes
    utils/             # URL and email launch helpers
    widgets/           # Shared reusable widgets (nav bar, cards, animations)
  features/
    home/              # Home page module
      data/            # Contact form DTOs, repository, and remote service
      domain/          # Abstract repository interface
      models/          # Project and Skill models
      presentation/
        pages/         # Home page
        providers/     # Theme and contact form providers
        widgets/       # Section widgets (hero, about, skills, projects, contact)
    project/           # Case study module
      data/            # Project data registry and VitaGuard case study data
      presentation/
        pages/         # Project detail page
        widgets/       # 13 case study section widgets
```

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
flutter build web
```

## Features

### Home Page

- **Hero Section** — Animated gradient background, profile photo, name, title, social links, and call-to-action buttons
- **About Section** — Bio, background, profile card, and key stats
- **Skills Section** — 13 skills across 5 categories with proficiency indicators
- **Projects Section** — Project cards with tech highlights, demo links, and case study navigation
- **Contact Section** — Form with name, email, phone, and message fields, backed by a Supabase Edge Function

### Case Study Page

A dedicated `/project/:projectId` route displays a full case study with 13 sections:

Hero, Overview, Contribution, Features, Architecture, Tech Stack, Challenges, Performance, Gallery, Results, Lessons, Future, and Call-to-Action.

### Additional

- **Dark / Light Mode** — Toggle via nav bar icon (desktop) or drawer switch (mobile)
- **Responsive Navigation** — Inline links on desktop, hamburger menu with drawer on mobile
- **SEO Optimized** — Open Graph, Twitter Cards, iOS PWA meta tags, and theme color

## Architecture

The project follows a **feature-based architecture** with two main layers:

- **`core/`** — Shared infrastructure: theme, routing, animations, constants, reusable widgets, and services
- **`features/`** — Domain modules (`home` and `project`), each containing `data/`, `domain/`, and `presentation/` sub-layers

This separation ensures that adding new sections or pages requires minimal changes to existing code.

## Contact

- **GitHub:** [youssifmostafa798-art](https://github.com/youssifmostafa798-art)
- **LinkedIn:** [Youssif Mostafa](https://www.linkedin.com/in/youssif-mostafa-7342a8357)
- **Email:** youssifmostafa798@gmail.com
