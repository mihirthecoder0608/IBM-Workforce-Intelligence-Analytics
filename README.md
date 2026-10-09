# IBM Workforce Intelligence Analytics

**End-to-end HR analytics project using Python, SQL, and Power BI to analyze employee attrition, identify workforce risks, and develop data-driven retention recommendations.**

## 1. Project Overview

Employee attrition is a major workforce challenge that can increase recruitment costs, disrupt productivity, and result in the loss of experienced employees.

This project analyzes employee data to uncover attrition patterns, understand workforce characteristics, examine compensation and job satisfaction, and provide actionable insights for HR decision-makers.

## 2. Business Objectives

- Measure overall employee attrition and retention.
- Identify job roles with high employee exit rates.
- Analyze the relationship between overtime and attrition.
- Explore salary, job satisfaction, tenure, and demographic patterns.
- Build interactive Power BI dashboards for workforce monitoring.
- Recommend data-driven strategies to improve employee retention.

## 3. Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning and exploratory data analysis |
| Pandas and NumPy | Data manipulation and analysis |
| Matplotlib and Seaborn | Data visualization |
| Jupyter Notebook | Analysis documentation and execution |
| SQL / MySQL | Business queries and workforce analysis |
| Power BI | Interactive dashboards and KPI reporting |
| Microsoft PowerPoint | Presentation of findings and recommendations |

## 4. Dataset

The project uses the **IBM HR Analytics Employee Attrition & Performance** dataset.

- **Original records:** 1,470 employees
- **Original columns:** 35
- **Columns retained after removing constant fields:** 32
- **Target outcome:** Employee attrition (`Attrition`)

The dataset includes employee demographics, job roles, departments, monthly income, overtime, job satisfaction, tenure, and other workforce attributes.

*Dataset attribution and applicable usage terms should be verified against the original source.*

## 5. Project Workflow

1. **Data inspection:** Examine the dataset structure, column types, and data quality.
2. **Data cleaning:** Check missing values, duplicate records, unique employee identifiers, and business-rule consistency.
3. **Exploratory analysis:** Investigate attrition patterns across roles, overtime, salary, satisfaction, and tenure.
4. **SQL analysis:** Use queries to aggregate employee data and answer business questions.
5. **Dashboard development:** Build Power BI reports for employee overview, attrition, and salary analysis.
6. **Business recommendations:** Translate the findings into practical retention initiatives.

## 6. Key Findings

### Overall Attrition

- Total employees: **1,470**
- Employees who left: **237**
- Active employees: **1,233**
- Overall attrition rate: **16.12%**

### Overtime and Attrition

| Overtime status | Employees | Attrition rate |
|---|---:|---:|
| Yes | 416 | 30.53% |
| No | 1,054 | 10.44% |

Employees working overtime had approximately **2.9 times the attrition rate** of employees not working overtime. This is an observed association, not proof that overtime alone causes employees to leave.

### Attrition by Job Role

| Job role | Attrition rate |
|---|---:|
| Sales Representative | 39.76% |
| Laboratory Technician | 23.94% |
| Human Resources | 23.08% |
| Sales Executive | 17.48% |
| Research Scientist | 16.10% |
| Manufacturing Director | 6.90% |
| Healthcare Representative | 6.87% |
| Manager | 4.90% |
| Research Director | 2.50% |

Sales Representatives had the highest attrition rate among the listed job roles. Laboratory Technicians had the highest number of exits, with 62 employees leaving.

### Job Satisfaction

Employees with a job satisfaction rating of 1 had an attrition rate of approximately **22.84%**, compared with **11.33%** for employees with a rating of 4.

### Income Patterns

Employees in the lowest monthly income band (below 3,000) had an attrition rate of approximately **28.61%**, while employees in the 12,000+ band had a rate of approximately **5.64%**.

These findings describe patterns in this dataset and should not be interpreted as proof of causation.

## 7. Power BI Dashboard

The Power BI report contains three analytical pages.

### Employees Overview
- Total employee headcount
- Workforce demographics
- Department and job-role distribution
- Employee tenure analysis

### Attrition Overview
- Attrition count and attrition rate
- Attrition by job role and marital status
- Job involvement patterns
- Attrition across age and tenure groups

### Salary Overview
- Average monthly income
- Salary distribution by income band
- Income patterns across roles and experience
- Overtime and compensation analysis

**How to interact with the dashboard:** Download the `.pbix` file from this repository and open it using Microsoft Power BI Desktop. GitHub does not directly render the interactive report.

## 8. Business Recommendations

### 1. Review Overtime and Workload
Investigate workload, staffing levels, overtime frequency, and employee feedback in teams with elevated attrition.

### 2. Prioritize High-Attrition Roles
Conduct targeted retention reviews for Sales Representatives and Laboratory Technicians, examining compensation, career progression, management support, and working conditions.

### 3. Strengthen Early-Tenure Support
Improve onboarding, mentoring, role clarity, and manager check-ins for newer employees.

### 4. Improve Employee Experience
Investigate low job satisfaction and identify practical interventions using employee feedback and engagement data.

### 5. Monitor Retention KPIs
Track attrition rate, overtime exposure, voluntary exits where available, and retention by job role and tenure over time.

## 9. Repository Structure

The current repository is organized as follows:

```text
IBM-Workforce-Intelligence-Analytics/
├── Python/
│   ├── Dataset_Analysis_SQL.sql
│   ├── HR_Employee_Attrition_dataset.csv
│   ├── HR_analytics_EDA.ipynb
│   ├── IBM_Workforce-Analytics_Dashboard.pbix
│   └── Workforce_Intelligence_Analysis.pptx
├── README.md
└── .gitignore
```

All five project files are currently stored inside the `Python` folder. They can be reorganized into separate folders in a future cleanup.

## 10. How to Run and Explore

### Python Analysis
1. Download or clone this repository.
2. Install Python and Jupyter Notebook.
3. Install the required libraries, such as Pandas, NumPy, Matplotlib, and Seaborn.
4. Open `HR_analytics_EDA.ipynb` and execute the notebook cells.

### SQL Analysis
1. Open `Dataset_Analysis_SQL.sql`.
2. Use a compatible SQL environment, such as MySQL.
3. Configure the database and table according to the queries before executing them.

### Power BI Report
1. Download `IBM_Workforce-Analytics_Dashboard.pbix`.
2. Open it in Power BI Desktop.
3. Explore the report pages and interact with the visualizations.

## 11. Limitations

- The analysis describes patterns in the available dataset and does not establish causation.
- Findings may not generalize to every organization or industry.
- Historical employee data may not reflect current workforce conditions.
- Recommendations should be validated using additional organizational context and employee feedback.

## 12. Conclusion

This project demonstrates how Python, SQL, and Power BI can be combined to turn HR data into actionable workforce insights. By identifying attrition patterns and examining factors associated with employee exits, the analysis provides a foundation for more targeted retention strategies and ongoing HR performance monitoring.

## Author

**HR Analytics Portfolio Project**

Skills demonstrated: Data Cleaning · Exploratory Data Analysis · SQL · MySQL · Power BI · Data Visualization · Business Insights

