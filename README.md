#FoodFusion - Culinary Community Platform

FoodFusion is a full-stack web application dedicated to promoting home cooking and culinary creativity among food enthusiasts. The platform allows users to discover recipes, share their culinary creations, interact with a community of food lovers, and access valuable cooking resources.

## Features

User Management
- User registration with validation
- Secure login with password hashing
- Account lockout after 3 failed attempts (3-minute lock)
- Session management
- Password reset functionality

Recipe Collection
- Browse recipes with filtering options
- Search by cuisine, dietary preferences, and difficulty level
- Detailed recipe views with ingredients and instructions
- Dynamic recipe loading from database

Community Cookbook
- Share cooking experiences with images
- Like and comment on posts
- Real-time interaction feed
- Image upload functionality
- User-specific content

News & Events
- Latest culinary trends and news
- Upcoming cooking events and workshops
- Event registration

Contact System
- Contact form with topic selection
- Message storage in database
- Automated responses

Security Features
- Password hashing with bcrypt
- SQL injection prevention (prepared statements)
- XSS protection
- Session security
- Account lockout mechanism

Technologies Used

Frontend
- HTML5
- CSS3 (with custom properties/variables)
- JavaScript (ES6+)
- Font Awesome Icons
- Google Fonts (Poppins, Playfair Display)
Backend
- PHP 7.4+
- MySQL 5.7+
- Apache/Nginx

Database Structure
- Users table with security fields
- Posts table for community content
- Comments and likes tables
- Recipes with cuisine/difficulty relationships
- Contact messages storage

Prerequisites

- PHP 7.4 or higher
- MySQL 5.7 or higher
- XAMPP/WAMP/MAMP (for local development)
