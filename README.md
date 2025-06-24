# Events Solutech - Visits Tracker App

A comprehensive Flutter application for tracking customer visits and activities with beautiful analytics and modern Material 3 design.

## 🔗 GitHub Repository

[https://github.com/yourusername/events_solutech](https://github.com/yourusername/events_solutech)

## 📱 Overview

Events Solutech is a modern Flutter application designed to help businesses track and manage customer visits efficiently. The app provides an intuitive interface for recording visits, managing customer information, and analyzing visit patterns through comprehensive analytics.

### Key Features

- 📋 **Visit Management**: Create, view, and manage customer visits with detailed information
- 👥 **Customer Database**: Maintain customer information and visit history
- 📊 **Activity Tracking**: Record specific activities performed during visits
- 📈 **Analytics Dashboard**: Beautiful charts and statistics with progress indicators
- 🌓 **Adaptive Theming**: Supports both light and dark themes following system settings
- 🎨 **Material 3 Design**: Modern UI with consistent design language
- 📱 **Responsive Layout**: Optimized for various screen sizes

## 📸 Screenshots

### Main Navigation

![Main Navigation](screenshots/main_navigation.png)

### Visits List

![Visits List](screenshots/visits_list.png)

### Add Visit Form

![Add Visit Form](screenshots/add_visit.png)

### Analytics Dashboard

![Analytics Dashboard](screenshots/analytics_dashboard.png)

### Light & Dark Theme

![Theme Comparison](screenshots/theme_comparison.png)

## 🏗️ Architecture & Key Decisions

### State Management

- **Provider Pattern**: Chosen for its simplicity and tight integration with Flutter
- **Separation of Concerns**: Different providers for visits, customers, and activities
- **Reactive UI**: Automatic updates when data changes using `Consumer` widgets

### Project Structure

```

```

## 🎬 Animations & Visual Effects

The app features carefully crafted animations to enhance user experience:

### Animation Types Implemented

#### **Progress Bar Animations**
- **Smooth Progress Bars**: Custom animated progress indicators with rounded corners
- **Staggered Loading**: Progress bars animate with different timing for visual appeal
- **Elastic Curves**: Using `Curves.easeInOut` for natural motion

#### **Card Animations**
- **Scale Animations**: Stats cards animate in with elastic bounce effects
- **Staggered Entrance**: Cards appear with incremental delays (0ms, 100ms, 200ms, 300ms)
- **Transform Scale**: Using `TweenAnimationBuilder` for smooth scaling effects

#### **Page Transitions**
- **Fade Animations**: Smooth transitions between different sections
- **Loading States**: Animated loading indicators while data loads

#### **Interactive Elements**
- **Button Press Effects**: Subtle scale animations on button interactions
- **List Item Animations**: Smooth animations when adding new visits
- **Icon Transitions**: Status icons animate color changes

### Technical Implementation

```dart
// Example: Animated Stat Card
TweenAnimationBuilder<double>(
  duration: Duration(milliseconds: 800 + delay),
  tween: Tween(begin: 0.0, end: 1.0),
  curve: Curves.elasticOut,
  builder: (context, animation, child) {
    return Transform.scale(
      scale: animation,
      child: StatCard(...),
    );
  },
)

// Example: Custom Progress Bar with Animation
TweenAnimationBuilder<double>(
  duration: const Duration(milliseconds: 1200),
  tween: Tween(begin: 0.0, end: progress),
  curve: Curves.easeInOut,
  builder: (context, value, child) {
    return CustomProgressBar(value: value);
  },
)
```
