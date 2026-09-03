# Project Integration Guide

## 1. Document Purpose

This document is the **official reference guide** for adding a new project to the Portfolio website. It is based on a thorough analysis of the existing codebase and describes the **exact implementation patterns** used for the two currently integrated projects: **VitaGuard** and **Hungryy**.

After reading this guide, a developer or AI should be able to integrate a new project step-by-step without guessing.

---

## 2. Portfolio Project Architecture

The portfolio is a **Flutter Web** application for **Youssif Mostafa**, built with a feature-based Clean Architecture pattern.

### Technology Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.11+ |
| State Management | Riverpod (`flutter_riverpod`) |
| Routing | GoRouter (`go_router`) |
| Animations | `flutter_animate`, `visibility_detector` |
| Responsive | `responsive_framework`, `flutter_screenutil` |
| Backend | Supabase (contact form) |

### Directory Structure

```
lib/
├── main.dart                          # App entry, initializes ProjectDataRegistry
├── core/
│   ├── constants/app_constants.dart   # Global constants (name, email, social links)
│   ├── router/app_router.dart         # GoRouter route definitions
│   ├── extensions/context_extensions.dart  # Responsive helpers
│   ├── theme/                         # AppColors, AppTheme, AppTypography
│   ├── utils/url_utils.dart           # URL launching utilities
│   └── widgets/                       # Reusable widgets
│       ├── project_card.dart          # Project card for listing
│       ├── project_image.dart         # Image/placeholder renderer
│       ├── glass_card.dart            # Frosted glass container
│       ├── animated_section.dart      # Scroll-triggered animation wrapper
│       ├── section_label.dart         # Section header component
│       ├── skill_card.dart            # Skill display card
│       ├── app_nav_bar.dart           # Top navigation bar
│       └── app_drawer.dart            # Mobile drawer
├── features/
│   ├── home/
│   │   ├── models/
│   │   │   ├── project.dart           # Project model (for cards)
│   │   │   └── skill.dart             # Skill model
│   │   └── presentation/
│   │       ├── pages/home_page.dart   # Main home page
│   │       ├── providers/             # Theme, Contact providers
│   │       └── widgets/sections/      # Hero, About, Skills, Contact
│   └── project/
│       ├── data/
│       │   ├── project_data.dart         # Abstract ProjectData interface
│       │   ├── project_data_registry.dart # Registry for detail page data
│       │   ├── vitaguard_data.dart       # VitaGuard data implementation
│       │   └── hungryy_data.dart         # Hungryy data implementation
│       └── presentation/
│           ├── pages/
│           │   ├── vitaguard_detail_page.dart  # Generic ProjectDetailPage (registry-based)
│           │   └── hungryy_detail_page.dart    # Dedicated HungryyDetailPage
│           └── widgets/sections/
│               ├── vitagaurd/           # 14 VitaGuard-specific section widgets
│               │   ├── projects_section.dart  # Projects listing (homepage)
│               │   ├── ps_hero_section.dart
│               │   ├── ps_overview_section.dart
│               │   ├── ps_features_section.dart
│               │   └── ... (10 more)
│               └── hungryy/             # 6 Hungryy-specific section widgets
│                   ├── hungryy_section_builders.dart  # Reusable builders
│                   ├── hungryy_colors.dart
│                   ├── hs_hero_section.dart
│                   ├── hs_architecture_section.dart
│                   ├── hs_folder_structure_section.dart
│                   └── hs_conclusion_section.dart
```

### Two Project Implementation Patterns

The portfolio has **two distinct patterns** for project detail pages:

| Pattern | Used By | Data Model | Detail Page |
|---------|---------|------------|-------------|
| **Registry Pattern** | VitaGuard | Implements `ProjectData` abstract class | `ProjectDetailPage` (generic, shared) |
| **Dedicated Pattern** | Hungryy | Custom `HungryyData` class | `HungryyDetailPage` (project-specific) |

Both patterns share the same **card listing** system (a single `ProjectsSection` with hardcoded `Project` objects).

---

## 3. Existing Projects Analyzed

### Project 1: VitaGuard

