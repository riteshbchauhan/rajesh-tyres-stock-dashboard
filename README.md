# Rajesh Tyres & Co. Inventory Management System

A Flutter application for managing tyre inventory across multiple branches.

## Features

- **Dashboard Overview**: Quick view of inventory levels across all branches
- **Branch Management**: View and manage inventory for specific branches
- **Inventory Operations**: Add, sell, and transfer tyres between branches
- **Responsive Design**: Works on mobile, tablet and desktop platforms

## Screenshots

The application design is based on the provided mockups and includes:

- Dashboard with branch summary cards
- Inventory table with CRUD operations
- Responsive layout for different screen sizes

## Project Structure

```
lib/
  core/
    constants/
      app_colors.dart           # Color constants
    theme/
      app_theme.dart            # Theme configuration
    utils/                      # Utility functions
    widgets/                    # Shared widgets
  features/
    dashboard/
      data/
        models/
          branch_model.dart     # Data models
          branch_data_provider.dart # State management
      presentation/
        pages/
          dashboard_page.dart   # Main dashboard UI
        widgets/
          branch_summary_card.dart # Branch summary component
          tyre_inventory_table.dart # Inventory table component
  main.dart                     # Application entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (2.19.0 or higher)
- Dart SDK (2.19.0 or higher)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/rajesh_tyres_inventory.git
   ```

2. Install dependencies
   ```
   cd rajesh_tyres_inventory
   flutter pub get
   ```

3. Run the application
   ```
   flutter run
   ```

## Design Elements

The app uses the following color scheme:
- **Primary Blue**: #0053ae
- **Accent Orange**: #f5822d

## Future Enhancements

- User authentication and role-based access
- Data synchronization with cloud backend
- Sales reporting and analytics
- Barcode/QR code scanning for inventory management
- Offline support for branch operations

## License

This project is proprietary and intended for use by Rajesh Tyres & Co. only. 