# Catire Mobile App

A Flutter-based mobile news application with a cat-themed twist! Browse articles, discover cat facts, and manage your reading history—all in one app.

---

## Features

### News & Articles
- **Home Feed** — Curated staff picks and top 10 trending articles
- **Article Browser** — Browse articles with category filtering (World, Lifestyle, Science, Technology, Sports, etc.)
- **Article Search** — Full-text search across all articles
- **Infinite Scroll** — Pagination with automatic loading
- **Article Details** — Full article view with paragraphs

### Cat Facts Gallery
- Browse adorable cat images with fun facts
- Tap to view images in full-screen mode
- Captions and detailed descriptions

### User Account
- Customizable profile with name and bio
- Profile picture display
- Reading history tracking
- Clear history functionality

### Additional Features
- **About Page** — Learn about the app
- **Contact Page** — Get in touch
- **Disclaimer Page** — Legal information
- **Social Media Links** — Connect on Instagram, YouTube, and X (Twitter)

---

## 🏗️ Project Architecture

```
lib/
├── main.dart                 # App entry point & main scaffold
├── core/                     # Core business logic
│   ├── api/                  # API client functions
│   │   └── article_api.dart
│   ├── models/               # Data models
│   │   ├── article_model.dart
│   │   └── image_model.dart
│   ├── services/             # Business services
│   │   ├── article_service.dart
│   │   └── database_service.dart
│   └── utils/                # Utility functions
│       ├── color_helper.dart
│       ├── data_formatter.dart
│       ├── tap_helper.dart
│       └── text_formatter.dart
├── data/                     # Static data
│   ├── cat_image_item.dart
│   └── home_page_item.dart
└── features/                 # Feature modules
    ├── account/              # User account components
    │   ├── account_history_section.dart
    │   ├── account_info_section.dart
    │   └── profile_picture.dart
    ├── image/                # Image display components
    │   ├── image_card.dart
    │   └── image_full_screen.dart
    ├── layout/               # App layout components
    │   ├── bottom_bar.dart
    │   └── top_bar.dart
    ├── news/                 # News feature components
    │   ├── article_card.dart
    │   ├── article_detail_screen.dart
    │   ├── article_history_section.dart
    │   ├── article_section.dart
    │   ├── category_slider.dart
    │   ├── empty_view.dart
    │   ├── error_view.dart
    │   ├── horizontal_article_carousel.dart
    │   ├── loading_view.dart
    │   └── top_ten_section.dart
    ├── pages/                # Main app pages
    │   ├── about_page.dart
    │   ├── account_page.dart
    │   ├── articles_page.dart
    │   ├── cats_page.dart
    │   ├── contact_page.dart
    │   ├── disclaimer_page.dart
    │   ├── home_page.dart
    │   ├── menu_page.dart
    │   └── search_page.dart
    └── shared/               # Shared components
        ├── section_header.dart
        └── section.dart
```

---

## Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd catire-mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

---

## Database Schema

The app uses SQLite for local data persistence:

### Users Table
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key |
| name | TEXT | User display name |
| bio | TEXT | User biography |

### Read Articles Table
| Column | Type | Description |
|--------|------|-------------|
| id | TEXT | Article ID (primary key) |
| title | TEXT | Article title |
| summary | TEXT | Article summary |
| datePublished | TEXT | Publication date |
| mainCategory | TEXT | Primary category |
| viewed | INTEGER | View count |
| readAt | INTEGER | Timestamp when read |

---

## API Integration

The app connects to a REST API for article data:

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/articles` | Fetch paginated articles |
| POST | `/article/detail` | Get full article details |
| GET | `/articles/top-ten` | Fetch top 10 articles |
| PUT | `/article/viewed/:id` | Increment view count |

### Query Parameters (Articles)

| Parameter | Type | Description |
|-----------|------|-------------|
| page | int | Page number (default: 1) |
| limit | int | Items per page (default: 10) |
| category | string | Filter by category |
| search | string | Search query |
| dateRange | string | Filter by date range |
| sortBy | string | Sort order (e.g., "newest") |

---

## Navigation

The app uses a bottom navigation bar with 5 main sections:

| Icon | Label | Page | Description |
|------|-------|------|-------------|
| 🏠 | Home | `HomePage` | Featured content & top articles |
| 📰 | News | `ArticlesPage` | Browse articles by category |
| 🖼️ | Cats | `CatsPage` | Cat facts image gallery |
| 👤 | Account | `AccountPage` | User profile & history |
| ☰ | More | `MenuPage` | About, Contact, Disclaimer |

---

## Assets

The app includes image assets:

```
assets/
└── images/
    ├── cat_pictures/          # Cat fact images
    │   ├── cat_image_1.png
    │   ├── ...
    │   └── home_image.jpg
    └── profile_pictures/      # User profile images
        └── cat_albert.jpg
```