#SQL Assignment
# 1. Create a table called employees with the following structure?
# emp_id (integer, should not be NULL and should be a primary key).
# emp_name (text, should not be NULL).
# age (integer, should have a check constraint to ensure the age is at least 18).
# email (text, should be unique for each employee).
# salary (decimal, with a default value of 30,000).
#Write the SQL query to create the above table with all constraints.

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS employees;

-- Use the correct database
USE employees;

-- Create the employees table
CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL, 
    age INTEGER CHECK (age >= 18),
    email TEXT ,
    salary DECIMAL DEFAULT 30000
);

#2.  Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
#examples of common types of constraints
#ANS: Constraints in a database are rules applied to table columns to ensure the accuracy, reliability, and integrity of the data. 
#They enforce certain conditions that the data must satisfy, preventing invalid or inconsistent data from being stored in the database. 
#These rules help maintain data quality and ensure that relationships between tables remain consistent.

#Here’s how constraints help maintain data integrity:
#Prevent Invalid Entries: Constraints restrict the type, format, or range of data values, ensuring only valid data is entered.
#Enforce Business Rules: They ensure that the database aligns with the real-world rules of the business it models (e.g., no duplicate IDs).
#Maintain Relationships: Constraints preserve the logical relationships between tables, such as ensuring foreign keys correspond to valid primary keys.

#Common Types of Constraints with Examples:
# 1) NOT NULL Constraint: It Ensures that a column cannot have null (empty) values.
#Example: In a "Users" table, the "Username" field might have a NOT NULL constraint to ensure every user has a username.

#2)UNIQUE Constraint: Guarantees that all values in a column are unique.
#Example: In a "Customers" table, the "Email" field might have a UNIQUE constraint to prevent duplicate email addresses.

#3)PRIMARY KEY Constraint:Combines NOT NULL and UNIQUE constraints to uniquely identify each record in a table.
#Example: A "Student" table might have a "StudentID" as the primary key.

#4)FOREIGN KEY Constraint:Ensures that a value in one table corresponds to a valid value in another table, maintaining referential integrity.
#Example: An "Orders" table might have a "CustomerID" column that references the "CustomerID" in the "Customers" table.

#5)CHECK Constraint:Ensures that values in a column meet specific conditions.
#Example: A "Products" table might use a CHECK constraint on the "Price" column to allow only positive values.

#6)DEFAULT Constraint:Automatically assigns a default value to a column if no value is specified.
#Example: In an "Employees" table, the "HireDate" field might have a default value of the current date.

#3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
#ANS: The NOT NULL constraint is applied to a column to ensure that it always contains valid data, preventing null (empty) values. 
#This is useful when the column is essential for the functionality or logic of the database, like in cases where missing values would disrupt operations or lead to ambiguity. 
#For example, you might use a NOT NULL constraint on a "Username" column because every user in the system must have a username to be identifiable
#Can a Primary Key contain NULL values?
#No, a primary key cannot contain NULL values, and here's why:
#- Uniqueness: A primary key uniquely identifies each record in a table. 
#If a primary key were allowed to have NULL values, it would compromise its ability to distinguish between records because NULL represents an unknown or undefined value, which is not unique.
#-Integrity: Primary keys are used to enforce entity integrity in a database. 
#They ensure that every record in the table can be precisely identified. 
#NULL values would contradict this principle by introducing ambiguity.
#For example, imagine a "Student" table where the "StudentID" is the primary key. 
#If the "StudentID" column were allowed to contain NULL, it would be impossible to identify students with missing IDs, disrupting relationships with other tables that depend on the primary key for referential integrity.
#The combination of NOT NULL and UNIQUE constraints ensures the properties of a primary key are upheld. Let me know if you'd like to explore more scenarios or constraints!
    
#4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint
#ANS: Adding or removing constraints on an existing table typically requires altering the table's structure using SQL commands. 
#Below are the steps and examples for both actions:
#Steps to Add a Constraint:
-- 1) Use the ALTER TABLE command to modify the table.
-- 2) Specify the type of constraint to be added (e.g.,NOT NULL , UNIQUE , FOREGIN KEY).
-- 3) Define the constraint and specify the column it applies to.
-- Example: Add a UNIQUE Constraint:
#Suppose you want to ensure the "email" column in a "Users" table has unique values:
ALTER TABLE Users
ADD CONSTRAINT unique_email UNIQUE (email);
#This command:Alters the "Users" table. Adds a constraint named "unique_email" that ensures the "email" column contains unique values.

-- #Steps to Remove a Constraint:
-- 1)Use the  command to modify the table.
-- 2)Use the DROP CONSTRAINT clause, specifying the name of the constraint to be removed.
-- Example: Remove a UNIQUE Constraint
-- Suppose you want to remove the "unique_email" constraint from the "Users" table:
ALTER TABLE Users
DROP CONSTRAINT unique_email;

#This command: Alters the "Users" table.Drops (removes) the constraint named "unique_email".

#5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
#Provide an example of an error message that might occur when violating a constraint
-- ANS: When inserting, updating, or deleting data in a way that violates constraints, the database prevents the operation and returns an error. 
-- This helps maintain data integrity and consistency.
-- Consequences of Violating Constraints:
-- 1)Insertion Violation:If you try to insert data that doesn't comply with a constraint, the operation will fail.
-- Example: Attempting to insert a NULL value into a column with a  NOT NULL constraint.
-- 2)Update Violation:When updating a record, if the new data violates a constraint, the update won't be allowed.
-- Example: Updating a column value to duplicate an existing value in a column with a UNIQUE constraint.
-- 3)Deletion Violation:If you try to delete a row that is referenced by a FOREIGN KEY  in another table, the DBMS will reject the deletion.
-- Example: Deleting a row from a "Customer" table that is referenced in an "Orders" table.

-- Example of Error Message:
-- Here’s an example of a SQL error message that might occur when violating a FOREIGN KEY constraint:
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`Orders`, CONSTRAINT `fk_customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`))
-- This error typically means you're attempting to delete a record from the "Customers" table while there are related rows in the "Orders" table

