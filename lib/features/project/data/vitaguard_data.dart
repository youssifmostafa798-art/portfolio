import 'package:flutter/material.dart';
import 'project_data.dart';

final class VitaguardData implements ProjectData {
  const VitaguardData();

  @override
  String get id => 'vitaguard';

  @override
  String get title => 'VitaGuard';

  @override
  String get tagline => 'Real-Time Health Monitoring System';

  @override
  String get role => 'Flutter Mobile Application Developer';

  @override
  String get status => 'Production Ready';

  @override
  String get teamSize => '4';

  @override
  String get timeline => '2025 – 2026';

  @override
  String get demoUrl =>
      'https://drive.google.com/drive/folders/1H8eaAhWB0pJYPRR3H30GP1JRYmBK0s1R?usp=sharing';

  @override
  String get screenshotsUrl =>
      'https://drive.google.com/drive/folders/1L3Hf67WcEH76gWpr18T8MGqCamE4ULES?usp=sharing';

  @override
  String get githubUrl =>
      'https://github.com/youssifmostafa798-art/vitaguard_app.git';

  @override
  List<String> get techStack => const [
    'Flutter',
    'Dart',
    'Riverpod',
    'Supabase',
    'REST APIs',
    'Git',
    'GitHub',
    'Responsive UI',
    'Clean Architecture',
    'Material 3',
    'TFLite',
    'Drift',
    'ESP32',
    'Firebase',
  ];

  @override
  List<String> get techStackTop => techStack.take(7).toList();

  @override
  String get overviewWhat =>
      'VitaGuard is a production-grade real-time health monitoring system that '
      'bridges embedded hardware and mobile software. It integrates an ESP32 '
      'wearable with biometric sensors (MAX30102, MPU6050, DS18B20) to a Flutter '
      'mobile application, delivering sub-second vital sign data via Supabase '
      'WebSocket Realtime subscriptions.';

  @override
  String get overviewProblem =>
      'Continuous remote patient monitoring requires a reliable end-to-end pipeline '
      'from sensor to caregiver. Existing solutions are either expensive clinical '
      'systems or fragmented consumer wearables with no real-time alert delivery. '
      'VitaGuard needed to bridge this gap: affordable hardware, a multi-role '
      'mobile app, on-device AI for offline chest X-ray analysis, and an alert '
      'system that prevents fatigue while never missing a critical event.';

  @override
  String get overviewTargetUsers =>
      'Patients requiring continuous vital sign monitoring, their companions and '
      'family members, doctors managing multiple patients remotely, and clinical '
      'facilities overseeing at-home recovery programs.';

  @override
  String get overviewWhyMatters =>
      'VitaGuard enables affordable, continuous remote monitoring that reduces '
      'hospital readmissions and provides peace of mind for elderly patients '
      'living alone. On-device AI brings diagnostic support to low-connectivity '
      'clinics, and the offline-first architecture ensures no critical data is '
      'lost during network interruptions.';

  @override
  List<String> get contributions => const [
    'UI Implementation — Built the entire Flutter UI including real-time vital sign '
        'displays with animated heart rate rings, color-coded alert banners, '
        'multi-tab patient dashboards, and role-specific navigation structures.',
    'State Management — Implemented Riverpod with code generation for all app '
        'state: auth state (AsyncValue), alert state (custom Notifier), vitals '
        '(StreamProvider), and role-specific controllers using ref.keepAlive() '
        'and ref.invalidateSelf() for clean logout.',
    'API & Supabase Integration — Integrated Supabase Auth with session restoration, '
        'Database (CRUD across 15+ tables with RLS), Realtime (WebSocket subscriptions), '
        'Storage (X-ray uploads), Edge Functions (13 serverless functions), and RPC.',
    'Responsive UI — Used flutter_screenutil with custom configuration for proportional '
        'sizing across phone and tablet layouts. Built role-specific navigation with '
        'FlexibleNavBar supporting hidden indexes per role.',
    'Architecture — Designed a four-layer architecture (Core → Data → Features → '
        'Presentation) with abstract repository interfaces, 15+ Drift local tables, '
        'and feature isolation per user role.',
    'Reusable Components — Created a library: ClinicalFeedbackPanel (toast/notification '
        'system), FlexibleNavBar, MetricCard, VitalAlertBanner, and role-specific '
        'screen templates with queue management and lifecycle-aware timers.',
    'Performance Optimization — Offloaded AI preprocessing to background isolate via '
        'Flutter.compute(), used IsolateInterpreter for TFLite with GPU delegate '
        'and CPU fallback, wrapped animated widgets in RepaintBoundary.',
    'Navigation & Routing — Built role-based routing through AuthGate switching the '
        'app entry point per role. Each role has its own bottom navigation with '
        'role-specific tabs using IndexedStack.',
    'Animations — Animated heart rate BPM ring (AnimatedContainer, 300ms) with '
        'color-coded borders, AnimatedSwitcher for icon transitions, and three-state '
        'alert banners (normal → pre-alert → active).',
    'Error Handling — ClinicalErrorContext system with area-specific messages (auth, '
        'upload, xrayAi, alerts, hardware, network, database) and developer '
        'diagnostics mode for debug-only technical details.',
  ];

