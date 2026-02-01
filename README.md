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
| **Data Storage** | 32 database models covering farms, weather, labor, inventory, financial, marketplace, pest management |
| **Analytics Engine** | 8+ module aggregation, executive summary generation, action suggestions, financial forecasting |
| **Reporting** | Crop yield reports, financial reports, profit/loss analysis, weather impact reports |

**Key Files:** [`DataAnalysisController`](app/Http/Controllers/Analytics/DataAnalysisController.php), [`FinancialService`](app/Services/FinancialService.php), [`ReportController`](app/Http/Controllers/Reports/ReportController.php)

---

### Objective D: Farmer-to-Buyer Marketplace

| Category | Features Implemented |
|----------|---------------------|
| **Marketplace Core** | Product listings with filters, product details with reviews, buyer registration |
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

## 📦 Module Overview
GEMINI_API_KEY=AIzaSyAza1nNzvd2P47

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

### 3. Intelligent Data Analytics
- **Controller:** `DataAnalysisController`
- **Features:**
  - **Comprehensive Dashboard:** Aggregates metrics from 8+ modules (Weather, Sales, Expenses, Fields, Nursery, Inventory, Pests, Labor).
  - **Intelligent Action Suggestions:** AI-driven recommendations based on data patterns (e.g., "Restock seeds" when low, "Apply treatment" when pests detected).
  - **Visualizations:** Interactive charts for revenue vs expenses, task distribution, and labor productivity.
  - **Trend Analysis:** Tracks historical performance and identifies anomalies.

#### 🧠 AI Inference Engine (Rule-Based)
The system uses a deterministic expert system to generate narrative insights without external API dependencies.

**Inference Logic:**
1.  **Financial Health:**
    - *Profit > 0* → "Profitable" (Positive Tone)
    - *Loss* → "Operating at a deficit" (Concern Tone)
    - *High Expense/No Revenue* → "Investment Phase" (Neutral Tone)
2.  **Operational Efficiency:**
    - *Task Completion > 85%* → "Smooth Operations"
    - *Overdue Tasks > 5* → "Operational Bottlenecks"
3.  **Risk Assessment:**
    - *Active Pests* → "Immediate Attention Required"
    - *Low Stock* → "Supply Chain Risk"

**Examples:**
> "The farm is currently profitable with a net income of ₱50,000. Operations are running smoothly with a high task completion rate of 92%."

> "The farm is operating at a deficit of ₱12,000. Operational bottlenecks are detected with 8 overdue tasks affecting overall efficiency. Immediate attention is required for 2 active pest incidents."

#### 📊 Advanced Analytics Features
- **Interactive Field Map (GIS):** Visualizes field status using geocoordinates. Color-coded markers indicate active fields (Green), idle lands (Gray), and pest risks (Red).
- **Pest & Disease Prediction:** Uses 7-day weather forecasts to predict risks for specific threats:
  - *Rice Blast* (High Humidity + Rain)
  - *Stem Borer* (High Temp)
  - *Brown Plant Hopper* (Warm + Humid)
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
- **Models:** `RiceProduct`, `RiceOrder`, `Cart`, `CartItem`
- **Controllers:** `RiceProductController`, `RiceOrderController`, `CartController`
- **Features:**
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
| **Marketplace** | `marketplace_products` | 5 min | Product listings and availability |
| **Weather Analytics** | `weather_analytics_{field_id}` | 15 min | GDD, stress analysis, recommendations |
| **Weather Data** | `weather_current_{lat}_{lon}` | 30 min | Shared regional weather cache (deduplicated) |
| **Weather Forecast** | `weather_forecast_{lat}_{lon}` | 3 hours | 5-day forecast data (deduplicated) |

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

**Citations:**
- McMaster, G. S., & Wilhelm, W. W. (1997). Growing degree-days: one equation, two interpretations. *Agricultural and Forest Meteorology*, 87(4), 291-300.
- Yoshida, S. (1981). *Fundamentals of Rice Crop Science*. IRRI.

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

**Citations:**
- Agrawal, R., & Mehta, S. C. (2007). Weather Based Forecasting of Crop Yields. *IASRI Models*.
- Peng, S., et al. (2004). Rice yields decline with higher night temperature from global warming. *PNAS*, 101(27), 9971-9975.

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

