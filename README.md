

# Alien Adoption Database System

## Introduction
This repository contains the implementation of an Alien Adoption Database System. The system is designed to facilitate the adoption of orphaned aliens by families across different planets. The database schema, SQL scripts for table creation, and Python scripts for interacting with the database are provided.

## Requirements
- Python 3.x
- PostgreSQL

## Setting Up the Database
1. Ensure PostgreSQL is installed and running on your system.
2. Create a new database
3. Execute the SQL scripts provided in the `database_setup.sql` file to create the necessary tables and populate sample data.

## Running the Program
1. Clone this repository to your local machine.
2. Navigate to the directory containing the Python scripts.
3. Run the `main.py` script using Python.
   ```bash
   python main.py
   ```
4. Follow the on-screen menu prompts to interact with the database system.

## Functionality
The program provides the following functionality through a command-line interface:
- Viewing alien and family information.
- Managing adoption requests.
- Generating lists of adoptable aliens.
- Providing an overview of the database.

## Sample Data
Sample data is provided in the `database_setup.sql` file to populate the database with example records. This data exercises all integrity constraints of the database design.

## Notes
- Aliens reside in orphanages associated with agencies.
- Adoption requests are created between aliens and families.
- Upon approval, aliens are added to the adopted table, indicating adoption.
- The system ensures data integrity and handles adoption-related transactions efficiently.
- [View the ER Diagram](https://docs.google.com/document/d/1gfmpAALoAo1Lg0dl1MrpXSNFmDQSYqzzieVb54i0OsE/view)

## Contributors
- Connor MacKinnon
- Jake Richardson
- Hannah Zimmerman