  @override
  List<FeatureItem> get features => const [
    FeatureItem(
      'Real-Time Health Monitoring',
      'Sub-second vital sign delivery (BPM, SpO2, temperature) from ESP32 wearable '
          'to mobile app via Supabase WebSocket Realtime subscriptions.',
      Icons.favorite_rounded,
    ),
    FeatureItem(
      'On-Device AI X-Ray Analysis',
      'DenseNet121 chest X-ray classifier running entirely on-device with GPU '
          'acceleration, background isolate preprocessing, and CPU fallback. '
          'Calibrated three-way classification with FDA SaMD-inspired thresholds.',
      Icons.biotech_rounded,
    ),
    FeatureItem(
      'Multi-Role Auth System',
      'Four distinct registration flows (patient, doctor, companion, facility) with '
          'role-specific validation, Supabase RLS policies, secure companion-to-patient '
          'code linking, and session restoration with retry logic.',
      Icons.verified_user_rounded,
    ),
    FeatureItem(
      'Offline-First Architecture',
      'Drift SQLite local database with 15 cached tables mirroring Supabase. Sync '
          'queue captures failed writes with retry tracking and automatic replay '
          'when connectivity returns.',
      Icons.offline_bolt_rounded,
    ),
    FeatureItem(
      'Intelligent Multi-Tier Alert System',
      '45-second onset delay with severity classification, combined risk detection, '
          'rolling window smoothing, stale-sensor watchdog (60s), and realtime '
          'broadcast to companions and doctors.',
      Icons.notifications_active_rounded,
    ),
    FeatureItem(
      'Two-Phase Medical Review',
      'FDA SaMD-inspired workflow: Phase 1 (manual diagnosis without AI) → Phase 2 '
          '(AI results revealed, doctor confirms or overrides). Full audit trail.',
      Icons.assignment_rounded,
    ),
    FeatureItem(
      'Clinical Feedback Overlay',
      'Production-grade toast system with deduplication, queue management, '
          'lifecycle-aware timers, haptic feedback, dark mode, and accessibility.',
      Icons.feedback_rounded,
    ),
  ];

  @override
  List<ArchitectureLayer> get architecture => const [
    ArchitectureLayer(
      'Flutter Application',
      'Role-specific screens, reusable widgets, animated UI components',
    ),
    ArchitectureLayer(
      'State Management',
      'Riverpod with code generation — Notifiers, StreamProviders, AsyncValue',
    ),
    ArchitectureLayer(
      'Repository Layer',
      'Abstract interfaces with Supabase and Drift implementations, sync queue',
    ),
    ArchitectureLayer(
      'Supabase Backend',
      'Auth, Database (15+ tables), Realtime, Storage, 13 Edge Functions, RLS',
    ),
    ArchitectureLayer(
      'Hardware & AI',
      'ESP32 + biometric sensors, TFLite DenseNet121 on-device inference',
    ),
  ];

