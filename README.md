# DataScape: Mastering Database Design  

## About the Project  

This project is part of the comprehensive ALX Airbnb Database Module, focusing on database design, normalization, schema creation, and seeding. By working through these tasks, learners will design and build a robust relational database for an Airbnb-like application, ensuring scalability, efficiency, and real-world functionality. The project simulates a production-level database system, emphasizing high standards of design, development, and data handling.

---

## Learning Objectives  

As a professional developer, completing these tasks will empower you to:  

- Apply advanced principles of database design to model complex systems.  
- Master the art of normalization to optimize database efficiency and minimize redundancy.  
- Use SQL DDL (Data Definition Language) to define database schema with appropriate constraints, keys, and indexing for performance optimization.  
- Write and execute SQL DML (Data Manipulation Language) scripts to seed databases with realistic sample data, simulating real-world scenarios.  
- Enhance collaboration skills by managing repositories, documenting processes, and adhering to professional submission standards.

---

## Requirements  

To successfully complete these tasks, you must:  

- Have a strong foundation in relational databases and SQL.  
- Be proficient in using tools like Draw.io (or similar) for visual modeling.  
- Possess a good understanding of data normalization principles, particularly up to 3NF.  
- Have experience with GitHub repositories for documentation and project submission.  
- Follow industry best practices for database design and scripting.

---

## Key Highlights & Task Breakdown  

### Task 0: Define Entities and Relationships in ER Diagram  

- **Mandatory**  
- Objective: Create an Entity-Relationship (ER) diagram based on the database specification.  
- Instructions: Identify all entities (User, Property, Booking, etc.) and their attributes. Define the relationships between entities (e.g., User to Booking, Property to Booking). Use Draw.io or another tool to create a visual representation of your ER diagram.  
- **Repo location:**  
  - GitHub repository: `alx-airbnb-database`  
  - Directory: `ERD/`  
  - File: `requirements.md`  

### Task 1: Normalize Your Database Design  

- **Mandatory**  
- Objective: Apply normalization principles to ensure the database is in the third normal form (3NF).  
- Instructions: Review your schema and identify any potential redundancies or violations of normalization principles. Adjust your database design to achieve 3NF, if necessary. Provide an explanation of your normalization steps in a Markdown file.  
- **Repo location:**  
  - GitHub repository: `alx-airbnb-database`  
  - File: `normalization.md`  

### Task 2: Design Database Schema (DDL)  

- **Mandatory**  
- Objective: Write SQL queries to define the database schema (create tables, set constraints).  
- Instructions: Based on the provided database specification, create SQL `CREATE TABLE` statements for each entity. Ensure proper data types, primary keys, foreign keys, and constraints. Create necessary indexes on columns for optimal performance.  
- **Repo location:**  
  - GitHub repository: `alx-airbnb-database`  
  - Directory: `database-script-0x01/`  
  - Files: `schema.sql`, `README.md`  

### Task 3: Seed the Database with Sample Data  

- **Mandatory**  
- Objective: Create SQL scripts to populate the database with sample data.  
- Instructions: Write SQL `INSERT` statements to add sample data for User, Property, Booking, etc. Ensure the sample data reflects real-world usage (e.g., multiple users, bookings, payments).  
- **Repo location:**  
  - GitHub repository: `alx-airbnb-database`  
  - Directory: `database-script-0x02/`  
  - Files: `seed.sql`, `README.md`
  