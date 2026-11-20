# HR Employee Attrition & Workforce Analytics

## Project Overview

An end-to-end HR analytics project focused on understanding employee attrition and workforce patterns using a dataset of **1,240 employee records and 21 attributes**.

The project uses Excel, Python, MySQL and Power BI to analyse employee exits, explore workforce trends and generate data-driven insights that can support employee retention and workforce planning.

**Project Status:** Completed

## Business Problem

Employee attrition can affect organisational stability, recruitment costs and workforce productivity. This project analyses employee data to identify attrition patterns and areas that HR teams may need to investigate.

### Business Questions

1. Which departments have the highest employee exits and attrition rates?
2. What are the most common reasons employees leave?
3. How do salary and satisfaction differ between employees who stayed and those who left?
4. How does attrition vary across age groups and job levels?
5. Does employment type influence observed attrition patterns?
6. Are performance, training and promotion history associated with employee attrition?
7. Which areas should HR prioritise for further retention analysis?

## Dataset Overview

| Metric | Value |
|---|---:|
| Total Employees | 1,240 |
| Employees Stayed | 1,063 |
| Employees Left | 177 |
| Overall Attrition Proportion | 14.27% |
| Departments | 7 |
| Job Titles | 41 |

**Key Attributes:**
- Demographics: Age, Gender, Education, City
- Job Information: Department, Job Title, Job Level, Employment Type
- Compensation: Annual Salary
- Development: Training Hours, Promotions
- Performance: Performance Score, Satisfaction Score
- Attrition: Attrition Status, Exit Date, Exit Reason

## Tools & Technologies

| Tool | Application |
|---|---|
| Microsoft Excel | Data cleaning, formulas, PivotTables and dashboard |
| Python | Exploratory Data Analysis |
| Pandas & NumPy | Data manipulation and numerical analysis |
| Matplotlib & Seaborn | Data visualisation |
| MySQL | SQL queries, CTEs, subqueries and window functions |
| Power BI | DAX, KPI cards, interactive charts and slicers |

## Project Workflow

### 1. Data Understanding & Quality Assessment
- Explored dataset structure and column descriptions.
- Defined business questions.
- Checked duplicate employee IDs and missing values.
- Validated hire and exit dates.
- Reviewed numeric ranges and data consistency.

### 2. Excel Analysis
- Used formulas, tables and PivotTables for workforce analysis.
- Analysed department-wise exits and exit reasons.
- Compared employee satisfaction and other workforce metrics.
- Created an Excel HR dashboard.

### 3. Python Exploratory Data Analysis
- Inspected and analysed employee records using Pandas and NumPy.
- Examined attrition patterns across departments and employee groups.
- Compared salary, satisfaction, tenure, performance and promotions.
- Performed correlation analysis.
- Created visualisations using Matplotlib and Seaborn.

### 4. SQL Analysis
- Queried employee records using MySQL.
- Analysed attrition across departments and job levels.
- Used aggregate functions, CASE statements, subqueries and CTEs.
- Applied window functions for department ranking.
- Performed data quality validation queries.

### 5. Power BI Dashboard
- Created six KPI measures using DAX.
- Developed interactive KPI cards and charts.
- Added department and job-level slicers.
- Presented employee exits, exit reasons, satisfaction trends and employment type distribution.

## Key Findings

- **Overall Attrition:** 177 employees left, representing 14.27% of the dataset.
- **Department Analysis:** Sales had the highest attrition rate (23.72%), followed by Operations (18.93%).
- **Exit Reasons:** Better compensation (55), limited growth (41) and work-life balance (33) were the most frequently recorded reasons.
- **Employee Satisfaction:** Average satisfaction was 2.78 among employees who left and 3.61 among employees who stayed.
- **Salary Analysis:** Average salary was approximately ₹10.40 lakh among employees who left and ₹11.36 lakh among employees who stayed.
- **Age Group Analysis:** Employees aged 18–25 had the highest observed attrition rate (16.05%).
- **Employment Type:** Contract employees had the highest observed attrition rate (16%).

## Proposed Solutions & Recommendations

- **Department Retention:** Investigate higher attrition in Sales and Operations.
- **Compensation:** Review salary structures and benefits.
- **Career Growth:** Strengthen career development and internal growth opportunities.
- **Employee Satisfaction:** Collect regular feedback and address workplace concerns.
- **Workforce Monitoring:** Use the Power BI dashboard to monitor attrition trends and identify areas requiring attention.

These are proposed recommendations based on the observed dataset patterns, not tested HR interventions.

## Project Screenshots

The repository includes:
- Excel HR Dashboard and PivotTable Analysis
- Python correlation matrix and attrition visualisations
- Power BI HR Analytics Dashboard

## Dataset Limitations

- No direct overtime or workload measurements.
- No direct stress-level measurements.
- Salary expectations are not available.
- Work-life balance is recorded only as an exit-reason category.
- The dataset reporting period is not documented.
- Findings indicate patterns and associations, not causation.

## Repository Structure

```text
HR-Employee-Attrition-Analytics/
│
├── data/
│   └── hr_employees.csv
│
├── excel/
│   └── hr_employees_working.xlsx
│
├── notebook/
│   └── HR_Employee_Attrition_Analysis.ipynb
│
├── powerbi/
│   └── HR_Employee_Attrition_Analytics.pbix
│
├── reports/
│
├── screenshots/
│   ├── excel_screenshot/
│   ├── notebook_Screenshot/
│   └── powerBI_Dashboard.png
│
├── sql/
│   └── hr_employee_attrition_analysis.sql
│
└── README.md
```

## Conclusion

This project demonstrates an end-to-end HR analytics workflow, transforming employee data into meaningful workforce insights using Excel, Python, MySQL and Power BI.

It highlights attrition patterns across departments, compensation, satisfaction, age groups and employment types, providing a foundation for further HR investigation and data-driven workforce planning.

**Note:** This is a practice/sample dataset, not verified data from a real organisation. The reporting period is undocumented; therefore, the 14.27% attrition proportion should not be interpreted as an annual rate.
