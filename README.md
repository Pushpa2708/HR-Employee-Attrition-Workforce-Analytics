# HR Employee Attrition & Workforce Analytics

## Project Overview

This project explores employee attrition and workforce patterns using an HR employee dataset containing 1,240 employee records and 21 attributes.

The objective is to understand employee exits, identify workforce patterns and develop data-driven recommendations that could support employee retention.

**Project Status:** In Progress

## Business Problem

Employee attrition can affect organisational stability, recruitment costs and workforce productivity.

This project investigates employee attrition through questions such as:

- Which departments have the highest employee exits?
- What are the most frequently recorded reasons for leaving?
- How do salary and satisfaction differ between employees who stayed and left?
- Are employees leaving at particular stages of their careers?
- Does promotion history relate to employee attrition?

## Dataset Overview

- Total Records: 1,240
- Total Columns: 21
- Employees who stayed: 1,063
- Employees who left: 177
- Departments: 7
- Job Titles: 41

### Key Attributes

- Employee demographics: Age, Gender, Education, City
- Job Information: Department, Job Title, Job Level, Employment Type
- Compensation: Annual Salary
- Employee Development: Training Hours, Promotions
- Performance and Satisfaction: Performance Score, Satisfaction Score
- Attrition: Attrition Status, Exit Date, Exit Reason

## Tools & Technologies

- Microsoft Excel
- Excel Formulas
- Excel Tables
- PivotTables
- Data Visualization (Planned)

## Project Workflow

### 1. Data Understanding
- Identified the dataset structure and column meanings.
- Defined business questions.
- Documented dataset limitations.

### 2. Data Quality Assessment
- Checked duplicate employee IDs.
- Examined missing values.
- Validated exit dates against hire dates.
- Checked numeric ranges and text consistency.
- Preserved expected blank values for employees who were still working.

### 3. Exploratory Analysis (In Progress)
- Created an initial department-wise employee exit PivotTable.
- Identified exit counts across seven departments.

### Preliminary Finding

The initial department-wise exit counts show:

| Department | Employees Who Left |
|---|---:|
| Sales | 60 |
| Operations | 46 |
| Engineering | 36 |
| Finance | 14 |
| Marketing | 8 |
| Legal | 7 |
| HR | 6 |
| **Total** | **177** |

These are exit counts, not department-wise attrition rates. Further analysis is required before comparing departments.

## Dataset Limitations

- No direct overtime-hours or workload measurements.
- No direct stress-level measurements.
- Work-life balance is available only as a recorded exit-reason category.
- Salary expectations are not available.
- Findings represent patterns in the provided sample dataset and should not be treated as causal conclusions.

## Planned Work

- Calculate department-wise attrition rates.
- Analyse exit reasons.
- Investigate salary, satisfaction, tenure and promotion patterns.
- Create visualisations and an HR dashboard.
- Develop evidence-based retention recommendations.

## Project Objective

To develop practical HR analytics skills by transforming employee data into meaningful workforce insights and actionable business recommendations.
