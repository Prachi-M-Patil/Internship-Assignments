Assignment: Employee Leave Management System (ELMS) Using REST API & Layered Architecture (Without Authentication) Problem Statement Design and implement a Leave Management System for a company where employees can apply for leave, and managers can approve or reject leave requests. The system should be built using Node.js, Express, SQL Server, and a layered architecture. Layers in the Application

Controller Layer - Handles API requests and responses.
Service Layer - Implements business logic and validation.
Repository Layer - Handles database operations (CRUD).
Database Layer - Manages SQL Server connection.
Routing Layer - Defines API endpoints. Requirements The system should support the following operations: Employee Features ✔ Apply for leave (Start Date, End Date, Leave Type, Reason). ✔ View leave history and current leave status. Manager Features ✔ View pending leave requests. ✔ Approve or reject leave requests. Admin Features ✔ View reports of all leaves taken by employees.
API Endpoints

Employee APIs

POST /leaves - Apply for a new leave.

GET /leaves/:employeeId - Get leave history of an employee.

Manager APIs

GET /leaves/pending - Get all pending leave requests.

PUT /leaves/:leaveId/approve - Approve a leave request.

PUT /leaves/:leaveId/reject - Reject a leave request.

Admin APIs

GET /leaves/report - Get reports of all leaves taken by employees.
Database Schema (SQL Server)

Employee Table

id name email role (Employee/Manager/Admin)

Leave Table

id employee_id start_date end_date leave_type

(Sick/Vacation)

status

(Pending/Approved/Rejected) reason

Expected Outcome

Apply Layered Architecture to separate concerns.

Use REST API best practices for request handling.

Store leave requests in SQL Server

Handle errors properly in all layers.

Submission Guidelines

Code should be well-structured using folders:

controllers/, services/, repositories/, routes/, config/.

Include Postman collection for testing APIs.

Provide SQL script for creating tables.