- **Title**: VitaGuard
- **Subtitle**: Real-Time Health Monitoring System
- **Role**: Flutter Mobile Application Developer
- **Status**: Production Ready
- **Team Size**: 4 (portfolio context; actual team was 12)
- **Timeline**: 2025 – 2026
- **ID**: `vitaguard`
- **Pattern**: Registry (implements `ProjectData`)
- **Detail Route**: `/project/vitaguard` (dynamic, via registry lookup)

### Project 2: Hungryy

- **Title**: Hungry (displayed as "Hungry" on card)
- **Subtitle**: Food Ordering Application
- **Role**: Flutter Mobile Application Developer
- **Status**: Complete
- **Team Size**: 1
- **Timeline**: 2025
- **ID**: `hungryy`
- **Pattern**: Dedicated (custom `HungryyData` class)
- **Detail Route**: `/case-study/hungryy` (static, hardcoded route)

---

## 4. Project Data Structure

### 4.1 Project Card Data Model

**File**: `lib/features/home/models/project.dart`

Used by the `ProjectsSection` and `ProjectCard` to display projects on the homepage.

```dart
class Project {
  final String id;                    // Unique identifier (e.g., 'vitaguard', 'hungryy')
  final String title;                 // Display name (e.g., 'VitaGuard')
  final String subtitle;              // Short tagline (e.g., 'Real-Time Health Monitoring System')
  final String description;           // 2-3 sentence description for the card
  final String role;                  // Your role (e.g., 'Flutter Mobile Application Developer')
  final List<String> technologies;    // Tech chips shown on card (e.g., ['Flutter', 'Dart', ...])
  final List<String> highlights;      // Key bullet points (4 items typical)
  final String? imageUrl;             // Network URL for card image (nullable)
  final List<String> galleryUrls;     // Gallery image URLs
  final String? githubUrl;            // GitHub repository URL (nullable)
  final String? demoUrl;              // Demo video URL (nullable)
  final String? caseStudyRoute;       // Route to detail page (nullable)
  final String? googleDriveScreenshotsUrl;  // Google Drive screenshots link
  final String? logoAsset;            // Local asset path for logo (nullable)
  final String? cardSubtitle;         // Subtitle for placeholder card (nullable)
  final List<Color>? cardGradientColors;    // Gradient colors for placeholder (nullable)
  final Color? cardGlowColor;               // Glow effect color (nullable)
  final List<Color>? cardLogoGradientColors; // Logo container gradient (nullable)
}
```

### 4.2 Abstract ProjectData Interface (Registry Pattern)

**File**: `lib/features/project/data/project_data.dart`

Used by projects that follow the **registry pattern**. The `VitaguardData` class implements this interface.

```dart
abstract class ProjectData {
  // Identity
  String get id;
  String get title;
  String get tagline;
  String get role;
  String get status;
  String get teamSize;
  String get timeline;

  // Links
  String get demoUrl;
  String get screenshotsUrl;
  String get githubUrl;

  // Tech
  List<String> get techStack;
  List<String> get techStackTop;

  // Overview
  String get overviewWhat;
  String get overviewProblem;
  String get overviewTargetUsers;
  String get overviewWhyMatters;

  // Content
  List<String> get contributions;
  List<FeatureItem> get features;
  List<ArchitectureLayer> get architecture;
  List<TechCategory> get techCategories;
  List<ChallengeItem> get challenges;
  List<PerformanceItem> get performanceItems;
  List<String> get results;
  List<String> get lessons;
  List<FutureItem> get futureItems;

  // Gallery
  List<String> get screenshotLabels;
  List<Color> get screenshotColors;

  // Section Subtitles
  String get overviewSubtitle;
  String get contributionSubtitle;
  String get featuresSubtitle;
  String get architectureSubtitle;
  String get techStackSubtitle;
  String get challengesSubtitle;
  String get performanceSubtitle;
  String get gallerySubtitle;
  String get resultsSubtitle;
  String get lessonsSubtitle;
  String get futureSubtitle;
  String get bottomCtaTitle;
  String get bottomCtaSubtitle;
}
```

**Helper data classes** (also in `project_data.dart`):

