# Villa Booking API

This is a simple **Rails API-only application** for checking **villa availability** and **price estimates** based on a selected date range. It also supports **sorting** villas by price and availability.

---

## Features

- Fetch a list of villas with:
  - Average price per night
  - Availability status for selected dates
- Check detailed pricing for a specific villa (subtotal, GST, total)
- Sort villas by:
  - Price (low to high / high to low)
  - Availability (available villas first)

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/Aditya-JOSH/villa-booking-system.git
cd villa-booking-system
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Set up the database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the server

```bash
rails server
```

---

### Get all villas

**Optional Sorting Parameters**

| Parameter           | Description                         |
|---------------------|-------------------------------------|
| `sort_price=low_to_high` | Sort villas by price ascending    |
| `sort_price=high_to_low` | Sort villas by price descending   |
| `sort_availability=true` | Prioritize available villas first |

**Example**

```http
GET /villas?checkin_date=2025-04-10&checkout_date=2025-04-13&sort_price=low_to_high
```

---

### Check availability and price for a specific villa

**Example**

```http
GET /villas/1/availability?checkin_date=2025-04-10&checkout_date=2025-04-13
```
