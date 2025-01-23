# ScienceQtech Employee Performance Mapping
# Course-End SQL Project 1

## Project Description

**ScienceQtech** is a dynamic startup specializing in **Data Science**. The company has made strides in various fields, including:
- Fraud Detection
- Market Basket Analysis
- Self-Driving Cars
- Supply Chain Optimization
- Algorithmic Early Detection of Lung Cancer
- Customer Sentiment Analysis
- Drug Discovery

With the **annual appraisal cycle** approaching, the **HR department** has tasked you, as a **Junior Database Administrator (DBA)**, with generating detailed reports on employee performance and the projects they’ve worked on. You are expected to analyze the employee database and extract relevant insights to support the decision-making process.

---

## Project Objective

To facilitate better understanding and decision-making, managers have assigned **performance ratings** to employees. As a DBA, your tasks include:
- Identifying the **highest salary** among employees.
- Ensuring all **job roles** meet the organization’s **profile standards**.
- Calculating **bonuses** to estimate additional expenses.
- Improving the company’s overall performance by identifying employees who need **training**.

---

## Dataset Description

The project uses the following datasets, each containing relevant details about employees and their associated projects:

### 1. **emp_record_table**: Employee Information

This table contains essential details about all employees.

| Column Name   | Description                              |
|---------------|------------------------------------------|
| `EMP_ID`      | Unique identifier for the employee       |
| `FIRST_NAME`  | Employee's first name                    |
| `LAST_NAME`   | Employee's last name                     |
| `GENDER`      | Employee's gender                        |
| `ROLE`        | Job title/position of the employee       |
| `DEPT`        | Department the employee belongs to       |
| `EXP`         | Years of experience                      |
| `COUNTRY`     | Country where the employee resides       |
| `CONTINENT`   | Continent of the employee’s country      |
| `SALARY`      | Employee's salary                        |
| `EMP_RATING`  | Performance rating of the employee       |
| `MANAGER_ID`  | Manager assigned to the employee         |
| `PROJ_ID`     | ID of the project the employee is assigned to |

### 2. **proj_table**: Project Information

This table holds details about the projects in which employees participate.

| Column Name   | Description                              |
|---------------|------------------------------------------|
| `PROJECT_ID`  | Unique identifier for the project        |
| `PROJ_NAME`   | Name of the project                      |
| `DOMAIN`      | The field or domain of the project       |
| `START_DATE`  | Project start date                       |
| `CLOSURE_DATE`| Project closure date (if applicable)     |
| `DEV_QTR`     | Quarter when the project was scheduled   |
| `STATUS`      | Current status of the project           |

### 3. **data_science_team**: Data Science Team Information

This table provides details about employees who work specifically in the **Data Science** team.

| Column Name   | Description                              |
|---------------|------------------------------------------|
| `EMP_ID`      | Unique identifier for the employee       |
| `FIRST_NAME`  | Employee's first name                    |
| `LAST_NAME`   | Employee's last name                     |
| `GENDER`      | Employee's gender                        |
| `ROLE`        | Job title/position of the employee       |
| `DEPT`        | Department of the employee               |
| `EXP`         | Years of experience                      |
| `COUNTRY`     | Country where the employee resides       |
| `CONTINENT`   | Continent of the employee’s country      |

---

## Key Analysis Tasks

1. **Find the maximum salary** of employees.
2. **Validate job roles** to ensure compliance with the organization’s profile standards.
3. **Calculate bonuses** and assess the potential additional costs.
4. **Identify employees who need training** based on performance data.