```dart
class FeatureItem { String title; String description; IconData icon; }
class ArchitectureLayer { String layer; String detail; }
class TechCategory { String category; String items; }
class ChallengeItem { String title; String problem; String solution; }
class PerformanceItem { String title; String description; }
class FutureItem { String title; String description; IconData icon; }
```

### 4.3 Custom HungryyData Class (Dedicated Pattern)

**File**: `lib/features/project/data/hungryy_data.dart`

Hungryy does **not** implement `ProjectData`. It uses its own custom class with different field names and additional data structures.

**Key differences from ProjectData:**
- Uses `heroDescription` instead of `overviewWhat`
- Has custom data classes: `HungryyCardItem`, `HungryyProblemSolution`, `HungryyArchitectureLayer`, `HungryyPlaceholderItem`
- Has many more content fields (30+ body strings for different sections)
- Has `skillsDemonstrated`, `responsibilities`, `keyAchievements` lists
- No `screenshotLabels`/`screenshotColors` — uses `screenshotPlaceholders` with custom `HungryyPlaceholderItem` class

---

## 5. Project Assets Structure

### 5.1 Asset Directory

```
assets/
├── icons/
│   └── .gitkeep
├── images/
│   ├── 5.jpeg
│   ├── background.png
│   ├── logo  hungry.png      # Hungryy logo (note space in filename)
│   └── logo vita.jpeg        # VitaGuard logo
└── svg/
    └── .gitkeep
```

### 5.2 Asset Conventions

- **Logo assets** are stored in `assets/images/`
- Filenames use spaces: `logo  hungry.png`, `logo vita.jpeg`
- Logos are referenced via asset path strings (e.g., `'assets/images/logo  hungry.png'`)
- **Screenshots** are NOT stored locally — they use Google Drive URLs
- **Card images** can be either network URLs (`imageUrl`) or gradient placeholders with logo overlay

### 5.3 Asset Registration

In `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - assets/svg/
```

### 5.4 How Assets Are Referenced

- `ProjectImage` widget handles display: if `imageUrl` is provided, it loads from network; otherwise it renders a gradient placeholder with the logo asset
- The `logoAsset` field on `Project` points to a local asset path
- Default fallback: `'assets/images/logo vita.jpeg'` (line 187 of `project_image.dart`)

---

## 6. Project Card Implementation

### 6.1 ProjectsSection (Listing Component)

**File**: `lib/features/project/presentation/widgets/sections/vitagaurd/projects_section.dart`

This is the **single source** for all projects displayed on the homepage. Projects are defined as a **hardcoded static list** of `Project` objects.

```dart
static const List<Project> _projects = [
  Project(
    id: 'vitaguard',
    title: 'VitaGuard',
    subtitle: 'Real-Time Health Monitoring System',
    description: '...',
    role: 'Flutter Mobile Application Developer',
    technologies: ['Flutter', 'Dart', 'Supabase', ...],
    highlights: ['...', '...', '...', '...'],
    githubUrl: 'https://...',
    demoUrl: 'https://...',
    googleDriveScreenshotsUrl: 'https://...',
    caseStudyRoute: '/project/vitaguard',
  ),
  Project(
    id: 'hungryy',
    title: 'Hungry',
    // ... custom card fields for gradient placeholder
    logoAsset: 'assets/images/logo  hungry.png',
    cardSubtitle: 'Food Ordering Application',
    cardGradientColors: [Color(0xFF0F3D2E), ...],
    cardGlowColor: Color(0xFF27AE60),
    cardLogoGradientColors: [Color(0xFF0F3D2E), ...],
    caseStudyRoute: '/case-study/hungryy',
  ),
];
```

**Key observations:**
- The list is **static const** — new projects are added by appending to this list
- The `onCaseStudyTap` callback receives the `project.id` and routes accordingly
- VitaGuard uses a network image (via `imageUrl` — not set here, so it falls back to placeholder)
- Hungryy uses a gradient placeholder with custom colors and local logo asset

### 6.2 ProjectCard Component

**File**: `lib/core/widgets/project_card.dart`

Receives a `Project` object and an `onCaseStudyTap` callback.

**Layout:**
- **Desktop**: Row layout — 350px image column + expanded content column
- **Mobile**: Column layout — image on top (55% screen height) + content below

