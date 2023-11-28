# Adoption Database ( CSCI 421 Database Systems )
## Term Project – Phase Two 
### Due Friday, December 8, 2023 11:59:00 PM EST

In this project, you'll provide the prototype implementation of your term project database and an optional basic interface for it.

### I – Database Normalization and Implementation

Begin by considering our feedback from your ER diagrams. Once you have finalized your design, translate it to schema definitions using the approach we covered in class and list all functional dependencies in your schemata. If your ER design is robust, these tables should be in BCNF. If they are not, decompose them until all of your tables are in BCNF.

When you are satisfied with the normalization of your tables, write an SQL file with DDL statements to instantiate your design. You may need to run these DDL statements several times, so recall that you can use the `DROP TABLE IF EXISTS` command at the beginning of your DDL file before creating the tables.

### II — Populating the Database

By hand, construct a small set of tuples for each table in your database and write an SQL file to insert those tuples. The size and complexity should be similar to the small example we've been using based on the university schema. Be certain that the example you construct exercises all integrity constraints in your design.

### III (bonus) – A Python Interface to the Database

Like you did in project 1, write a Python program that presents the user with menu options to query or update your database. The menu options should be for actions specific to your enterprise, like registering a student was specific to the university example.

### Submission Expectations

- `Whatever_DDL.sql`: Your team's DDL statements to instantiate your database.
- `Whatever_small.sql`: Your team's manually constructed SQL statements to populate a small example of your database. The inserted tuples must exercise all integrity constraints of your design.
- `TeamAwesome.pdf`: A writeup containing the full documentation for your system. This document should include your ER diagrams, the resulting schema definitions and normalization process including arguments that the final schemata are in BCNF, and instructions on how to use your interface to use your system if you submit one.