  @override
  List<TechCategory> get techCategories => const [
    TechCategory('Framework', 'Flutter 3.11+, Material 3'),
    TechCategory('Language', 'Dart 3.x'),
    TechCategory('State Management', 'Riverpod + riverpod_annotation'),
    TechCategory(
      'Backend',
      'Supabase (Auth, DB, Realtime, Storage, Edge Functions)',
    ),
    TechCategory('Local Database', 'Drift (SQLite) with code generation'),
    TechCategory('AI/ML', 'tflite_flutter, IsolateInterpreter, GpuDelegateV2'),
    TechCategory(
      'Architecture',
      'Clean Architecture (4-layer), Repository Pattern',
    ),
    TechCategory('Responsive', 'flutter_screenutil, custom breakpoints'),
    TechCategory('Images', 'cached_network_image, image_picker'),
    TechCategory('Connectivity', 'connectivity_plus, offline sync queue'),
    TechCategory(
      'Notifications',
      'flutter_local_notifications, custom alert service',
    ),
    TechCategory('Version Control', 'Git, GitHub'),
  ];

  @override
  List<ChallengeItem> get challenges => const [
    ChallengeItem(
      'Alert Fatigue Prevention',
      'ESP32 sensor noise caused transient false readings, triggering false alarms '
          'that would cause alert fatigue for doctors and companions.',
      'Implemented 45-second onset delay collecting 5 consecutive readings before '
          'triggering. Added stale-sensor watchdog (60s timeout), combined risk '
          'detection (low SpO2 + high HR escalates to critical), and per-screen '
          'isolated AlertTimerService for independent patient session state.',
    ),
    ChallengeItem(
      'Model Input Size Bug',
      'DenseNet121 trained at 320×320 but TFLite configured for 224×224, causing '
          'incorrect feature vectors and clinically unacceptable false positives.',
      'Added tensor shape verification in ensureLoaded(), implemented dynamic '
          'resizing via resizeInputTensor(), added shape validation rejecting CHW/NCHW '
          'layouts. False-positive rate dropped to calibrated 96% precision.',
    ),
    ChallengeItem(
      'Four-Role Authentication',
      'Four user types needing different registration flows, data access, and '
          'privacy constraints within a single app.',
      'Built four separate registration flows with Supabase Auth metadata. Companion '
          'linking uses 6-character codes via Edge Function with secure RPC. Added '
          'retry logic for database trigger races and auto-repair for legacy users.',
    ),
    ChallengeItem(
      'Real-Time Alert Delivery',
      'Critical health alerts must reach companions and doctors instantly across '
          'multiple channels, even when the app is in background or offline.',
      'Three-layer pipeline: server Edge Function evaluates thresholds and broadcasts '
          'via Realtime. Flutter subscribes via role-specific channels. AlertController '
          'manages local state, notifications, acknowledgments, and offline resync.',
    ),
    ChallengeItem(
      'Offline Data Resilience',
      'Hospital Wi-Fi and mobile networks are unreliable. Critical medical data '
          'could be lost during network interruptions.',
      'Drift SQLite with 15 cached tables. SyncQueueRepository captures failed writes '
          'with retry tracking. ConnectivitySyncCoordinator monitors state and triggers '
          'batch replay on reconnection with per-item error handling.',
    ),
  ];

  @override
  List<PerformanceItem> get performanceItems => const [
    PerformanceItem(
      'Background Isolate AI',
      'Image preprocessing runs via Flutter.compute() in a background isolate '
          'so the UI thread is never blocked during X-ray analysis.',
    ),
    PerformanceItem(
      'GPU Delegate + CPU Fallback',
      'TFLite inference first attempts GPU via GpuDelegateV2(), then falls back '
          'to CPU. Handles device heterogeneity across the Android ecosystem.',
    ),
    PerformanceItem(
      'RepaintBoundary Wrappers',
      'Heart rate ring and alert banner wrapped in RepaintBoundary to prevent '
          'unnecessary repaints of complex animated widgets.',
    ),
    PerformanceItem(
      'Cached Network Images',
      'CachedNetworkImage for network-resilient loading with disk caching, '
          'reducing bandwidth and improving perceived performance.',
    ),
    PerformanceItem(
      'Optimistic Updates',
      'Alert acknowledgment updates UI immediately, reverts if API call fails. '
          'Instant feedback with data consistency.',
    ),
    PerformanceItem(
      'Provider Lifecycle Management',
      'ref.keepAlive() for long-running services. ref.invalidateSelf() on logout. '
          'ref.onDispose() for Realtime channel cleanup.',
    ),
  ];