**Content rendered:**
1. `project.title` — heading
2. `project.subtitle` — colored tagline
3. `project.description` — body text
4. `project.technologies` — chip tags (wrapped in a `Wrap`)
5. `project.role` — info row
6. `project.highlights` — bulleted list
7. Action buttons: GitHub (if url exists), Demo Video (if url exists), **Case Study** (always), Gallery (if `googleDriveScreenshotsUrl` exists)

**Hover behavior:**
- Card lifts 1-2px on hover (`AnimatedContainer` with `Matrix4.translationValues`)
- Shadow intensifies (blurRadius: 20 → 40)
- Button hover: lifts 1px

### 6.3 ProjectImage Component

**File**: `lib/core/widgets/project_image.dart`

Handles two rendering modes:
1. **Network image**: If `imageUrl` is non-null, loads via `Image.network()` with loading/error builders
2. **Gradient placeholder**: Renders a styled gradient container with logo overlay, glow effects, and status indicator

The placeholder is controlled by: `cardGradientColors`, `cardGlowColor`, `cardLogoGradientColors`, `logoAsset`, `cardSubtitle`.

---

## 7. Project Details Implementation

### 7.1 VitaGuard Pattern (Registry-Based)

**Detail Page**: `lib/features/project/presentation/pages/vitaguard_detail_page.dart`

This is a **generic `ProjectDetailPage`** that:
1. Accepts `projectId` as a constructor parameter
2. Looks up data via `ProjectDataRegistry.get(projectId)`
3. If not found, shows error message
4. Renders 13 sections in a `ListView.builder`

**Sections rendered (in order):**
1. Hero → `ProjectHeroSection(data: data)`
2. Overview → `ProjectOverviewSection(data: data)`
3. Contribution → `ContributionSection(data: data)`
4. Features → `FeaturesSection(data: data)`
5. Architecture → `ArchitectureSection(data: data)`
6. Tech Stack → `TechSection(data: data)`
7. Challenges → `ChallengesSection(data: data)`
8. Performance → `PerformanceSection(data: data)`
9. Gallery → `GallerySection(data: data)`
10. Results → `ResultsSection(data: data)`
11. Lessons → `LessonsSection(data: data)`
12. Future → `FutureSection(data: data)`
13. Bottom CTA → `BottomCTASection(data: data)`

**Section widgets** are in: `lib/features/project/presentation/widgets/sections/vitagaurd/`

Each section widget receives `ProjectData data` and reads the specific fields it needs.

### 7.2 Hungryy Pattern (Dedicated Page)

**Detail Page**: `lib/features/project/presentation/pages/hungryy_detail_page.dart`

This is a **dedicated `HungryyDetailPage`** that:
1. Instantiates `HungryyData` directly (not from registry)
2. Renders **37 sections** in a `ListView.builder`
3. Uses `HungryyTextSection` and `HungryyCardGridSection` reusable builders from `hungryy_section_builders.dart`
4. Has project-specific sections: Architecture, Folder Structure, Conclusion

**Key difference**: Hungryy uses its own data class (`HungryyData`) and its own section widgets. The sections are composed from reusable builders (`HungryyTextSection`, `HungryyCardGridSection`, `HungryyProblemSolutionSection`, `HungryyBulletListSection`, `HungryyImagePlaceholdersSection`) plus custom sections (`HungryyHeroSection`, `HungryyArchitectureSection`, `HungryyFolderStructureSection`, `HungryyConclusionSection`).

---

## 8. Routing & Navigation

### 8.1 Router Configuration

**File**: `lib/core/router/app_router.dart`

```dart
static final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/project/:projectId',
      name: 'project',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId'] ?? '';
        return ProjectDetailPage(projectId: projectId);
      },
    ),
    GoRoute(
      path: '/case-study/hungryy',
      name: 'hungryy',
      builder: (context, state) => const HungryyDetailPage(),
    ),
  ],
);
```

### 8.2 Navigation Flow

**From homepage** (`home_page.dart` line 121-129):

```dart
ProjectsSection(
  onCaseStudyTap: (projectId) {
    if (projectId == 'hungryy') {
      context.pushNamed('hungryy');              // Static route
    } else {
      context.pushNamed(
        'project',
        pathParameters: {'projectId': projectId}, // Dynamic route
      );
    }
  },
),
```

