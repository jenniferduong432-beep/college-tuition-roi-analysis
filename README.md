# college-tuition-roi-analysis
SQL-driven analysis of 249+ colleges comparing tuition costs vs. post-graduation salaries to identify optimal education investments. Reveals public universities deliver 183% better ROI than prestigious private institutions.

# College Tuition ROI Analysis: Translating Education into Income

## Executive Summary
Analyzed 249+ colleges across two datasets to evaluate return on investment (ROI) of tuition costs versus post-graduation earnings. **Key finding: Public universities consistently deliver superior ROI compared to private institutions**, with lower-ranked schools (rank 148) achieving 2.8x better ROI than Ivy League schools. This analysis provides data-driven insights for students and families making critical college investment decisions.

**Skills Used:** SQL (Complex Joins, CTEs, Data Cleaning), Data Analysis, Statistical Analysis, Business Intelligence  
**Tools:** MySQL, Data Visualization, Excel  
**Business Impact:** Provides quantifiable guidance for $100K+ education investments affecting lifetime earnings

---

## Business Problem
College education represents one of the largest financial investments families make, with tuition costs ranging from $10K-$60K+ annually. However, prospective students lack clear, data-driven guidance on:
- Which school types provide the best financial returns
- Whether prestigious universities justify their premium pricing  
- How public vs. private institutions compare on long-term earnings potential

**Objective:** Analyze college salary outcomes relative to tuition costs to identify optimal investment opportunities and guide strategic college selection decisions.

---

## Methodology

### Data Sources
- **College Salaries Dataset:** 249 schools with starting salaries, mid-career salaries (median, 10th/90th percentiles)
- **College Data Dataset:** 161 schools with rankings, tuition costs, school classifications

### Key Technical Challenges Solved
1. **Data Integration:** Joined datasets with mismatched school names using advanced SQL string functions
2. **Data Cleaning:** Standardized salary formats by removing currency symbols and commas for calculations
3. **ROI Calculation:** Created custom metric: `(Mid-Career Salary / Annual Tuition) = ROI Multiplier`

### SQL Techniques Used
- Complex INNER JOINs with CASE statements for name matching
- String functions (INSTR, TRIM, SUBSTRING) for data standardization  
- CAST/DECIMAL conversions for salary calculations
- Aggregate functions (AVG, MAX) for comparative analysis
- Subqueries for category-based calculations

---

## Key Findings & Business Insights

### 1. **School Type Performance Ranking**
| School Type | Avg Mid-Career Salary |
|------------|---------------------|
| Ivy League | $120,125 |
| Engineering | $103,842 |
| Liberal Arts | $89,378 |
| Party | $84,685 |
| State | $78,567 |

**Insight:** Engineering schools nearly match Ivy League outcomes at significantly lower costs.

### 2. **ROI Analysis: Lower-Ranked vs. Ivy League**
- **Ivy League Average ROI:** 1.8x tuition investment
- **Lower-Ranked Schools (Rank 148) ROI:** 5.1x tuition investment  
- **Winner:** Lower-ranked schools provide **183% better ROI**

### 3. **Public vs. Private Value Comparison**
- **Top 10 "Value" Schools:** 100% public institutions
- **Bottom 10 "Value" Schools:** 80% private institutions  
- **Public School Advantage:** Higher salary-to-tuition ratios across all percentile levels

### 4. **Geographic & Specialization Insights**
- Top non-Ivy performers: CalTech ($75.5K), MIT ($72.2K), Harvey Mudd ($71.8K)
- All are **engineering-focused** institutions
- Location correlation: Higher salaries often reflect higher cost-of-living regions

---

## Business Recommendations

### For Students & Families:
1. **Prioritize Public Flagship Universities** - Deliver exceptional ROI with strong career outcomes
2. **Consider Engineering-Focused Schools** - Specialized training rivals Ivy League earning potential  
3. **Evaluate Total Cost vs. Outcomes** - Prestige premium rarely justified by salary gains

### For College Advisors:
1. **Promote ROI-Based Decision Making** - Guide families beyond rankings to value metrics
2. **Highlight Public University Strengths** - Counter private school bias with data
3. **Support Specialized Program Selection** - Engineering/technical fields show consistent high returns

### For Policy Makers:
1. **Increase Public University Funding** - Proven high-value education model
2. **Transparency Requirements** - Mandate ROI reporting for informed consumer decisions

---

## Next Steps & Future Analysis

### Immediate Opportunities:
1. **Geographic Cost-of-Living Adjustment** - Normalize salaries for regional living costs
2. **Financial Aid Impact Analysis** - Calculate net tuition vs. sticker price ROI
3. **Long-term Tracking** - 10-year post-graduation earning trajectories
4. **Industry-Specific Analysis** - ROI breakdown by major/career field

### Advanced Modeling:
1. **Predictive ROI Model** - Machine learning for personalized school recommendations
2. **Risk-Adjusted Returns** - Factor in graduation rates and employment outcomes  
3. **Debt-to-Income Ratios** - Complete financial picture including loan obligations

---

## Project Files
- `joinedqueries(q4q5).sql` - ROI calculations and Ivy League vs. lower-ranked analysis
- `joinedschoolsq2.sql` - Public vs. private school comparisons  
- `Q3presentationcode.sql` - Flagship university analysis
- `FinalProjQ1.sql` - Top-performing non-Ivy institutions
- `IS445GROUPPROJECT.pdf` - Complete analysis presentation with visualizations

---

## Technical Implementation Notes
```sql
-- Example: ROI calculation with data cleaning
SELECT cd.`college name`, 
       cd.tuition, 
       cs.`mid-career median salary`,
       (CAST(REPLACE(REPLACE(cs.`mid-career median salary`, '$', ''), ',', '') AS FLOAT) / cd.tuition) as ROI
FROM (SELECT *, 
             CASE WHEN INSTR(`college name`, '(') > 0 
                  THEN TRIM(SUBSTR(`college name`, 1, INSTR(`college name`, '(') - 1)) 
                  ELSE `college name` END as clean_name 
      FROM college_data) cd
JOIN (SELECT *, 
             CASE WHEN INSTR(`school name`, '(') > 0 
                  THEN TRIM(SUBSTR(`school name`, 1, INSTR(`school name`, '(') - 1)) 
                  ELSE `school name` END as clean_name 
      FROM college_salaries) cs
ON cd.clean_name = cs.clean_name
ORDER BY ROI DESC;
```

**This analysis directly supports strategic decision-making for one of life's most significant investments, providing clear, quantifiable guidance for optimizing education ROI.**
