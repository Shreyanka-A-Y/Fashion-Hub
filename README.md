# FashionHub – Smart Fashion E-Commerce & Used Product Exchange Platform

## Overview

FashionHub is a full-stack Java web application developed to provide a modern online fashion shopping experience with an integrated sustainable used-product marketplace. The platform allows users to browse and purchase official fashion products, manage carts and orders, and exchange pre-owned fashion items using a digital coin system.

The project is built using Java technologies following the MVC Architecture and DAO Design Pattern for clean code organization, scalability, and efficient database management.

---

# Features

## User Features
- User Registration & Login
- Secure Session Management
- Browse Products by Categories
- Search Products
- Product Detail View
- Add to Cart
- Place Orders
- Wallet & Coin System
- View Order History
- Buy Used Products
- Sell Pre-owned Fashion Products

---

## Admin Features
- Admin Authentication
- Admin Dashboard
- Add Official Products
- Upload Product Images
- Manage Users
- Approve/Reject Used Products
- Manage Inventory & Stock

---

## Used Market Features
- Community-based Used Product Marketplace
- Coin-based Product Exchange System
- Product Approval Workflow
- Condition-based Product Listing
- Sustainable Fashion Marketplace

---

# Technologies Used

## Frontend
- HTML5
- CSS3
- JavaScript
- JSP (Java Server Pages)

## Backend
- Java
- Servlets
- JDBC

## Database
- MySQL

## Server
- Apache Tomcat 11

## Architecture & Design Patterns
- MVC Architecture
- DAO Pattern

---

# Project Architecture

The project follows the MVC (Model View Controller) architecture:

```text
User Request
     ↓
JSP Pages (View)
     ↓
Servlets (Controller)
     ↓
DAO Layer
     ↓
MySQL Database
```

---

# MVC Structure

## Model
Contains data classes:
- User.java
- Product.java
- UsedProduct.java
- Order.java

---

## View
Frontend JSP pages:
- index.jsp
- products.jsp
- product-details.jsp
- cart.jsp
- used-market.jsp
- admin-dashboard.jsp

---

## Controller
Servlet classes:
- LoginServlet
- AddProductServlet
- AddToCartServlet
- BuyUsedProductServlet
- ApproveUsedServlet

---

## DAO Layer
Database operation classes:
- UserDAO
- ProductDAO
- CartDAO
- UsedProductDAO
- OrderDAO

---

# Folder Structure

```text
FashionHub/
│
├── src/main/java/
│   ├── com.fashionhub.controller
│   ├── com.fashionhub.dao
│   ├── com.fashionhub.model
│   └── com.fashionhub.util
│
├── src/main/webapp/
│   ├── assets/
│   │   ├── css/
│   │   ├── js/
│   │   └── images/
│   │
│   ├── components/
│   │   ├── navbar.jsp
│   │   └── footer.jsp
│   │
│   └── jsp/
│       ├── index.jsp
│       ├── products.jsp
│       ├── used-market.jsp
│       ├── cart.jsp
│       ├── login.jsp
│       └── admin-dashboard.jsp
│
└── MySQL Database
```

---

# Database Modules

The project includes multiple database tables such as:
- users
- products
- used_products
- cart
- orders
- order_items
- categories

---

# Key Functionalities

## Product Management
- Admin uploads official products
- Image upload support
- Product categorization
- Inventory management

---

## Used Product Exchange
- Users can list used products
- Admin approval system
- Coin-based purchasing model

---

## Image Handling
- Dynamic image upload and retrieval
- Product image rendering from database paths

---

## Authentication & Security
- Session-based login system
- Admin access control
- Secure page redirection

---

# Why Apache Tomcat is Used

Apache Tomcat is used as the web server and servlet container to:
- Run JSP and Servlets
- Handle HTTP Requests & Responses
- Manage Sessions
- Deploy the Java Web Application
- Connect frontend and backend components

---

# Project Outcome

FashionHub successfully delivers:
- A responsive fashion e-commerce platform
- Sustainable used-product marketplace
- Coin-based exchange system
- Modern admin management system
- Full-stack Java web development implementation

The project demonstrates practical knowledge of:
- Java Web Development
- Database Connectivity
- MVC Architecture
- DAO Pattern
- Session Handling
- File Uploading
- Responsive UI Design

---

# Future Enhancements

- Online Payment Gateway Integration
- AI-based Product Recommendations
- Product Reviews & Ratings
- Email Notifications
- Wishlist Feature
- Real-time Order Tracking
- Mobile Responsive Enhancements
- Cloud Image Storage

---

# Conclusion

FashionHub is a complete Java-based fashion e-commerce platform that combines online shopping with sustainable fashion exchange. The project provides an efficient, scalable, and user-friendly solution using modern web technologies and software architecture principles.