  @override
  List<String> get results => const [
    'Production-grade medical monitoring system with 4 user roles and 7 major features',
    'Sub-second vital sign delivery from ESP32 hardware to mobile app via WebSocket',
    'On-device AI achieving 96.1% precision in chest X-ray classification',
    'Offline-first architecture ensuring zero data loss during network interruptions',
    '13 Supabase Edge Functions for hardware telemetry, AI, and admin workflows',
    'FDA SaMD-inspired two-phase medical review with full audit trail',
  ];

  @override
  List<String> get lessons => const [
    'Layered architecture in practice: separating infrastructure (core), data access '
        '(repositories), business logic (controllers), and UI (widgets) without '
        'over-abstracting — a pragmatic adaptation of Clean Architecture.',
    'Riverpod advanced patterns: ref.keepAlive(), provider invalidation chains, '
        'AsyncValue error handling, and knowing when to use global providers vs '
        'scoped providers vs ephemeral StreamBuilder state.',
    'Medical-grade UX design: color-coded alert states with animated transitions, '
        'haptic feedback on critical alerts, and semantic accessibility with liveRegion.',
    'On-device ML engineering: model training (DenseNet121 at 320×320), export '
        '(fastai → ONNX → TFLite), deployment (GPU delegate, shape verification), '
        'and safety calibration (softmax stability, uncertainty bands).',
    'Production error handling: structured ClinicalErrorContext system with '
        'area-specific messages, developer diagnostics, and lifecycle-managed display.',
    'Offline-first architecture: typed SQLite tables mirroring server schema, sync '
        'queue with operation replay, connectivity monitoring, and retry backoff.',
  ];

  @override
  List<FutureItem> get futureItems => const [
    FutureItem(
      'CI/CD Pipeline',
      'Automated testing and deployment via GitHub Actions and Codemagic for '
          'iOS/Android builds with Supabase migrations.',
      Icons.rocket_launch_rounded,
    ),
    FutureItem(
      'Comprehensive Test Suite',
      'Unit tests for repositories and controllers, widget tests for components, '
          'and integration tests for critical user flows.',
      Icons.science_rounded,
    ),
    FutureItem(
      'Push Notification Enhancement',
      'Firebase Cloud Messaging integration for reliable push delivery when '
          'the app is in background or terminated.',
      Icons.notifications_rounded,
    ),
    FutureItem(
      'Apple Watch Companion',
      'watchOS companion app for quick vital sign glance and alert notifications '
          'directly on the wrist.',
      Icons.watch_rounded,
    ),
    FutureItem(
      'Web Dashboard',
      'Flutter Web dashboard for desktop monitoring sharing the same architecture '
          'and state management.',
      Icons.monitor_rounded,
    ),
    FutureItem(
      'Multi-Language Support',
      'Localization via Flutter l10n for Arabic, English, and additional languages '
          'to serve diverse clinical environments.',
      Icons.language_rounded,
    ),
  ];

  @override
  List<String> get screenshotLabels => const [
    'Patient Dashboard',
    'Health Monitoring',
    'AI X-Ray Analysis',
    'Alert Center',
  ];

  @override
  List<Color> get screenshotColors => const [
    Color(0xFF0D1B2A),
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
    Color(0xFF0F3460),
  ];

  @override
  String get overviewSubtitle =>
      'What VitaGuard is, the problem it solves, and why it matters.';

  @override
  String get contributionSubtitle =>
      'As the Flutter Mobile Application Developer on a 12-person team.';

  @override
  String get featuresSubtitle =>
      'Key capabilities that make VitaGuard a production-grade medical system.';

  @override
  String get architectureSubtitle =>
      'The four-layer architecture powering the system.';

  @override
  String get techStackSubtitle =>
      'Technologies and tools used throughout the project.';

  @override
  String get challengesSubtitle =>
      'Major technical challenges and how they were solved.';

  @override
  String get performanceSubtitle =>
      'Techniques used to ensure smooth, responsive, and efficient operation.';

  @override
  String get gallerySubtitle => 'Screenshots and visuals from the application.';

  @override
  String get resultsSubtitle =>
      'Outcomes and achievements from the VitaGuard project.';

  @override
  String get lessonsSubtitle =>
      'Technical and professional growth from building VitaGuard.';

  @override
  String get futureSubtitle =>
      'Planned enhancements and roadmap for the project.';

  @override
  String get bottomCtaTitle => 'Interested in this project?';

  @override
  String get bottomCtaSubtitle =>
      'Explore the code, watch the demo, or get in touch.';
}
