# Form Management System

A Rails-based web application for creating, managing, and collecting form submissions.

## Features

- **User Authentication**: Sign up, sign in, and user management with Devise
- **Form Builder**: Create custom forms with various field types
- **Form Submissions**: Collect and manage form entries
- **CSV Export**: Download form submissions as CSV files
- **Authorization**: Secure access control with Pundit

## Tech Stack

- **Backend**: Ruby on Rails 8.0
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Authorization**: Pundit
- **Code Quality**: RuboCop

## Getting Started

### Prerequisites

- Ruby 3.0+
- PostgreSQL
- Rails 8.0+

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```

3. Setup the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the server:
   ```bash
   rails server
   ```

5. Visit `http://localhost:3000`

## Usage

1. **Sign Up**: Create a new account
2. **Create Forms**: Build custom forms with different field types
3. **Share Forms**: Forms are accessible to authenticated users
4. **Collect Submissions**: Users can fill out and submit forms
5. **Export Data**: Download submissions as CSV files
```

## License

This project is private and proprietary.