### 8.3 Two Routing Approaches

| Approach | Route | Used By | How It Works |
|----------|-------|---------|--------------|
| **Dynamic** | `/project/:projectId` | VitaGuard | Registry lookup by `projectId` |
| **Static** | `/case-study/hungryy` | Hungryy | Hardcoded route, dedicated page |

### 8.4 Router Import Chain

The router imports both detail pages directly:
```dart
import '../../features/project/presentation/pages/hungryy_detail_page.dart';
import '../../features/project/presentation/pages/vitaguard_detail_page.dart';
```

---

## 9. Categories & Filtering

There is **no categories or filtering system** in the current implementation. All projects are displayed in a simple sequential list. The `ProjectsSection` renders them in the order they appear in the `_projects` static list.

---

## 10. Technologies / Skills Structure

### 10.1 Skills Section (Homepage)

**File**: `lib/features/home/presentation/widgets/sections/skills_section.dart`

Skills are defined as a **hardcoded static list** of `Skill` objects:

```dart
class Skill {
  final String name;           // Display name
  final IconData icon;         // Material icon
  final String category;       // Group label (e.g., 'Flutter & Dart')
  final SkillProficiency proficiency;  // proficient/advanced/expert
}
```

Skills are grouped by `category` and displayed in category sections. Skills are **not linked to projects** — they are independent of the project data.

### 10.2 Project-Level Technologies

Technologies in projects are simple **string lists** — not objects. They are displayed as chip tags in the `ProjectCard` and `ProjectHeroSection`:

```dart
// In Project model:
final List<String> technologies;  // Card chips
// In ProjectData:
List<String> get techStack;       // Full list
List<String> get techStackTop;    // Top N items for hero
```

---

## 11. Complete Project Addition Workflow

### Decision: Which Pattern to Follow?

**Option A: Registry Pattern (Recommended for most projects)**
- Follow this if you want the project to use the shared `ProjectDetailPage` with 13 standard sections
- Requires implementing the `ProjectData` abstract class
- Data is registered in `ProjectDataRegistry`

**Option B: Dedicated Pattern**
- Follow this if you need a completely custom layout with non-standard sections
- Requires creating a custom data class and a dedicated detail page
- Requires adding a new route in `app_router.dart`

### For Either Pattern, These Steps Are Required:

1. Add project to `ProjectsSection._projects` list (card data)
2. Create the detail page (either via registry or dedicated)
3. Add a route in `app_router.dart` (if using dedicated pattern)

---

## 12. Required Files to Modify

### Step 1: Add Project Card Data

**File**: `lib/features/project/presentation/widgets/sections/vitagaurd/projects_section.dart`

**Action**: Add a new `Project(...)` object to the `_projects` list.

**Required fields:**
- `id` — unique string identifier
- `title` — display name
- `subtitle` — tagline
- `description` — 2-3 sentence card description
- `role` — your role
- `technologies` — list of tech names for chips (5-7 items)
- `highlights` — list of 3-5 key bullet points

**Optional fields (for gradient placeholder instead of network image):**
- `logoAsset` — local asset path (e.g., `'assets/images/logo_new.png'`)
- `cardSubtitle` — subtitle shown on placeholder
- `cardGradientColors` — list of 3 `Color` values
- `cardGlowColor` — single `Color`
- `cardLogoGradientColors` — list of 2 `Color` values

**Optional fields (for network image):**
- `imageUrl` — network URL for card image

**Optional fields (for links):**
- `githubUrl` — GitHub repo URL
- `demoUrl` — demo video URL
- `googleDriveScreenshotsUrl` — Google Drive screenshots folder
- `caseStudyRoute` — route path for detail page

---

## 13. Optional Files to Modify

### For Registry Pattern (VitaGuard-style):

#### Step 2A: Create Project Data Class

**File**: `lib/features/project/data/{project_name}_data.dart` (create new)

**Action**: Create a class implementing `ProjectData`.

