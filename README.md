# PIIGuard 🔐

**Detect. Mask. Comply.**

PIIGuard is a developer-first API that helps you automatically detect and mask sensitive data (PII) in your applications. It ensures that personally identifiable information is not exposed in logs, APIs, or databases.

---

## 🚀 Features

* 🔍 Detect PII (Email, Phone, IBAN)
* 🛡️ Mask sensitive data in JSON, logs, and strings
* 📊 Track masked fields and detected data types
* 🔐 API key authentication
* 📈 Usage tracking per API key
* 🚫 Rate limiting to prevent abuse

---

## 🧠 Use Cases

* Mask PII before logging
* Protect sensitive data before storing in DB
* Sanitize API request/response payloads
* Ensure GDPR / DPDP compliance

---

## 📦 API Endpoints

### 1. Mask Data

**POST /mask**

#### Request

```json
{
  "data": {
    "email": "john@gmail.com",
    "phone": "9876543210"
  }
}
```

#### Response

```json
{
  "masked": {
    "email": "[EMAIL]",
    "phone": "[PHONE]"
  },
  "meta": {
    "detected": ["EMAIL", "PHONE"],
    "fields_masked": ["email", "phone"],
    "request_id": "abc123",
    "processed_at": "2026-04-24T10:00:00Z"
  }
}
```

---

### 2. Detect PII

**POST /detect**

#### Request

```json
{
  "data": "Contact me at john@gmail.com"
}
```

#### Response

```json
{
  "detected": ["EMAIL"]
}
```

---

## 🔐 Authentication

All endpoints require an API key.

### Header:

```
Authorization: Bearer <API_KEY>
```

---

## 🚫 Rate Limiting

* Default: **100 requests per minute per API key**
* Returns `429 Too Many Requests` when exceeded

---

## 🛠️ Local Setup

### Prerequisites

* Ruby (3.x)
* PostgreSQL
* Git

---

### Setup

```bash
git clone https://github.com/MuthulakshmiRK/piiguard.git
cd piiguard

bundle install
rails db:create db:migrate db:seed

rails server
```

---

## 🧪 Example Request

```bash
curl -X POST http://localhost:3000/mask \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{"data":"My email is john@gmail.com"}'
```

---

## 📊 Usage Tracking

PIIGuard tracks:

* API key usage
* Endpoint usage
* Request counts

This enables:

* Billing
* Analytics
* Rate limiting

---

## 🧱 Tech Stack

* Ruby on Rails (API mode)
* PostgreSQL
* REST API

---

## 🚀 Roadmap

* [ ] Dashboard UI
* [ ] Billing & pricing plans
* [ ] Advanced PII detection (names, addresses)
* [ ] SDKs (Ruby, Node.js)
* [ ] Log pipeline integrations

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

---

## 📄 License

MIT License

---

## 💡 Vision

PIIGuard aims to become the **default data protection layer** for modern applications—helping developers build privacy-first systems effortlessly.
