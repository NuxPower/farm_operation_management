# ANIBUKID - Farm Operation Management System

<p align="center">
  <strong>A comprehensive farm management platform for rice farmers in Bukidnon, Philippines</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Laravel-12.x-FF2D20?style=for-the-badge&logo=laravel&logoColor=white" alt="Laravel">
  <img src="https://img.shields.io/badge/Vue.js-3.5-4FC08D?style=for-the-badge&logo=vue.js&logoColor=white" alt="Vue.js">
  <img src="https://img.shields.io/badge/TailwindCSS-4.0-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="TailwindCSS">
  <img src="https://img.shields.io/badge/PostgreSQL-14.0-336791?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
</p>

---

## 📋 Table of Contents

1.  [About the Project](#about-the-project)
2.  [Project Objectives Achievement](#project-objectives-achievement)
3.  [Features](#features)
4.  [Tech Stack](#tech-stack)
5.  [System Architecture](#system-architecture)
6.  [Module Overview](#module-overview)
7.  [Security Implementation](#security-implementation)
8.  [Weather & Analytics Engine](#weather--analytics-engine)
9.  [Data Analytics Methodology](#data-analytics-methodology)
10. [Installation & Setup](#installation--setup)
11. [API Endpoints](#api-endpoints)
12. [Testing](#testing)
13. [Code Quality & Audit](#code-quality--audit)

---

## 🌾 About the Project

**ANIBUKID** is a capstone project designed to digitize and optimize rice farming operations in Bukidnon, Philippines. The system integrates:

*   **Smart Weather Analysis:** Real-time weather monitoring with agronomic threshold-based alerts.
*   **Lifecycle Management:** Tracks crops from planting through all growth stages to harvest.
*   **Marketplace Integration:** Connects farmers directly with buyers for B2B rice trading.
*   **Financial Tracking:** Comprehensive expense, labor, and revenue management.

### Problem Statement
Traditional farming relies on manual record-keeping and experience-based decisions, leading to inefficiencies and potential crop losses. ANIBUKID addresses this by providing data-driven insights and actionable recommendations.

---

## 🎯 Project Objectives Achievement

All five core project objectives have been **fully achieved** with comprehensive implementation:

| Objective | Description | Status |
|-----------|-------------|--------|
| **A** | Digital tool for planning, labor tracking, and resource management | ✅ **100%** |
| **B** | Localized weather updates for better farm decisions | ✅ **100%** |
| **C** | Storage and analysis of farm data for informed decision-making | ✅ **100%** |
| **D** | Platform connecting farmers directly to buyers | ✅ **100%** |
| **E** | Integration of operations, weather, and sales into one centralized system | ✅ **100%** |

### Objective A: Planning, Labor Tracking & Resource Management

| Category | Features Implemented |
|----------|---------------------|
| **Planning** | GPS-based field registration, 5-stage rice lifecycle tracking, seedling nursery management, harvest recording |
| **Labor Tracking** | Laborer profiles, task assignment, wage management (daily/piece/contract), auto-expense generation |
| **Resource Management** | Inventory CRUD, WAC calculation, low stock alerts, expense categorization |

**Key Files:** [`FieldController`](app/Http/Controllers/Farm/FieldController.php), [`TaskController`](app/Http/Controllers/Labor/TaskController.php), [`InventoryItemController`](app/Http/Controllers/Inventory/InventoryItemController.php)

---

### Objective B: Localized Weather Updates

| Category | Features Implemented |
|----------|---------------------|
| **Data Collection** | Multi-provider architecture (Open-Meteo, ColorfulClouds, OpenWeatherMap), field-specific GPS-based weather |
| **Decision Support** | Agronomic alerts (heat/cold stress, disease risk), GDD calculation, stage-specific weather analysis, yield impact prediction |
| **Forecasting** | 10-day forecasts, stress event detection, irrigation recommendations |

**Key Files:** [`WeatherService`](app/Services/WeatherService.php), [`WeatherAnalyticsService`](app/Services/WeatherAnalyticsService.php), [`PestPredictionService`](app/Services/PestPredictionService.php)

---

### Objective C: Data Storage & Analysis

| Category | Features Implemented |
|----------|---------------------|
| **Data Storage** | 35 database models covering farms, weather, labor, inventory, financial, marketplace, pest management |
| **Analytics Engine** | 8+ module aggregation, executive summary generation, action suggestions, financial forecasting |
| **Reporting** | Crop yield reports, financial reports, profit/loss analysis, weather impact reports |

**Key Files:** [`DataAnalysisController`](app/Http/Controllers/Analytics/DataAnalysisController.php), [`FinancialService`](app/Services/FinancialService.php), [`ReportController`](app/Http/Controllers/Reports/ReportController.php)

---

### Objective D: Farmer-to-Buyer Marketplace

| Category | Features Implemented |
|----------|---------------------|
| **Marketplace Core** | Guest browsing (no login required), product listings with filters, product details with reviews, buyer registration |
| **Order Management** | Shopping cart, checkout with negotiation, order state machine (Pending → Confirmed → Ready → Delivered) |
| **Commerce Features** | Price negotiation, favorites, order history, auto-sales integration |

**Key Files:** [`RiceMarketplaceController`](app/Http/Controllers/RiceMarketplaceController.php), [`CartController`](app/Http/Controllers/MarketPlace/CartController.php), [`RiceOrderController`](app/Http/Controllers/MarketPlace/RiceOrderController.php)

---

### Objective E: Centralized System Integration

| Integration Path | Description |
|-----------------|-------------|
| **Weather → Operations** | Growth stage weather analysis affects planting recommendations |
| **Operations → Sales** | Harvests link directly to marketplace products |
| **Labor → Financial** | Task completion auto-generates expense records |
| **Inventory → Financial** | Stock purchases auto-create expense entries |
| **Marketplace → Sales** | Order completion triggers unified sale records |

**Unified Dashboard Components:**
- Real-time stats for all modules
- Role-based views (Farmer/Buyer)
- Integrated weather widget
- Cross-module notifications

**Key Files:** [`DashboardController`](app/Http/Controllers/DashboardController.php), [`FarmerDashboard.vue`](resources/js/Pages/Dashboard/FarmerDashboard.vue)

---

## ✨ Features

### 👨‍🌾 For Farmers
- **Field Management:** Register and manage multiple fields with GPS coordinates.
- **Planting Lifecycle:** Track growth stages (Seedling → Tillering → Flowering → Grain Filling → Maturity).
- **Weather Alerts:** Receive actionable advice based on temperature, humidity, and rainfall thresholds.
- **Harvest Recording:** Log yields, quality grades, and harvester shares.
- **Inventory Management:** Track seeds, fertilizers, pesticides with Weighted Average Cost (WAC).
- **Labor Management:** Assign tasks with Daily Rate, Piece Rate, or Pakyao (contract) payments.
- **Sales Dashboard:** Track revenue, analyze trends, and record direct sales.
- **Product Listing:** List rice products for sale in the marketplace.

### 🛒 For Buyers
- **Product Discovery:** Browse available rice products by variety, grade, and location.
- **Order Management:** Place orders with price negotiation capability.
- **Order Tracking:** Real-time status updates (Pending → Confirmed → Ready → Picked Up).

---

## 🛠️ Tech Stack

### Backend
| Technology | Version | Purpose |
|------------|---------|---------|
| **PHP** | 8.2+ | Server-side language |
| **Laravel** | 12.x | MVC Framework |
| **Laravel Sanctum** | 4.2 | API Token Authentication |
| **Guzzle HTTP** | 7.8 | External API requests (Weather) |
| **PostgreSQL** | 14.0+ | Relational Database |
| **Doctrine DBAL** | 4.3 | Database schema modifications |

### Frontend
| Technology | Version | Purpose |
|------------|---------|---------|
| **Vue.js** | 3.5 | Reactive UI Framework |
| **Vue Router** | 4.4 | SPA Routing |
| **Pinia** | 2.2 | State Management |
| **Tailwind CSS** | 4.0 | Utility-first CSS |
| **Chart.js** | 4.4 | Data Visualization |
| **Vite** | 7.0 | Build Tool & Dev Server |
| **Axios** | 1.11 | HTTP Client |
| **Heroicons** | 2.1 | Icon Library |
| **Leaflet** | 1.9 | Interactive Maps (via CDN) |

### External Services
| Service | Purpose |
|---------|---------|
| **Open-Meteo API** | Primary (Current conditions & Historical logs) |
| **ColorfulClouds API** | Primary Forecasts (10-day precision) |
| **OpenWeatherMap** | Agricultural Intelligence (Pest/Disease risks) |
| **Windy.com** | Interactive weather map embed |
| **SMTP** | Email Notifications (OTP, Alerts, Reports) |
| **OpenStreetMap** | Base map tiles for field visualization |

### DevOps & Quality Assurance
| Tool | Version | Purpose |
|------|---------|---------|
| **Larastan** | 3.9 | Static Analysis & Type Checking |
| **PHPUnit** | 11.5 | Unit & Feature Testing |
| **Laravel Pint** | 1.24 | Code Style Fixer (PSR-12) |
| **Faker** | 1.23 | Data Seeding & Testing |
| **Mockery** | 1.6 | Test Mocking |
| **Git** | - | Version Control |

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         FRONTEND (Vue 3 SPA)                    │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────────────────┐ │
│  │  Pages  │  │  Stores │  │ Router  │  │  API Service Layer  │ │
│  │  (Vue)  │  │ (Pinia) │  │         │  │      (Axios)        │ │
│  └────┬────┘  └────┬────┘  └────┬────┘  └──────────┬──────────┘ │
│       └────────────┴────────────┴──────────────────┘            │
└───────────────────────────────┬─────────────────────────────────┘
                                │ HTTP/JSON
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    BACKEND (Laravel 12)                         │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                     API Routes                            │   │
│  │   /api/farmer/*  (FarmerMiddleware)                      │   │
│  │   /api/buyer/*   (BuyerMiddleware)                       │   │
│  │   /api/marketplace/* (Public + Auth)                     │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                │                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │  Controllers │  │   Services   │  │       Models         │   │
│  │  (HTTP I/O)  │  │  (Business)  │  │  (Eloquent ORM)      │   │
│  └──────────────┘  └──────────────┘  └──────────────────────┘   │
│         │                  │                    │               │
│         └──────────────────┴────────────────────┘               │
│                           │                                     │
│  ┌────────────────────────┴─────────────────────────────────┐   │
│  │                  PostgreSQL Database                     │   │
│  │   users, farms, fields, plantings, harvests, expenses,   │   │
│  │   inventory_items, tasks, rice_products, rice_orders...  │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

---

---

## 🔄 Input-Process-Output (IPO) Model

```text
       INPUTS                       PROCESS                       OUTPUTS
+-------------------+      +-------------------------+      +---------------------+
|                   |      |                         |      |                     |
|  👨‍🌾 Farmer Data   |----->|   Core Business Logic   |----->|  📊 Dashboards      |
|  🛒 Buyer Orders   |      |   (Auth, Validation)    |      |  🔔 Alerts          |
|  ☁️ Weather APIs   |      |          +              |      |  📄 Reports         |
|  🗺️ Map Service    |----->|   🧠 Analytics Engine   |----->|  💡 Suggestions     |
|                   |      |                         |      |                     |
+-------------------+      +-----------+-------------+      +---------------------+
                                       |
                                       v
                             +---------------------+
                             |                     |
                             |  🗄️ Database Storage  |
                             |                     |
                             +---------------------+
```

### Flow Description
1.  **Input:** User data (from Farmers and Buyers) and External APIs (Weather, Maps) feed into the system.
2.  **Process:** Data is securely authenticated and processed by the Core Business Logic. The Analytics Engine computes specialized insights (e.g., GDD, Pest Risks). All state is persisted in the Database.
3.  **Output:** The system generates visual Dashboards, real-time Alerts, formal Reports, and Actionable Suggestions to guide decision-making.

---

## 🔄️ User Flow Diagram

```text
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                           START                                                      │
└─────────────────────────────────────────────────┬───────────────────────────────────────────────────┘
                                                  │
                                                  ▼
                                    ┌─────────────────────────┐
                                    │      Landing Page       │
                                    │   (Welcome / Login)     │
                                    └────────────┬────────────┘
                                                 │
                          ┌──────────────────────┼──────────────────────┐
                          │                      │                      │
                          ▼                      ▼                      ▼
               ┌──────────────────┐   ┌──────────────────┐   ┌──────────────────┐
               │   Login (Email)  │   │  Register New    │   │   Browse as      │
               │                  │   │     Account      │   │     Guest        │
               └────────┬─────────┘   └────────┬─────────┘   └────────┬─────────┘
                        │                      │                      │
                        │                      ▼                      │
                        │           ┌──────────────────┐              │
                        │           │  Select Role:    │              │
                        │           │ Farmer or Buyer  │              │
                        │           └────────┬─────────┘              │
                        │                    │                        │
                        │         ┌──────────┴──────────┐             │
                        │         │                     │             │
                        │         ▼                     ▼             │
                        │  ┌─────────────┐      ┌─────────────┐       │
                        │  │   Farmer    │      │    Buyer    │       │
                        │  │ Registration│      │ Registration│       │
                        │  └──────┬──────┘      └──────┬──────┘       │
                        │         │                    │              │
                        │         └─────────┬──────────┘              │
                        │                   │                         │
                        │                   ▼                         │
                        │         ┌──────────────────┐                │
                        │         │  Email OTP       │                │
                        │         │  Verification    │                │
                        │         └────────┬─────────┘                │
                        │                  │                          │
                        └──────────────────┼──────────────────────────┘
                                           │
                                           ▼
                              ┌────────────────────────┐
                              │   Authentication OK    │
                              │      Check Role        │
                              └───────────┬────────────┘
                                          │
                   ┌──────────────────────┴──────────────────────┐
                   │                                             │
                   ▼                                             ▼
┌─────────────────────────────────────┐       ┌─────────────────────────────────────┐
│          FARMER FLOW                │       │           BUYER FLOW                │
└─────────────────┬───────────────────┘       └─────────────────┬───────────────────┘
                  │                                             │
                  ▼                                             ▼
┌─────────────────────────────────────┐       ┌─────────────────────────────────────┐
│     First Login? → Onboarding       │       │         Buyer Dashboard             │
│  • Create Farm Profile              │       │  • View Order Stats                 │
│  • Register Fields (GPS)            │       │  • Recent Orders                    │
│  • Set Location (Bukidnon)          │       │  • Recommended Products             │
└─────────────────┬───────────────────┘       └─────────────────┬───────────────────┘
                  │                                             │
                  ▼                                             ▼
┌─────────────────────────────────────┐       ┌─────────────────────────────────────┐
│        Farmer Dashboard             │       │        Browse Marketplace           │
│  • Weather Widget (Current/Alerts)  │       │  • Filter by Variety/Grade          │
│  • Active Plantings Status          │       │  • Search Products                  │
│  • Pending Tasks                    │       │  • View Product Details & Reviews   │
│  • Low Stock Alerts                 │       │  • Add to Favorites                 │
│  • Recent Sales & Orders            │       └─────────────────┬───────────────────┘
└─────────────────┬───────────────────┘                         │
                  │                                             ▼
                  │                           ┌─────────────────────────────────────┐
   ┌──────────────┴────────────────────────┐  │         Add to Cart                 │
   │                                       │  │  • Select Quantity                  │
   ▼                                       │  │  • View Farmer Info                 │
┌──────────────────────┐                   │  └─────────────────┬───────────────────┘
│   FARM OPERATIONS    │                   │                    │
├──────────────────────┤                   │                    ▼
│ Field Management     │                   │  ┌─────────────────────────────────────┐
│ • Add/Edit Fields    │                   │  │           Checkout                  │
│ • View Field Map     │                   │  │  • Review Cart Items                │
│ • GPS Coordinates    │                   │  │  • Negotiate Price? (Optional)      │
├──────────────────────┤                   │  │    └─► Farmer Reviews & Responds    │
│ Planting Lifecycle   │                   │  │  • Select Pickup Date               │
│ • Create Planting    │                   │  │  • Confirm Order                    │
│ • Track Growth Stage │                   │  └─────────────────┬───────────────────┘
│   (Seedling →        │                   │                    │
│    Tillering →       │                   │                    ▼
│    Flowering →       │                   │  ┌─────────────────────────────────────┐
│    Grain Fill →      │                   │  │    Order Placed (Pending)           │
│    Maturity)         │                   │  │  • Await Farmer Confirmation        │
│ • Weather Analysis   │                   │  └─────────────────┬───────────────────┘
├──────────────────────┤                   │                    │
│ Nursery Management   │                   │                    ▼
│ • Seedling Batches   │                   │  ┌─────────────────────────────────────┐
│ • Transplant Ready   │                   │  │   [FARMER] Confirm Order            │
├──────────────────────┤                   │  │  • Accept / Reject                  │
│ Harvest Recording    │                   │  │  • Set Pickup Date                  │
│ • Log Yield (kg)     │◄──────────────────┘  └─────────────────┬───────────────────┘
│ • Quality Grade      │                                        │
│ • Harvester Share    │                                        ▼
└──────────────────────┘                      ┌─────────────────────────────────────┐
         │                                    │      Order Confirmed                │
         ▼                                    │  • Buyer Notified via Email         │
┌──────────────────────┐                      └─────────────────┬───────────────────┘
│   LABOR MANAGEMENT   │                                        │
├──────────────────────┤                                        ▼
│ Laborer Profiles     │                      ┌─────────────────────────────────────┐
│ • Add/Edit Laborers  │                      │   [FARMER] Prepare Order            │
│ • Set Pay Rates      │                      │  • Pack Products                    │
│ Task Assignment      │                      │  • Mark "Ready for Pickup"          │
│ • Create Tasks       │                      └─────────────────┬───────────────────┘
│ • Assign to Field    │                                        │
│ • Track Completion   │                                        ▼
│ Payment Types:       │                      ┌─────────────────────────────────────┐
│ • Daily Rate         │                      │      Buyer Pickup                   │
│ • Piece Rate         │                      │  • Pickup Deadline Reminder         │
│ • Pakyao (Contract)  │                      │  • Buyer Arrives at Farm            │
│ → Auto-Expense Gen   │                      │  • Complete Handover                │
└──────────────────────┘                      └─────────────────┬───────────────────┘
         │                                                      │
         ▼                                                      ▼
┌──────────────────────┐                      ┌─────────────────────────────────────┐
│ INVENTORY MANAGEMENT │                      │   [FARMER] Mark as Delivered        │
├──────────────────────┤                      │  • Record Payment (COD/Bank)        │
│ Stock Tracking       │                      │  • Auto-Generate Sale Record        │
│ • Seeds, Fertilizer  │                      └─────────────────┬───────────────────┘
│ • Pesticides, Tools  │                                        │
│ WAC Calculation      │                                        ▼
│ Low Stock Alerts     │                      ┌─────────────────────────────────────┐
│ Expiry Tracking      │                      │   [BUYER] Rate & Review             │
│ → Auto-Expense Gen   │                      │  • Leave Product Review             │
└──────────────────────┘                      │  • Rate Farmer (1-5 Stars)          │
         │                                    └─────────────────┬───────────────────┘
         ▼                                                      │
┌──────────────────────┐                                        │
│   MARKETPLACE SALES  │                                        │
├──────────────────────┤                                        │
│ Product Listing      │                                        │
│ • Link to Harvest    │                                        │
│ • Set Price & Grade  │                                        │
│ • Add Photos         │                                        │
│ • Publish to Market  │                                        │
│ Order Management     │◄───────────────────────────────────────┘
│ • View Incoming Ord  │
│ • Confirm/Reject     │
│ • Price Negotiation  │
│ • Mark Ready/Done    │
│ Direct Sales         │
│ • Record Off-Market  │
│ • Track Revenue      │
└──────────────────────┘
         │
         ▼
┌──────────────────────┐
│  FINANCIAL TRACKING  │
├──────────────────────┤
│ Expense Categories   │
│ • Labor, Inventory   │
│ • Equipment, Others  │
│ Revenue Tracking     │
│ • Marketplace Sales  │
│ • Direct Sales       │
│ Profit/Loss Reports  │
│ Financial Forecasts  │
└──────────────────────┘
         │
         ▼
┌──────────────────────┐
│  WEATHER & ANALYTICS │
├──────────────────────┤
│ Real-Time Weather    │
│ • Current Conditions │
│ • 10-Day Forecast    │
│ • GDD Calculation    │
│ Agronomic Alerts     │
│ • Heat/Cold Stress   │
│ • Disease Risk       │
│ • Irrigation Advice  │
│ Pest Prediction      │
│ • Rice Blast Risk    │
│ • Stem Borer Risk    │
└──────────────────────┘
         │
         ▼
┌──────────────────────┐
│   REPORTS & INSIGHTS │
├──────────────────────┤
│ Data Analytics       │
│ • Executive Summary  │
│ • Action Suggestions │
│ • Yield Predictions  │
│ Scheduled Reports    │
│ • Email Summaries    │
│ • PDF/CSV Export     │
└──────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                          LOGOUT / END                                                │
└─────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

**Description:**
This comprehensive User Flow Diagram illustrates the complete start-to-finish journey for all user types in the ANIBUKID system:

**Authentication & Onboarding:**
- Users begin at the landing page and can login, register, or browse as guests.
- Registration requires role selection (Farmer/Buyer) and email OTP verification.
- First-time farmers complete onboarding to create farm profiles and register fields with GPS coordinates.

**Farmer Journey:**
- **Farm Operations:** Manage fields, track planting lifecycle through 5 growth stages, and record harvests with quality grading.
- **Labor Management:** Assign tasks to laborers with multiple payment types (daily, piece, contract) with auto-expense generation.
- **Inventory:** Track seeds, fertilizers, pesticides with WAC calculation, low stock alerts, and expiry tracking.
- **Marketplace Sales:** List products linked to harvests, manage incoming orders, handle price negotiations, and process fulfillment.
- **Financial Tracking:** Automated expense generation, revenue tracking, and profit/loss analysis.
- **Weather & Analytics:** Real-time weather data, agronomic alerts, pest predictions, and actionable insights.

**Buyer Journey:**
- Browse marketplace with filters, add products to cart, and optionally negotiate prices.
- Place orders with pickup scheduling and track order status through confirmation → ready → delivered.
- Complete transactions with payment recording and leave product reviews.


---

## � System Context Diagram

```text
                                     +-------------+
                                     | Weather API |
                                     +-------------+
                                        ^       |
                           Request Data |       | Weather Data
                                        |       v
                    +-----------------------------------------+
                    |                                         |
   Manage Laborers  |                                         |  Order Products
   Crop Details     |       Farm Operations Management        |
     +--------+     |                 System                  |     +-------+
     |        |---->|                                         |<----|       |
     | Farmer |     |                                         |     | Buyer |
     |        |<----|                                         |---->|       |
     +--------+     |                                         |     +-------+
   Sales Reports    |                                         |  Track Order
   Laborer List     +-----------------------------------------+
                                         |
                                         | Activity Schedule
                                         | Payroll
                                         v
                                    +---------+
                                    | Laborer |
                                    +---------+
```

**Description:**
The System Context Diagram defines the **Farm Operations Management System** as the central entity and illustrates its interactions with external actors:
- **Farmer (Primary User):** Inputs farm data (labor, crops) and receives actionable reports (Sales, Weather).
- **Buyer (Secondary User):** Interacts with the marketplace to order products and track status.
- **Laborer (External Recipient):** Receives outputs such as activity schedules and payroll (managed by the Farmer).
- **Weather API (External System):** Provides real-time weather data which the system analyzes to generate agronomic alerts.

---

## 🏗️ Level 0 DFD (Fundamental System Diagram)

```text
                                  +-------------+
                                  | Weather API |
                                  +-------------+
                                         ^
                                         | 2.1 Weather Data
                                         v
+--------+  1.1 Farm Data        +---------------+          2.2 Alerts   +--------+
|        |---------------------->|      2.0      |---------------------->|        |
| Farmer |  1.2 Scheduling       |    Monitor    |                       | Farmer |
|        |<----------------------|    Weather    |---------------------->|        |
+---+----+  1.3 Pay Slips        +-------+-------+      2.3 Forecasts    +---+----+
    |                                    |                                   ^
    |                                    |                                   |
    |                                    v                                   |
    |                            [D2] Weather Logs                           |
    |                                                                        |
    |                                                                        |
    |    +---------------+                                  +---------------+|
    +--->|      1.0      |          1.4 Crop Status         |      4.0      ||
    |    |    Manage     |--------------------------------->|    Generate   ||
    +--->|  Operations   |------------------+               |    Reports    ||
    |    +-------+-------+   1.5 Expenses   |               +-------+-------+|
    |            |                          |                       ^        |
    |            v                          |                       |        |
    |     [D1] Farm DB (Fields/Labor)       v                       |        |
    |                                       |                       |        |
    |                                       v                       |        |
    v                            [D4] Financial DB <----------------+        |
+---------+                                 ^                                |
| Laborer |                                 |                                |
+---------+                                 | 3.4 Transaction Data           |
                                            |                                |
                                   +--------+--------+                       |
         3.1 Product Listing       |       3.0       |      4.1 Reports      |
    +----------------------------->|     Manage      |-----------------------+
    |                              |   Marketplace   |
+---+----+                         +--------+--------+
|        |                                  |
| Farmer |                                  v
|        |                          [D3] Marketplace DB
+--------+                                  ^
                                            |
                                            |
+-------+        3.2 Place Order            |
|       |-----------------------------------+
| Buyer |
|       |<----------------------------------+
+-------+        3.3 Order Status
```

**Description:**
The Level 0 DFD explodes the system into four major functional processes:
1.  **1.0 Manage Operations:** Handles core farming activities, labor scheduling, and crop tracking. Interacts with the `Farm DB`.
2.  **2.0 Monitor Weather:** Fetches external weather data, stores it in `Weather Logs`, and provides alerts to farmers.
3.  **3.0 Manage Marketplace:** Facilitates B2B transactions between Farmers and Buyers, storing data in `Marketplace DB`.
4.  **4.0 Generate Reports:** Aggregates financial and operational data to produce actionable insights for the Farmer.

---

## 👤 Farmer Use Case Diagram

```text
                        +---------------------------+
                        |   Farm Operations Mgmt    |
                        |                           |
        +-------------->|      Manage Plantings     | - - - +
        |               |                           |       | <<include>>
        |               +---------------------------+       v
        |               |                           |    ( Update Growth )
        +-------------->|     Manage Inventory      |    (     Stage     )
        |               |                           |
        |               +---------------------------+
        |               |                           |
        +-------------->|      Manage Laborers      |
        |               |                           |
        |               +---------------------------+
        |               |                           |       <<include>>
   +--------+           |      Record Harvest       | - - - - - - > ( Calculate Yield )
   | Farmer |---------->|                           |
   +--------+           +---------------------------+
        |               |                           |
        +-------------->|     Process Orders        | < - - - - - - ( Negotiate Price )
        |               |                           |   <<extend>>
        |               +---------------------------+
        |               |                           |
        +-------------->|      View Analytics       |
        |               |                           |
        |               +---------------------------+
        |               |                           |
        +-------------->|    Generate Reports       |
                        |                           |
                        +---------------------------+
```

---

## 🛒 Buyer Use Case Diagram

```text
                        +---------------------------+
                        |   Farm Operations Mgmt    |
                        |      (Marketplace)        |
        +-------------->|      Manage Profile       |
        |               |                           |
        |               +---------------------------+
        |               |                           |
        +-------------->|     Browse Products       | - - - +
        |               |                           |       | <<extend>>
        |               +---------------------------+       v
        |               |                           |    (  Filter by  )
   +-------+            |       Place Order         |    (   Location  )
   | Buyer |----------->|                           |
   +-------+            +-------------+-------------+
        |               |             |             |
        |               |             + - - - - - - - - - - > ( Process Payment )
        +-------------->|             |       <<include>>
        |               |    Track/Update Order     |
        |               |                           | < - - - ( Cancel Order )
        |               +---------------------------+  <<extend>>
        |               |                           |
        +-------------->|    View Order History     |
                        |                           |
                        +---------------------------+
```




---

## �📦 Module Overview

### 1. Farm & Field Management
- **Models:** `Farm`, `Field`, `Planting`, `PlantingStage`
- **Controllers:** `FarmController`, `FieldController`, `PlantingController`
- **Features:** GPS-based field registration, area calculation, crop rotation tracking.

### 2. Weather Analytics
- **Services:** `WeatherService`, `WeatherAnalyticsService`
- **Model:** `WeatherLog`
- **Features:**
  - Real-time weather fetching from Open-Meteo API
  - Growing Degree Days (GDD) calculation (Base: 10°C, Max: 30°C)
  - Agronomic threshold alerts (Heat Stress, Cold Stress, Drought, etc.)
  - Yield prediction using multi-factor analysis
  - **Data Accuracy & Configuration:**
    - **Primary Provider:** ColorfulClouds (Caiyun) for hyper-local, minute-by-minute precipitation forecasts.
    - **Backup Provider:** Open-Meteo, specifically configured to use the **NOAA GFS (Global Forecast System)** model for superior accuracy in the Bukidnon region (replacing the default model which overestimated temperatures).
    - **Smart Aggregation:** Daily summaries prioritize severe weather conditions (Storm > Rain > Cloudy) to ensure users don't miss critical alerts even if the day is mostly cloudy.
    - **Hourly Forecast:**
      - **Data Source:** Open-Meteo (GFS Model)
      - **Metrics:** Temperature, Weather Condition, and Rain Probability (%) for every hour of the 7-day forecast.
      - **Smart Logic:** If the precipitation probability exceeds 50%, the condition is explicitly forced to **"Rainy"** (overriding "Cloudy") to clearly communicate risk to the farmer.
      - **UI:** Accessible via a "View Hourly" modal for each day; fully responsive layout that adapts to mobile screens.

### 3. Intelligent Data Analytics
- **Controllers:** `DataAnalysisController`, `RiceFarmingAnalyticsController`
- **Features:**
  - **Comprehensive Dashboard:** Aggregates metrics from 8+ modules (Weather, Sales, Expenses, Fields, Nursery, Inventory, Pests, Labor).
  - **Intelligent Action Suggestions:** AI-driven recommendations based on data patterns (e.g., "Restock seeds" when low, "Apply treatment" when pests detected).
  - **Visualizations:** Interactive charts for revenue vs expenses, task distribution, and labor productivity.
  - **Trend Analysis:** Tracks historical performance and identifies anomalies.

#### 🧠 AI Inference Engine (Rule-Based)
The system uses a deterministic expert system to generate narrative insights without external API dependencies.

**Inference Logic (Executive Summary):**

| Category | Condition | Generated Narrative | Tone |
|----------|-----------|---------------------|------|
| **Financial** | Net Profit > 0 | "The farm is currently profitable with a net income of ₱[amount]." | Positive |
| | Expenses > 0 & Revenue = 0 | "The farm is in an investment phase with significant operational costs (₱[amount]) and no revenue yet..." | Neutral |
| | Net Profit < 0 | "The farm is operating at a deficit of ₱[amount]." | Concern |
| **Operations** | Overdue Tasks > 5 | "Operational bottlenecks are detected with [count] overdue tasks..." | Concern |
| | Completion Rate > 85% | "Operations are running smoothly with a high task completion rate of [rate]%." | Positive |
| | Completion Rate < 50% | "Labor efficiency requires attention as only [rate]% of assigned tasks are completed." | Caution |
| **Risks** | Active Pests > 0 | "Immediate attention is required for [count] active pest incidents..." | Concern |
| | Low Stock Items > 0 | "Supply chain risk is elevated with [count] items below minimum stock levels." | Neutral |

**Action Suggestions Logic:**

The system automatically generates prioritized suggestions based on specific triggers:

1.  **Low Inventory (`High Priority`)**
    *   *Trigger:* Current stock ≤ Minimum stock
    *   *Suggestion:* "Restock [Item] - only [Current] [Unit] remaining (below minimum of [Min])"

2.  **Overdue Tasks (`High/Medium Priority`)**
    *   *Trigger:* Task due date < Now AND status != completed
    *   *Suggestion:* "Complete overdue [Type] task for [Field] - [Days] days late"
    *   *Priority logic:* High if > 3 days overdue, otherwise Medium

3.  **Active Pest Incidents (`High/Medium Priority`)**
    *   *Trigger:* Active pest incident in planting
    *   *Suggestion:* "Apply treatment for [Pest] in [Field] - severity: [Severity]"
    *   *Priority logic:* High if severity is Critical/High

4.  **Pending Sales Orders (`High Priority`)**
    *   *Trigger:* Marketplace order with status 'pending'
    *   *Suggestion:* "Fulfill [Count] pending marketplace orders"

5.  **Harvest Readiness (`High Priority`)**
    *   *Trigger:* Planting stage is Maturity, Ripening, or Ready for Harvest
    *   *Suggestion:* "Schedule harvesting for [Field] - crop at [Stage] stage"

6.  **Weather Alerts (`Medium Priority`)**
    *   *Trigger (Rain):* Condition contains "rain" or "storm" -> "Delay pesticide/fertilizer application..."
    *   *Trigger (Heat):* Temperature > 35°C -> "High temperature alert - irrigate crops early morning or evening"

7.  **Nursery Operations (`Medium Priority`)**
    *   *Trigger:* Seedling batch status is 'ready'
    *   *Suggestion:* "Transplant [Variety] seedlings - [Count] batches ready"

8.  **Pickup Deadline Expiring (`High Priority`)**
    *   *Trigger:* Order status is `ready_for_pickup` AND pickup deadline is within 24 hours
    *   *Suggestion:* "Urgent: [Count] order(s) have pickup deadline expiring in 24 hours"
    *   *Research basis:* Based on industry standards (Target, Walmart use 1-day for fresh produce; 3-day policy for non-highly-perishable rice)

**Executive Summary Additions:**
- **Expired Pickup Orders:** If any orders were auto-cancelled this week due to expired pickup deadlines, this is included in the executive summary as a warning.

**Examples:**
> "The farm is currently profitable with a net income of ₱50,000. Operations are running smoothly with a high task completion rate of 92%."

> "The farm is operating at a deficit of ₱12,000. Operational bottlenecks are detected with 8 overdue tasks affecting overall efficiency. Immediate attention is required for 2 active pest incidents."

#### 📊 Advanced Analytics Features
- **Interactive Field Map (GIS):** Visualizes field status using geocoordinates. Color-coded markers indicate active fields (Green), idle lands (Gray), and pest risks (Red).
- **Pest & Disease Prediction:** Uses 7-day weather forecasts to predict risks for specific threats:
  - *Rice Blast* (High Humidity + Rain)
  - *Stem Borer* (High Temp)
  - *Brown Plant Hopper* (Warm + Humid)
- **Resource & Cost Efficiency:** Benchmarks water/fertilizer usage against yield ($/kg, $/ha) to score farm performance.
- **Financial Forecasting:** Projects cash flow for the next 6 months by analyzing active plantings (expected yield × market price) and historical expense patterns.


### 4. Inventory Management
- **Model:** `InventoryItem`, `InventoryTransaction`
- **Controller:** `InventoryItemController`
- **Features:**
  - **Weighted Average Cost (WAC):** Auto-recalculates unit price on restock
  - Low stock alerts and expiry tracking
  - Automatic expense creation on stock purchase
  - **Historical Usage Tracking:** Monitors consumption and restock patterns over time

### 5. Labor & Tasks
- **Models:** `Task`, `Laborer`, `LaborerGroup`, `LaborWage`
- **Controller:** `TaskController`
- **Features:**
  - Polymorphic payment types: `wage` (daily), `piece_rate`, `share`
  - Auto-expense generation on task completion
  - Laborer group assignment

### 6. Harvest & Sales
- **Models:** `Harvest`, `Sale`
- **Controller:** `HarvestController`, `SalesController`
- **Features:**
  - Yield recording, quality grading, harvester share calculation.
  - **Marketplace Integration:** Auto-creation of sales records upon order completion.
  - **Sales Tracking:** Unified view of marketplace and off-platform sales.

### 7. Marketplace
- **Models:** `RiceProduct`, `RiceOrder`, `CartItem`, `Favorite`, `ProductReview`, `PriceNegotiation`
- **Controllers:** `RiceProductController`, `RiceOrderController`, `CartController`
- **Features:**
  - **Guest Browsing:** Unauthenticated users can browse products and view details; login required for cart/favorites/orders
  - Product listing with quality grades and certifications
  - Price negotiation flow
  - Order state machine (Pending → Confirmed → Ready → Picked Up)
  - Pessimistic locking to prevent overselling

### 8. Financial Reporting
- **Models:** `Expense`, `Sale`
- **Services:** `FinancialService`
- **Features:** 
  - Income/expense tracking, profit/loss reports, crop profitability analysis.
  - **PDF/CSV Export:** Generate professional reports for records and analysis.
  - **Scheduled Reports:** Automated email summaries (Financial, Crop Yield).

---

## 🔐 Security Implementation

### Authentication
| Method | Implementation |
|--------|----------------|
| Token-based API Auth | **Laravel Sanctum** |
| Password Hashing | **Bcrypt/Argon2** (via `Hash::make`) |
| Verification Enforcement | **Strict Login Gate** (Email must be verified) |
| Two-Factor Verification | Email OTP |

### Authorization (RBAC)
```
┌────────────────────────────────────────────────────┐
│                   API Request                       │
│                        │                           │
│            ┌───────────┴───────────┐               │
│            ▼                       ▼               │
│   ┌────────────────┐      ┌────────────────┐       │
│   │ FarmerMiddleware│      │ BuyerMiddleware │       │
│   │ (isFarmer())   │      │ (canBuy())     │       │
│   └───────┬────────┘      └───────┬────────┘       │
│           │                        │               │
│     ┌─────┴─────┐           ┌──────┴─────┐         │
│     │  ALLOW    │           │   ALLOW    │         │
│     │  (200)    │           │   (200)    │         │
│     └───────────┘           └────────────┘         │
│                                                    │
│           │ Unauthorized                           │
│           ▼                                        │
│   ┌────────────────┐                               │
│   │  403 Forbidden │                               │
│   └────────────────┘                               │
└────────────────────────────────────────────────────┘
```

### Data Integrity
- **Input Validation:** Strict `FormRequest` classes for all endpoints.
- **SQL Injection Prevention:** Eloquent ORM with parameterized queries.
- **Transaction Safety:** `DB::transaction()` with `lockForUpdate()` for critical operations.

---

## ⚡ Caching Strategy

The system implements **Laravel Cache** to optimize performance and reduce database load on frequently accessed data.

### Cache Implementation

| Module | Cache Key Pattern | TTL | Description |
|--------|-------------------|-----|-------------|
| **Farmer Dashboard** | `farmer_dashboard_{user_id}` | 5 min | Stats, tasks, weather, marketplace data |
| **Buyer Dashboard** | `buyer_dashboard_{user_id}` | 10 min | Order stats, recent orders, products |
| **Marketplace** | `marketplace_stats` | 60 min | Product listings statistics and availability |
| **Farming Analytics** | `farming_analytics_{user_id}_{period}` | 24 hours | Yield analytics, financial trends (Heavy query) |
| **Weather Data** | `weather_current_{lat}_{lon}` | 30 min | Shared regional weather cache (deduplicated) |
| **Weather Forecast** | `weather_forecast_{lat}_{lon}` | 30 min | 5-14 day forecast data (Open-Meteo & ColorfulClouds) |

### Cache Invalidation
Caches are automatically invalidated when:
- User creates/updates a planting, harvest, or task
- Inventory stock changes
- Orders are placed or status changes
- Weather data is refreshed from API

### Configuration
```php
// Default cache driver (configured in .env)
CACHE_DRIVER=file  // Options: file, redis, memcached, database
```

---

## 🌤️ Weather & Analytics Engine

### Data Source Architecture (Hybrid Approach)
The system leverages a multi-provider strategy to balance accuracy and coverage:

| Provider | Max Forecast | Role | Usage |
|----------|--------------|------|-------|
| **Open-Meteo** | 14 days | **Current Weather** | Real-time conditions, historical logging, and forecast fallback. |
| **ColorfulClouds** | 10 days | **Main Forecasts** | Primary source for extended forecasts, preferred for its range and accuracy. |
| **OpenWeatherMap** | 5 days | **Agri-Insights** | Specialized data for crop protection, alerts, and detailed agricultural metrics. |

#### Forecast Request Flow
1. Client requests forecast (up to **14 days** supported)
2. `WeatherController` routes to `ColorfulCloudsWeatherService` (primary)
3. If ColorfulClouds fails → Falls back to `WeatherService` (Open-Meteo)
4. Response is cached for 30 minutes (service-level) and 3 hours (forecast-level)

#### Verified Capabilities
- ✅ **10-day forecasts** fully supported via ColorfulClouds
- ✅ **14-day forecasts** available via Open-Meteo fallback
- ✅ Date handling uses `Carbon` with `Asia/Manila` timezone for consistency
- ✅ All forecast dates are validated against "today" before response

### Threshold Alerts (Based on Agronomic Standards)

| Condition | Trigger | Alert Type | Recommendation |
|-----------|---------|------------|----------------|
| **Cold Stress** | Temp < 15°C | High | "Consider water management to maintain soil temperature." |
| **Heat Stress** | Temp > 35°C | High | "Ensure adequate water depth (5-10cm) to cool the crop." |
| **Critical (Flowering)** | Temp > 30°C | Critical | "Maintain 5-10cm water depth; early morning irrigation." |
| **Low Humidity (Flowering)** | Humidity < 60% | Medium | "Increase water depth to maintain field humidity." |
| **Disease Risk** | Humidity > 85% | Medium | "Monitor for disease; consider preventive fungicide." |
| **Wind Advisory** | Wind > 15 km/h | High | "Monitor for lodging; consider early harvest." |
| **Flooding** | Heavy Rain/Storm | Medium | "Ensure proper drainage; check bund integrity." |

### GDD Calculation
```php
$baseTemp = 10; // Minimum for rice growth
$maxTemp = 30;  // Growth plateaus above this

$effectiveTemp = min($currentTemp, $maxTemp);
$dailyGDD = max(0, $effectiveTemp - $baseTemp);
```

### Performance Optimization
To minimize external API reliance and costs, the system implements a multi-layered optimization strategy:
1. **Deduplication:** Coordinates are rounded to 2 decimal places (~1.1km) to group nearby fields.
2. **Database Caching:** Recent `WeatherLog` entries (< 30 mins) serve as the primary data source.
3. **Service Caching:** External API responses are cached in Redis/File for 30 minutes (Current) / 3 hours (Forecast).
4. **Batch Processing:** Fields are grouped by location for bulk weather updates.
5. **Client-Side Caching:** Frontend prevents redundant requests within a 10-minute window.

---


---

## 📊 Data Analytics Methodology

This section documents the analytical methodologies, algorithms, and academic foundations used in the system's data analysis features.

### 1. Growing Degree Days (GDD) Calculation

**Methodology:** Standard agrometeorological index for quantifying heat accumulation required for crop development.

**Formula:**
```
GDD = Σ max(0, T_eff - T_base)

Where:
• T_eff = min(T_actual, 30°C)   [Capped effective temperature]
• T_base = 10°C                  [Base temperature for rice]
```

**Implementation:** [`WeatherService.php`](app/Services/WeatherService.php#L677-L691)

**Scientific Basis:** Rice varieties typically have a base temperature between 6-10°C, with 10°C used as a standard threshold below which rice growth effectively stops.

**Scientific Alignment:** This implementation directly adapts the location-specific GDD models for Laguna rice varieties as proposed by Poral et al. (2020), ensuring localized accuracy.

**Citations:**
- Poral, P. A. P., Angcao, J. L., Cuaresma, D. C. N., Dazo, N. A., & Rivera, V. J. B. (2020). Modeling the daily average temperature and designing a growing degree day (GDD) European put option for rice in Laguna. *Journal of Nature Studies*, 19(2), 52-61.
- Hayashi, K., Llorca, L. P., Bugayong, I. D., Agustiani, N., & Capistrano, A. O. V. (2021). Evaluating the predictive accuracy of the weather-rice-nutrient integrated decision support system (WeRise) to improve rainfed rice productivity in Southeast Asia. *Agriculture*, 11(4), 346.

---

### 2. Weather-Based Yield Prediction Model

**Methodology:** Multi-Factor Weighted Index Model combining weather factors with empirically derived weights.

**Formula:**
```
Predicted Yield = Base_Yield × (F_temp × F_rain × F_humidity × F_stress × F_growth)

Where:
• Base_Yield = 4,500 kg/ha      (Philippine irrigated rice average)
• F_temp     = Temperature factor      (0-30% impact)
• F_rain     = Rainfall adequacy       (0-25% impact)
• F_humidity = Humidity optimization   (0-15% impact)
• F_stress   = Stress events penalty   (0-20% negative impact)
• F_growth   = Growth stage alignment  (0-10% impact)
```

**Factor Details:**

| Factor | Optimal Range | Weight |
|--------|---------------|--------|
| Temperature | 22-28°C | 30% |
| Rainfall | 1,000mm/season | 25% |
| Humidity | 65-80% | 15% |
| Stress Days | 0 days | 20% |
| Growth Alignment | Stage-appropriate | 10% |

**Implementation:** [`WeatherAnalyticsService.php`](app/Services/WeatherAnalyticsService.php#L849-L913)

**Scientific Alignment:** The weighting system is informed by Baltazar's (2024) findings on climate impact scenarios in Central Luzon, prioritizing temperature and rainfall as primary yield determinants.

**Citations:**
- Baltazar, R. G. (2024). Forecasting the impact of climate change on rice crop yields under RCP4.5 and RCP8.5 scenarios in Central Luzon, Philippines, using machine learning algorithms. *Ciencia e Investigación Agraria*, 51(1), 10-26.
- Hayashi, K., et al. (2021). Evaluating the predictive accuracy of the weather-rice-nutrient integrated decision support system (WeRise). *Agriculture*, 11(4), 346.

---

### 3. Pest and Disease Risk Prediction

**Methodology:** Rule-Based Expert System derived from epidemiological research on rice pests and diseases.

**Risk Prediction Rules:**

| Pest/Disease | Trigger Conditions | Risk Level |
|--------------|-------------------|------------|
| **Rice Blast** | Humidity ≥85%, Temp 20-30°C, Rain probability >50% | High |
| **Stem Borer** | Temperature >28°C | Moderate |
| **Brown Plant Hopper** | Humidity >80%, Temp >25°C | Moderate-High |
| **Bacterial Leaf Blight** | Stormy/Rainy + Temp >25°C | Moderate |

**Implementation:** [`PestPredictionService.php`](app/Services/PestPredictionService.php#L63-L124)

**Scientific Basis:** Rice blast (*Magnaporthe oryzae*) development correlates strongly with relative humidity ≥95% and temperatures of 26-27°C.

**Scientific Alignment:** Logic thresholds for Rice Black Bug and Stemborer risk are calibrated based on the percentile-based outbreak models established by Balleras et al. (2025).

**Citations:**
- Balleras, G. D., Abdula, S. E., Flores, C. G., & Deleña, R. D. (2025). Percentile-based outbreak thresholding for machine learning-driven pest forecasting in rice (*Oryza sativa* L.) farming: A case study on rice black bug and white stemborer. *Sustainability*, 18(1), 182.
- Katsantonis, D., et al. (2017). Rice blast forecasting models and their practical value. *Phytopathologia Mediterranea*, 56(2), 187-216.

---

### 4. Stress Event Detection

**Methodology:** Threshold-based temporal analysis for identifying weather-related crop stress periods.

**Stress Thresholds:**

| Stress Type | Condition | Severity Classification |
|-------------|-----------|------------------------|
| **Heat Stress** | Temp >35°C | Severe (>38°C), Moderate (>36°C), Mild |
| **Cold Stress** | Temp <15°C | Severe (<10°C), Moderate (<12°C), Mild |
| **Drought Stress** | Humidity <40% for ≥3 days | Severity by duration |
| **Flooding Stress** | Rainfall >50mm/day | Severe (>100mm), Moderate (>75mm) |

**Implementation:** [`WeatherAnalyticsService.php`](app/Services/WeatherAnalyticsService.php#L1140-L1239)

**Scientific Alignment:** Stress thresholds (e.g., >35°C for heat) are consistent with the physiological limits reviewed by Mthiyane et al. (2024) and the drought impact assessments by Ortega-Espaldon & Medina (2024).

**Citations:**
- Mthiyane, P., Aycan, M., & Mitsui, T. (2024). Strategic advancements in rice cultivation: Combating heat stress through genetic innovation and sustainable practices—A review. *Stresses*, 4(3), 452–480.
- Ortega-Espaldon, M. V., & Medina, C. D. (2024). Climate change and food security in the Philippines: Impacts, adaptation, and climate change action. In *Climate Emergency in the Philippines* (pp. 97–118). Springer Nature.

---

### 5. Weather Suitability Scoring

**Methodology:** Composite scoring system (0-100) using weighted factors.

**Formula:**
```
Score = (Temp_Score × 0.40) + (Humidity_Score × 0.30) + 
        (Conditions_Score × 0.20) + (Wind_Score × 0.10)
```

| Component | Weight | Optimal Range |
|-----------|--------|---------------|
| Temperature | 40% | 20-30°C |
| Humidity | 30% | 60-80% |
| Conditions | 20% | Clear/Cloudy |
| Wind | 10% | ≤15 km/h |

**Implementation:** [`WeatherService.php`](app/Services/WeatherService.php#L707-L735)

**Scientific Alignment:** The component scoring parallels the approach of the WeRise system (Hayashi et al., 2021), focusing on integrating weather and nutrient decision support.

**Citations:**
- Hayashi, K., Llorca, L. P., Bugayong, I. D., Agustiani, N., & Capistrano, A. O. V. (2021). Evaluating the predictive accuracy of the weather-rice-nutrient integrated decision support system (WeRise) to improve rainfed rice productivity in Southeast Asia. *Agriculture*, 11(4), 346.

---

### 6. Growth Stage Analytics

**Methodology:** Comprehensive analysis combining environmental suitability with operational performance metrics across the crop lifecycle.

#### A. Weather Suitability Analysis
**Approach:** Stage-specific environmental assessment applying different optimal ranges per growth phase.

**Stage-Specific Optimal Ranges:**

| Growth Stage | Days from Planting | Optimal Temp (°C) | Optimal Humidity (%) |
|--------------|-------------------|-------------------|---------------------|
| Seedling | 0-15 | 20-30 | 70-90 |
| Tillering | 15-60 | 25-32 | 70-85 |
| Flowering | 60-90 | 25-30 | 70-80 |
| Grain Filling | 90-120 | 20-28 | 60-75 |
| Ripening | 120+ | 20-28 | 50-70 |

#### B. Operational Performance Metrics
**Approach:** Quantitative tracking of stage completion success and timeline adherence.

**Metrics:**
1.  **Stage Success Rate:** Percentage of growth stages successfully transitioned vs. total attempts.
    *   *Significance:* Identifies bottleneck stages where crop failure frequently occurs.
2.  **Completion Efficiency:** Ratio of actual stage duration vs. biological standards.
    *   *Formula:* `(Completed_On_Time_Stages / Total_Stages) * 100`

**Implementation:** [`RiceFarmingAnalyticsController.php`](app/Http/Controllers/RiceFarmingAnalyticsController.php) & [`WeatherAnalyticsService.php`](app/Services/WeatherAnalyticsService.php)

**Scientific Alignment:** Phenological stage adjustments reflect the critical heat-sensitive periods (flowering/filling) highlighted in studies by Mthiyane et al. (2024) and Baltazar (2024).

**Citations:**
- Mthiyane, P., Aycan, M., & Mitsui, T. (2024). Strategic advancements in rice cultivation: Combating heat stress through genetic innovation and sustainable practices—A review. *Stresses*, 4(3), 452–480.
- Baltazar, R. G. (2024). Forecasting the impact of climate change on rice crop yields under RCP4.5 and RCP8.5 scenarios in Central Luzon. *Ciencia e Investigación Agraria*, 51(1), 10-26.

---

### 7. Financial Cash Flow Forecasting

**Methodology:** 6-Month projection using historical averaging for expenses and yield-based revenue prediction.

**Formulas:**
```
Projected Revenue = Area_planted × Expected_Yield × Market_Price
Monthly Projected Expense = Average(Past 3 Months Expenses)
Net Cash Flow = Projected Revenue - Projected Expenses
```

**Implementation:** [`DataAnalysisController.php`](app/Http/Controllers/Analytics/DataAnalysisController.php#L707-L776)

**Scientific Alignment:** The projection model aligns with the cost-return frameworks analyzed by Briones (2024) to evaluate RCEF impacts on farmer income stability.

**Citations:**
- Briones, R. M. (2024). *An empirical evaluation of the Rice Competitiveness Enhancement Fund (RCEF) on the Philippine rice industry* (Policy Brief No. 2024-05). Philippine Institute for Development Studies.
- Lim, C. T. N. (2023). Empirical analysis of rice prices, production, and consumption in the Philippines. *Review of Integrative Business and Economics Research*, 12(4), 45-62.

---

### 8. Crop Profitability Analysis

**Methodology:** Standard agricultural economics formulas for enterprise analysis.

**Metrics:**

| Metric | Formula |
|--------|---------|
| **Net Profit** | Revenue - (Expenses + Labor Costs) |
| **Profit Margin** | (Net Profit / Revenue) × 100 |
| **ROI** | (Net Profit / Total Costs) × 100 |
| **Cost per Hectare** | Total Costs / Total Area |
| **Revenue per Hectare** | Total Revenue / Total Area |

**Implementation:** [`FinancialService.php`](app/Services/FinancialService.php#L256-L323)

**Scientific Alignment:** Profitability metrics are standardized to facilitate comparison with regional self-sufficiency benchmarks as discussed by Lim (2023).

**Citations:**
- Lim, C. T. N. (2023). Empirical analysis of rice prices, production, and consumption in the Philippines: Implications for self-sufficiency policy. *Review of Integrative Business and Economics Research*, 12(4), 45-62.
- World Bank & FAO. *Smallholder Farm Financial Analysis Principles*.

---

### 9. Resource Efficiency Analysis
**Methodology:** Input-Output ratio analysis normalized against industry benchmarks.

**Metrics:**
- **Water Efficiency:** Yield (kg) / Water Expenses (₱)
- **Fertilizer Efficiency:** Yield (kg) / Fertilizer Expenses (₱)
- **Labor Efficiency:** Yield (kg) / Labor Expenses (₱)

**Scoring:**
Raw ratios are normalized to a 0-100 scale using configurable benchmarks (e.g., 0.15 kg/₱ for fertilizer).

**Implementation:** [`RiceFarmingAnalyticsController.php`](app/Http/Controllers/RiceFarmingAnalyticsController.php#L348-L386)

**Scientific Alignment:** Efficiency scoring logic is derived from the latest benchmarks for Nitrogen and Water Use Efficiency in Asian aerobic rice production (Nagangoudar et al., 2025).

**Citations:**
- Nagangoudar, M. B., et al. (2025). Impact of water and nitrogen management strategies on productivity, resource use efficiency, and greenhouse gases emission in aerobic rice. *Environmental and Sustainability Indicators*, 27, 100750.
- Dobermann, A. (2007). *Nutrient use efficiency – measurement and management*. International Rice Research Institute (IRRI). establishes PFP Target > 40 kg grain/kg N.

---

### 10. Cost Efficiency Benchmarking
**Methodology:** Comparative analysis of production costs against national averages and target metrics.

**Key Indicators:**
1.  **Cost per Kg:** Total Expenses / Total Yield (Target: < ₱12.00/kg)
2.  **Cost per Hectare:** Total Expenses / Area Planted (Target: < ₱50,000/ha)

**Formula:**
```
Efficiency Score = (Weight_kg * (1 - Cost_kg/Target_kg)) + 
                  (Weight_ha * (1 - Cost_ha/Target_ha))
```

**Implementation:** [`RiceFarmingAnalyticsController.php`](app/Http/Controllers/RiceFarmingAnalyticsController.php#L555-L605)

**Scientific Alignment:** Evaluation criteria are consistent with the competitiveness parameters set forth by the Philippine Institute for Development Studies (Briones, 2024) for assessing rice farming viability.

**Citations:**
- Briones, R. M. (2024). *An empirical evaluation of the Rice Competitiveness Enhancement Fund (RCEF) on the Philippine rice industry* (Policy Brief No. 2024-05). Philippine Institute for Development Studies.
- Lim, C. T. N. (2023). Empirical analysis of rice prices, production, and consumption in the Philippines. *Review of Integrative Business and Economics Research*, 12(4), 45-62.

---

### 11. Seasonal Pattern Recognition
**Methodology:** Time-series segmentation comparing agricultural performance across distinct climatic seasons.

**Seasons Defined:**
- **Wet Season:** May to October
- **Dry Season:** November to April

**Analysis:**
Computes average yield and planting density per season to identify the "Preferred Season" for specific crop varieties.

**Implementation:** [`RiceFarmingAnalyticsController.php`](app/Http/Controllers/RiceFarmingAnalyticsController.php#L618-L639)

**Scientific Alignment:** Seasonal adjustments account for the climate variability and adaptation strategies recommended by Ortega-Espaldon & Medina (2024) for Philippine food security.

**Citations:**
- Ortega-Espaldon, M. V., & Medina, C. D. (2024). Climate change and food security in the Philippines: Impacts, adaptation, and climate change action. In *Climate Emergency in the Philippines* (pp. 97–118). Springer Nature.

---

### 12. Yield Gap Analysis (Gap II)

**Methodology:** Comparative analysis between Potential Yield (Variety-specific genetic potential) and Actual Farm Yield to identify "exploitable" yield gaps caused by management constraints.

**Formula:**
```
Yield Gap = Potential Yield (Y_p) - Actual Yield (Y_a)
Gap % = ((Y_p - Y_a) / Y_p) × 100
```
*Gap II (Management Gap):* The difference between attainable water-limited potential yield and actual farm yield.

**Implementation:** [`RiceProductionAnalyticsService.php`](app/Services/Analytics/RiceProductionAnalyticsService.php)

**Scientific Basis:** Focuses on closing "Gap II" which is addressable through improved nutrient, water, and pest management, distinct from "Gap I" (Environmental/Genetic limits).

**Citations:**
- FAO (2020). *Yield gap analysis of field crops: Methods and case studies*. FAO Water Reports No. 41.
- Global Yield Gap Atlas (GYGA). *Standard protocols for determining potential vs. actual yield*.

---


### Methodological Summary

| Analytics Component | Approach Type |
|--------------------|---------------|
| GDD Calculation | **Established** (Standard agrometeorological formula) |
| Yield Prediction | **Heuristic** (Multi-factor weighted index) |
| Pest/Disease Risk | **Knowledge-based** (Rule-based expert system) |
| Stress Detection | **Deterministic** (Threshold-based analysis) |
| Weather Suitability | **Heuristic** (Weighted composite scoring) |
| Growth Stage Analysis | **Research-based** (Stage-specific optimal ranges) |
| Financial Forecasting | **Standard practice** (Historical averaging + projections) |
| Profitability Analysis | **Established** (Standard financial metrics) |
| Resource Efficiency | **Benchmarking** (Input-Output ratio vs Standards) |
| Cost Efficiency | **Benchmarking** (Comparative analysis) |
| Seasonal Patterns | **Descriptive** (Time-series segmentation) |

---

## ✅ Functional Requirements

### 1. Farm Management
- **Farmers** can create, update, and delete farm plans (fields, plantings).
- The system tracks farm activities: planting, harvesting, labor assignments, and inventory use.
- Farmers can log and view resource usage (seeds, fertilizer, labor wages).

### 2. Weather Analytics
- The system fetches real-time weather data via **Open-Meteo API**.
- Weather forecasts (5-day) are displayed and updated.
- System provides **Agronomic Alerts** (Heat Stress, High Humidity) to support decisions.

### 3. Marketplace
- **Buyers** can register, browse products, and place orders.
- **Farmers** can post rice products with pricing, quality, and grading details.
- System supports **Order Messaging** between buyers and farmers within order context.
- **Payment Handling**: The system tracks payment status but does *not* process online payments automatically; transactions are confirmed manually (COD/Bank Transfer).

### 4. User Management
- Users register as either **Farmer** or **Buyer**.
- Authentication requires **Email Verification** and password login.
- Users can manage their profiles (bio, contact info).
- *Note: No manual Administrator approval is required for registration; email verification is the primary gatekeeper.*

### 5. Dashboard & Analytics
- Visual summaries of farm activities, weather history, and yield data.
- Farmers can track sales, expenses, and profit/loss reports.
- Data export options (PDF/CSV) are available for inventory and sales.

## ⚡ Non-Functional Requirements

### 1. Performance
- Weather data should be cached to minimize API calls (Refreshes every **30 minutes**).
- Dashboard and charts should load efficiently using optimized database queries.

### 2. Scalability
- The system supports multiple concurrent users (Farmers and Buyers).
- Database design allows for growth in historical weather logs and transaction records.

### 3. Usability
- Interface is responsive (Mobile/Desktop friendly) using **Vue.js** & **Tailwind CSS**.
- Navigation is role-based (Farmer Dashboard vs. Marketplace).

### 4. Reliability
- External APIs (Weather) have error handling and fallback mechanisms.
- System maintains data integrity for financial records (Sales/Expenses).

### 5. Security
- Use of **Laravel Sanctum** for secure API authentication.
- Password hashing (BCrypt) and email verification are mandatory.
- Role-Based Access Control (RBAC) ensures Buyers cannot access Farmer data.

---



## 🤖 Automation & Scheduled Jobs

The system relies on Laravel Scheduler to perform background maintenance and notifications.

| Command | Schedule | Purpose |
|---------|----------|---------|
| `inventory:check-expiry` | Daily (8:00 AM) | Checks for expiring items and notifies farmers. |
| `reports:send-scheduled` | Hourly | Checks for due scheduled reports and emails them. |
| `pre-orders:send-notifications` | Daily (9:00 AM) | Sends emails for production availability and pickup reminders. |
| `orders:send-deadline-warnings` | Daily (8:00 AM) | Sends email to farmers about orders expiring in 24 hours. |
| `orders:cancel-expired-pickups` | Hourly | Cancels orders past deadline, restores inventory, notifies buyer+farmer. |
| `weather:monitor` | Hourly | Monitors fields for critical weather conditions and triggers Email/Push alerts. |

---

## ⚙️ Installation & Setup

### Prerequisites
- PHP 8.2+
- Composer 2.x
- Node.js 18+ / npm
- PostgreSQL 14.0+

### Steps

```bash
# 1. Clone the repository
git clone <repository-url>
cd farm_operation_management

# 2. Install PHP dependencies
composer install

# 3. Install Node dependencies
npm install

# 4. Environment setup
cp .env.example .env
php artisan key:generate

# 5. Configure database in .env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=farm_management
DB_USERNAME=postgres
DB_PASSWORD=your_password

# 6. Run migrations and seeders
php artisan migrate --seed

# 7. Start development servers
composer run dev
# This runs: php artisan serve & npm run dev (concurrently)
```

---

## 🔌 API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/register` | User registration |
| POST | `/api/login` | User login (returns Sanctum token) |
| POST | `/api/logout` | Revoke token |

### Farmer Routes (Protected: `auth:sanctum`, `farmer`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/farmer/profile` | Get farmer profile |
| GET | `/api/fields` | List fields |
| POST | `/api/fields` | Create field |
| GET | `/api/plantings` | List plantings |
| POST | `/api/plantings` | Create planting |
| GET | `/api/harvests` | List harvests |
| POST | `/api/harvests` | Record harvest |
| GET | `/api/inventory` | List inventory items |
| POST | `/api/inventory` | Add inventory item |
| GET | `/api/tasks` | List tasks |
| POST | `/api/tasks` | Create task |
| POST | `/api/tasks/{id}/complete` | Mark task complete |

### Marketplace Routes

#### Public Routes (No Auth Required - Guest Browsing)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/rice-marketplace/products` | List available products |
| GET | `/api/rice-marketplace/products/{id}` | View product details |
| GET | `/api/rice-marketplace/products/{id}/reviews` | View product reviews |
| GET | `/api/rice-marketplace/stats` | Marketplace statistics |

#### Protected Routes (Requires: `auth:sanctum`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/rice-marketplace/products` | Create product (Farmer only) |
| GET | `/api/rice-marketplace/cart` | View cart |
| POST | `/api/rice-marketplace/cart` | Add item to cart |
| POST | `/api/rice-marketplace/cart/checkout` | Place order |
| GET | `/api/rice-marketplace/orders` | List orders (Buyer/Farmer) |
| POST | `/api/rice-marketplace/orders/{id}/accept` | Accept order (Farmer) |
| POST | `/api/rice-marketplace/orders/{id}/ready-for-pickup` | Mark ready (Farmer) |

---

## 🧪 Testing

```bash
# Run all tests
php artisan test

# Run specific test suite
php artisan test --filter=InventoryTest
php artisan test --filter=OrderNegotiationTest
php artisan test --filter=HarvestTest
```

### Test Coverage Areas
- **AuthTest:** Registration, login, 2FA verification
- **InventoryTest:** WAC calculation, stock management
- **HarvestTest:** Yield recording, share calculation
- **OrderNegotiationTest:** Price negotiation flow
- **SystemSimulationTest:** End-to-end farmer/buyer lifecycle

---


---

## 🧪 Testing Methodology

### Unit Testing
Unit testing verified the smallest units of code in isolation. Laravel's built-in **PHPUnit** support was used to write automated unit tests for services and helper methods, ensuring that each component met its specification. Best practices included writing clear, focused tests to catch bugs early.

*   **Tools Used:** `phpunit/phpunit`, `mockery/mockery`
*   **Scope:** Tests one small piece of code (usually a function or class method) in isolation.
*   **Automation:** Integrated into the development workflow to ensure stability before deployment.

### Feature Testing
Feature (or integration) testing evaluates how features and components work together. In Laravel, "feature tests" simulate HTTP requests or user actions across the stack (e.g., controller logic, middleware, database) to validate end-to-end behavior.

*   **Tools Used:** **Laravel Testing Framework**, **PHPUnit**
*   **Scope:** Verifies that multiple modules/features work together correctly.
*   **Coverage:**

    *   **User Flows:** `AuthTest`, `SystemSimulationTest`
    *   **Core Operations:** `HarvestTest`, `SeedPlantingTest`, `OrderNegotiationTest`
    *   **Analytics:** `DataAnalysisTest`, `WeatherReportTest`
    *   **Security:** `SecurityMiddlewareTest` (RBAC verification)

### Static Analysis
To ensure type safety and code quality beyond standard linting, static analysis was employed.

*   **Tool Used:** **Larastan** (`larastan/larastan`)
*   **Purpose:** Catches distinct classes of bugs (like type errors) before code is even run, enhancing maintainability.

---

## 🛠️ Technical Architecture & Stack

This system is built using a modern, scalable tech stack designed for reliability and ease of deployment.

### 1. Conceptual Architecture
The application follows a **Monolithic Architecture** with a clear separation of concerns:
- **Presentation Layer:** Vue.js (SPA) managing user interactions.
- **Application Layer:** Laravel handling business logic, API routes, and job scheduling.
- **Data Layer:** PostgreSQL for persistent storage.
- **Service Layer:** Dedicated services for Weather, Recommendations, and Market logic.

### 2. Technology Stack

| Component | Technology | Description |
|-----------|------------|-------------|
| **IDE** | **Visual Studio Code** | Primary development environment with extensions for Laravel and Vue. |
| **Backend** | **Laravel 12 (PHP 8.2)** | Handles API, Authentication (Sanctum), and Business Logic. |
| **Frontend** | **Vue.js 3** | Reactive UI framework for a dynamic Single Page Application (SPA). |
| **Styling** | **Tailwind CSS 4.0** | Utility-first CSS framework for responsive design. |
| **State Mgmt** | **Pinia** | Store library for managing application state (User, Cart, Farm). |
| **Database** | **PostgreSQL 15** | Primary relational database for data integrity. Hosted on **Railway**. |
| **Visualization** | **Chart.js** | Renders interactive analytics graphs for farmers. |
| **DevOps** | **Docker** | Containerization for consistent local development and deployment. |
| **Deployment** | **Railway** | Cloud platform hosting both the Web Service and Database. |
| **Caching** | **Laravel Cache** | Integrated caching (File/Database) for Weather API responses. |
| **Testing** | **PHPUnit / Larastan** | Automated creation testing and Static Analysis. |

### 3. Hybrid Weather Architecture
To ensure agricultural accuracy and system resilience, the system employs a **Multi-Provider Strategy**:
- **Primary Provider:** **Colorful Clouds API**
    - Used for hyper-local, 14-day forecasts.
    - specialized in Asian/Pacific weather patterns.
- **Fallback Provider:** **Open-Meteo** & **OpenWeather**
    - Automatically engaged if the primary provider fails.
    - Provides standard meteorological data and current condition checks.
- **Result:** High availability and data accuracy for critical farming decisions.

### 4. Security & Infrastructure
- **Authentication:** **Laravel Sanctum** provides secure token-based authentication for the SPA and mobile access.
- **Tunneling:** **Ngrok** is used for exposing local development environments for mobile testing.
- **Version Control:** **GitHub** manages source code, issue tracking, and collaboration.

---


## 📄 License
This project is developed as a capstone project for academic purposes.

---

## 👥 Contributors
- **Capstone Team** - Yohan Lukin Callanta, Cydiemar Lagrosas, Renelle Janos Panague
- **Advisor** - Glyrhiz Marhiel Tabamo

---

<p align="center">
  <sub>Built with ❤️ for the farmers of Bukidnon</sub>
</p>