```dart
import 'package:flutter/material.dart';
import 'project_data.dart';

final class NewProjectData implements ProjectData {
  const NewProjectData();

  @override
  String get id => 'new-project';

  @override
  String get title => 'New Project';

  @override
  String get tagline => 'Project Tagline';

  // ... implement all required abstract members
}
```

#### Step 3A: Register in Registry

**File**: `lib/features/project/data/project_data_registry.dart`

**Action**: Import and register the new data class.

```dart
import 'newproject_data.dart';

abstract final class ProjectDataRegistry {
  // ... existing code ...
  static void init() {
    register(const VitaguardData());
    register(const NewProjectData());  // Add this line
  }
}
```

**That's it** — the generic `ProjectDetailPage` will automatically render this project with the 13 standard sections.

### For Dedicated Pattern (Hungryy-style):

#### Step 2B: Create Custom Data Class

**File**: `lib/features/project/data/{project_name}_data.dart` (create new)

**Action**: Create a custom data class with project-specific fields.

#### Step 3B: Create Detail Page

**File**: `lib/features/project/presentation/pages/{project_name}_detail_page.dart` (create new)

**Action**: Create a dedicated page that instantiates the data class and renders custom sections.

#### Step 4B: Create Section Widgets

**File**: `lib/features/project/presentation/widgets/sections/{project_name}/` (create directory)

**Action**: Create section widgets. Consider creating reusable builders like `hungryy_section_builders.dart`.

#### Step 5B: Add Route

**File**: `lib/core/router/app_router.dart`

**Action**: Add a new `GoRoute` entry.

```dart
GoRoute(
  path: '/case-study/{project_name}',
  name: '{project_name}',
  builder: (context, state) => const NewProjectDetailPage(),
),
```

#### Step 6B: Update Home Page Navigation

**File**: `lib/features/home/presentation/pages/home_page.dart`

**Action**: Add a routing condition for the new project ID (line 121-129).

```dart
onCaseStudyTap: (projectId) {
  if (projectId == 'hungryy') {
    context.pushNamed('hungryy');
  } else if (projectId == 'newproject') {  // Add this
    context.pushNamed('newproject');
  } else {
    context.pushNamed('project', pathParameters: {'projectId': projectId});
  }
},
```

---

## 14. Automatic Behavior

After adding project data, these things happen automatically:

1. **Project card appears** on the homepage in the Projects section
2. **Hover animations** work automatically via `ProjectCard`
3. **Responsive layout** adapts automatically (mobile/desktop)
4. **Dark/light mode** styling is applied automatically
5. **Scroll animations** trigger automatically via `AnimatedSection`
6. **Tech chips** render automatically from the `technologies` list
7. **Action buttons** render conditionally based on which URLs are provided

---

## 15. Hidden Dependencies

### 15.1 Home Page Navigation Callback

**File**: `lib/features/home/presentation/pages/home_page.dart` (lines 121-129)

The `ProjectsSection.onCaseStudyTap` callback routes differently based on project ID. If using the **dedicated pattern**, you MUST add an `else if` condition here. If using the **registry pattern**, no change is needed (it falls through to the generic `/project/:projectId` route).

### 15.2 Router Imports

**File**: `lib/core/router/app_router.dart`

If using the **dedicated pattern**, you MUST import the new detail page and add a `GoRoute`.

### 15.3 ProjectDataRegistry.init()

**File**: `lib/features/project/data/project_data_registry.dart`

If using the **registry pattern**, you MUST call `register()` for the new data class in the `init()` method. This is called once in `main.dart`.

### 15.4 Logo Asset Naming

**File**: `assets/images/`

Logo assets use spaces in filenames (e.g., `logo  hungry.png`). If adding a new logo, follow the same convention or update the asset path reference.

### 15.5 ScreenUtil Design Size

**File**: `lib/main.dart`

The design size is `Size(1440, 900)`. All responsive calculations are based on this.

### 15.6 Section Order Matters

In both detail page patterns, sections are rendered in a specific order. The `ListView.builder` uses the `_sections` list index to determine rendering order. Changing the order changes the user experience.

---

## 16. Existing Project Comparison