**Citations:**
- Katsantonis, D., et al. (2017). Rice blast forecasting models and their practical value. *Phytopathologia Mediterranea*, 56(2), 187-216.
- IRRI. (2013). *Rice Knowledge Bank: Pest and Disease Management*.

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

**Citations:**
- Jagadish, S. V. K., et al. (2007). High temperature stress and spikelet fertility in rice. *Journal of Experimental Botany*, 58(7), 1627-1635.
- Wassmann, R., et al. (2009). Regional vulnerability of climate change impacts on Asian rice production. *Advances in Agronomy*, 102, 91-133.

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

**Citations:**
- Yoshida, S., & Parao, F. T. (1976). Climatic influence on yield and yield components of lowland rice in the tropics. *Climate and Rice*, 471-494.

---

### 6. Growth Stage Weather Analysis

**Methodology:** Stage-specific suitability analysis applying different optimal ranges per growth phase.

**Stage-Specific Optimal Ranges:**

| Growth Stage | Days from Planting | Optimal Temp (°C) | Optimal Humidity (%) |
|--------------|-------------------|-------------------|---------------------|
| Seedling | 0-15 | 20-30 | 70-90 |
| Tillering | 15-60 | 25-32 | 70-85 |
| Flowering | 60-90 | 25-30 | 70-80 |
| Grain Filling | 90-120 | 20-28 | 60-75 |
| Ripening | 120+ | 20-28 | 50-70 |

**Implementation:** [`WeatherAnalyticsService.php`](app/Services/WeatherAnalyticsService.php#L1025-L1130)

**Citations:**
- Krishnan, P., et al. (2011). High-temperature effects on rice growth, yield, and grain quality. *Advances in Agronomy*, 111, 87-206.
- Fageria, N. K. (2007). Yield Physiology of Rice. *Journal of Plant Nutrition*, 30(6), 843-879.

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

**Citations:**
- Kay, R. D., Edwards, W. M., & Duffy, P. A. (2019). *Farm Management* (8th ed.). McGraw-Hill.
- University of Wisconsin Extension. (2024). *Cash Flow: Importance and Creation*.

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

**Citations:**
- Barry, P. J., et al. (2000). *Financial Management in Agriculture* (6th ed.). Interstate Publishers.
- Langemeier, M. R. (2016). Measuring Farm Profitability. *Purdue Extension, EC-713*.

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

---



## 🤖 Automation & Scheduled Jobs

The system relies on Laravel Scheduler to perform background maintenance and notifications.

| Command | Schedule | Purpose |
|---------|----------|---------|
| `inventory:check-expiry` | Daily (8:00 AM) | Checks for expiring items and notifies farmers. |
| `reports:send-scheduled` | Hourly | Checks for due scheduled reports and emails them. |
| `pre-orders:send-notifications` | Hourly | Sends emails for producation availability and pickup reminders. |
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

### Farmer Routes (`/api/farmer/*`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/farms` | List user's farms |
| POST | `/farms` | Create farm |
| GET | `/fields` | List fields |
| POST | `/fields` | Create field |
| GET | `/plantings` | List plantings |
| POST | `/plantings` | Create planting |
| GET | `/harvests` | List harvests |
| POST | `/harvests` | Record harvest |
| GET | `/inventory` | List inventory items |
| POST | `/inventory` | Add inventory item |
| GET | `/tasks` | List tasks |
| POST | `/tasks` | Create task |
| POST | `/tasks/{id}/complete` | Mark task complete |

### Marketplace Routes (`/api/marketplace/*`)
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/products` | List available products |
| POST | `/products` | Create product listing |
| GET | `/cart` | View cart |
| POST | `/cart/add` | Add to cart |
| POST | `/cart/checkout` | Place order |
| GET | `/orders` | List orders |
| POST | `/orders/{id}/accept` | Accept order (farmer) |
| POST | `/orders/{id}/ready` | Mark ready for pickup |

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

## 📄 License

This project is developed as a capstone project for academic purposes.

---

## 👥 Contributors

- **Capstone Team** - Development
- **Advisor** - Project Guidance

---

<p align="center">
  <sub>Built with ❤️ for the farmers of Bukidnon</sub>
</p>
