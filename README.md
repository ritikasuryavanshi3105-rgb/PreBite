# 🍏 PreBite

> Make smarter food choices, one scan at a time.

PreBite is a Flutter-based mobile application designed to help users understand food products and make healthier choices through product analysis, nutrition insights, ingredient information, product comparison, and personalized recommendations.

## 🚀 Features

- 📱 Barcode Scanner UI
- 🥗 Product Health Analysis
- 🧾 Detailed Ingredient Information
- 📊 Nutrition Analysis
- 🔄 Product Comparison
- ⭐ Personalized Recommendations & Best Picks
- ❤️ Favorites and Scan History
- 👨‍👩‍👧 Family Profiles & Allergen Configuration
- 🤖 AI Assistant *(planned backend integration)*

## 🛠️ Tech Stack

### Frontend
- **Flutter**
- **Dart**
- **Material 3**
- **GoRouter** for navigation

### Architecture
- Feature-first architecture
- Clean Architecture principles
- Repository pattern
- Reusable Design System
- Reusable UI components

### Planned Backend
- **FastAPI (Python)**
- **PostgreSQL**
- **JWT Authentication**
- **REST APIs**
- **HTTPS**
- Backend-based AI integration

## 📱 Implemented Screens

- Splash & Login
- Home Dashboard
- Barcode Scanner
- Product Overview
- Product Ingredients
- Product Nutrition
- Product Comparison
- Recommendations & Best Picks

## 🏗️ Project Structure

```text
lib/
├── core/
│   ├── routing/
│   └── theme/
├── features/
│   ├── splash/
│   ├── home/
│   ├── scanner/
│   ├── product/
│   ├── comparison/
│   └── recommendations/
└── shared/
    └── widgets/