| Aspect | VitaGuard | Hungryy |
|--------|-----------|---------|
| **Data class** | `VitaguardData implements ProjectData` | `HungryyData` (standalone) |
| **Detail page** | `ProjectDetailPage` (generic) | `HungryyDetailPage` (dedicated) |
| **Route** | `/project/vitaguard` (dynamic) | `/case-study/hungryy` (static) |
| **Sections** | 13 sections | 37 sections |
| **Card style** | Gradient placeholder (no logo set) | Gradient placeholder with logo |
| **Card colors** | Default (dark blue) | Custom green (`0xFF0F3D2E`) |
| **Logo asset** | Default fallback (`logo vita.jpeg`) | Custom (`logo hungry.png`) |
| **Screenshots** | Google Drive link | Placeholder grid |
| **Data fields** | 40+ abstract getters | 30+ custom fields |
| **Section widgets** | 13 separate widget files | 6 files (4 builders + 2 custom) |
| **Reusable builders** | None (each section is standalone) | `HungryyTextSection`, `HungryyCardGridSection`, etc. |
| **Custom colors file** | No | `hungryy_colors.dart` |
| **Registry registered** | Yes | No |
| **Navigation** | Falls through to generic route | Special-cased in `home_page.dart` |

### Common Pattern Across Both

- Both use `GlassCard` for content containers
- Both use `AnimatedSection` for scroll-reveal animations
- Both use `context.responsive` helpers for mobile/tablet/desktop breakpoints
- Both render sections in a `ListView.builder` with `RepaintBoundary` wrappers
- Both have a Hero section with: back button, status badge, title, tagline, role/team/timeline metadata, tech chips, action buttons
- Both have a Bottom CTA section with: gradient container, back/GitHub/contact buttons
- Both use `AppColors` for theming and `AppConstants` for global URLs

---

## 17. Naming Conventions

### Files
- Detail pages: `{project_name}_detail_page.dart`
- Data classes: `{project_name}_data.dart`
- Section widgets: `ps_{section_name}.dart` (VitaGuard) or `hs_{section_name}.dart` (Hungryy)
- Colors: `{project_name}_colors.dart`
- Section builders: `{project_name}_section_builders.dart`

### Classes
- Data: `{ProjectName}Data` (e.g., `VitaguardData`, `HungryyData`)
- Detail page: `{ProjectName}DetailPage` (e.g., `HungryyDetailPage`)
- Sections: `{Prefix}{SectionName}Section` (e.g., `ProjectHeroSection`, `HungryyHeroSection`)
- Models: `{ProjectName}{ModelName}` (e.g., `HungryyCardItem`, `HungryyPlaceholderItem`)

### IDs
- Used in `Project.id` and `ProjectData.id`
- Lowercase, no spaces: `'vitaguard'`, `'hungryy'`
- Must be unique across all projects

### Routes
- Pattern: `/project/{id}` (dynamic) or `/case-study/{id}` (static)
- Route names: lowercase, matching the ID

---

## 18. Validation & Testing Checklist

After integrating a new project, verify:

- [ ] The project card appears on the homepage
- [ ] The card displays correct title, subtitle, description
- [ ] Tech chips render correctly
- [ ] All links (GitHub, Demo, Gallery) open correctly
- [ ] Case Study button navigates to the detail page
- [ ] Detail page renders all sections in correct order
- [ ] Detail page shows correct project data
- [ ] Back button returns to homepage
- [ ] Mobile layout renders correctly (test at < 600px width)
- [ ] Tablet layout renders correctly (600-1023px)
- [ ] Desktop layout renders correctly (>= 1024px)
- [ ] Dark mode styling is correct
- [ ] Light mode styling is correct
- [ ] Scroll animations trigger on visibility
- [ ] Hover effects work on cards and buttons
- [ ] No lint errors (`flutter analyze`)
- [ ] App builds successfully (`flutter build web`)
- [ ] All asset paths resolve correctly

---

## 19. Step-by-Step New Project Integration Procedure

### Phase 1: Prepare Assets

1. [ ] Prepare project logo image (PNG or JPEG)
2. [ ] Place logo in `assets/images/` with naming convention: `logo {project_name}.png`
3. [ ] If using gradient placeholder, choose 3 gradient colors and 1 glow color
4. [ ] If using network card image, have the URL ready
5. [ ] Collect GitHub URL, demo URL, screenshots URL

