
# LocaLink 🚀

LocaLink is a location-based advertisement platform that connects advertisers with local users based on geolocation. Advertisers can post ads, and users can view ads relevant to their area. The platform supports both Android and web interfaces.

## 🌐 Project Overview

- **Web Portal (Spring Boot + JSP)**
  - Advertiser registration and login system (email must be unique)
  - Admin panel to approve advertisers within a 100km radius
  - Firebase Firestore used for storing user and ad data
  - Firebase Storage for storing advertisement images

- **Android App (Java + Firebase)**
  - Location-based ad discovery
  - User ratings for advertisements (out of 5)
  - Prevents multiple ratings by the same user
  - Map integration for selecting and retrieving shop addresses

---

## 🔧 Features

### 🔍 Location-Based Advertising
- Ads are shown based on the user's current location or a selected area.

### 👨‍💼 Advertiser Portal
- Register, login, and post advertisements with images, descriptions, and categories.
- Latitude and longitude selection via map.
- Shop description and contact number fields.

### 🛠 Admin Panel
- Admin can approve/reject advertiser registrations based on location radius (100km).
- Status field (default: `pending`) for advertiser approval.

### 📊 Advertisement Ratings
- Users can rate ads.
- Real-time rating updates using Firebase Firestore.

---

## 🧰 Tech Stack

### Backend (Web)
- Java Spring Boot
- JSP (No JSTL used)
- Firebase Admin SDK
- Firebase Firestore
- Firebase Storage

### Frontend (Web)
- HTML, CSS (Only)
- JSP pages

### Mobile
- Android (Java + Firebase)
- Firebase Realtime Database and Firestore
- Google Maps SDK

---

## 🗂️ Project Structure

### 📁 Web App (Spring Boot)
```
src/
└── main/
    ├── java/com/localink/
    │   ├── controllers/
    │   ├── services/
    │   ├── models/
    │   └── config/
    └── resources/
        ├── templates/
        │   ├── advlogin.jsp
        │   ├── advregister.jsp
        │   ├── mappage.jsp
        │   ├── addAdvertisement.jsp
        │   └── adminPanel.jsp
        └── application.properties
```

### 📱 Android App
```
com.localink/
├── activities/
│   ├── RegisterActivity.java
│   ├── LoginActivity.java
│   ├── AdvertisementAdapter.java
│   └── MapActivity.java
├── models/
│   ├── UserModel.java
│   └── AdvertisementModel.java
└── utils/
    └── FirebaseHelper.java
```

---

## 🧪 Firebase Setup

1. Create a Firebase project and add both Android and Web apps.
2. Download and place `google-services.json` in your Android `app/` directory.
3. Place your Firebase Admin SDK `serviceAccountKey.json` in the `resources/` folder of your Spring Boot project.
4. Initialize Firebase in your Spring Boot `FirebaseInitializer` class.

---

## 🚀 Getting Started

### Web App
```bash
# Run Spring Boot app
./mvnw spring-boot:run
```

### Android App
- Open in Android Studio
- Sync Gradle
- Run on emulator or device