### Phase 2: Add Card Data

6. [ ] Open `lib/features/project/presentation/widgets/sections/vitagaurd/projects_section.dart`
7. [ ] Add a new `Project(...)` to the `_projects` list
8. [ ] Fill in: `id`, `title`, `subtitle`, `description`, `role`, `technologies`, `highlights`
9. [ ] Add link URLs: `githubUrl`, `demoUrl`, `googleDriveScreenshotsUrl`
10. [ ] Set `caseStudyRoute` to the route path
11. [ ] If gradient placeholder: add `logoAsset`, `cardSubtitle`, `cardGradientColors`, `cardGlowColor`, `cardLogoGradientColors`

### Phase 3A: Registry Pattern (Recommended)

12. [ ] Create `lib/features/project/data/{project_name}_data.dart`
13. [ ] Implement `ProjectData` abstract class with all required getters
14. [ ] Open `lib/features/project/data/project_data_registry.dart`
15. [ ] Import the new data file
16. [ ] Add `register(const NewProjectData());` in `init()`

**Done.** The generic `ProjectDetailPage` handles everything.

### Phase 3B: Dedicated Pattern

12. [ ] Create `lib/features/project/data/{project_name}_data.dart` with custom data class
13. [ ] Create `lib/features/project/presentation/pages/{project_name}_detail_page.dart`
14. [ ] Create `lib/features/project/presentation/widgets/sections/{project_name}/` directory
15. [ ] Create section widget files (hero, content sections, conclusion)
16. [ ] Optionally create `{project_name}_colors.dart` and `{project_name}_section_builders.dart`
17. [ ] Open `lib/core/router/app_router.dart`
18. [ ] Import the new detail page
19. [ ] Add a new `GoRoute` entry
20. [ ] Open `lib/features/home/presentation/pages/home_page.dart`
21. [ ] Add routing condition for the new project ID in `onCaseStudyTap`

### Phase 4: Verify

22. [ ] Run `flutter analyze` — fix any errors
23. [ ] Run `flutter build web` — ensure build succeeds
24. [ ] Open in browser — verify card appears
25. [ ] Click Case Study — verify detail page loads
26. [ ] Test on mobile viewport
27. [ ] Test on desktop viewport
28. [ ] Test dark mode
29. [ ] Test light mode
30. [ ] Test all external links

---

## 20. Important Rules / Do's and Don'ts

### Do's

- **DO** follow the existing naming conventions for files and classes
- **DO** use `GlassCard` for content containers
- **DO** use `AnimatedSection` to wrap sections for scroll-reveal animations
- **DO** use `context.responsive` helpers for responsive sizing
- **DO** use `AppColors` for theme colors
- **DO** use `UrlUtils.openUrl()` for external links
- **DO** use `RepaintBoundary` for complex widgets in list views
- **DO** ensure all `ProjectData` abstract members are implemented (registry pattern)
- **DO** test on mobile, tablet, and desktop viewports

### Don'ts

- **DON'T** modify existing project data or project card data
- **DON'T** change the order of existing projects in the `_projects` list (unless intentional)
- **DON'T** remove or rename existing routes
- **DON'T** modify the `Project` model or `ProjectData` abstract class
- **DON'T** change the `ProjectCard` or `ProjectImage` components
- **DON'T** add assets outside the `assets/` directory
- **DON'T** hardcode colors — use `AppColors` or project-specific color files
- **DON'T** skip the registry registration step (registry pattern)
- **DON'T** forget to add routing for dedicated pattern projects
- **DON'T** use relative imports — use `package:portfolio/...` imports

### Special Cases

- **Hungryy uses a space in its logo filename**: `logo  hungry.png` (two spaces). This is an existing convention.
- **Vitaguard has a typo in directory name**: `vitagaurd` (misspelled). New projects should use correct spelling.
- **The `ProjectsSection` file is inside the `vitagaurd/` directory** despite being a shared component. This is an existing quirk.
- **Some projects use gradient placeholders** (no network image). This is the preferred approach — it avoids external image dependencies.
- **The registry `init()` is called once** in `main.dart` at app startup. It must include all registry-pattern projects.
