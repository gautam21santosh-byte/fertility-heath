create database ff;
use ff;

select *
from ff.fertility;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- checking null
select * 
from ff.fertility
where bmi or Female_Age or Male_Age is null;

-- count of null values colummn wise
select 
sum(case when Female_Age is null then 1 else 0 end) as Female_Age_nulls,
sum(case when Alcohol_Intake is null then 1 else 0 end) as alcohol_intake_nulls,
sum(case when Treatment_Type is null then 1 else 0 end) as treatment_type_nulls
from ff.fertility;

-- checking duplicate records
select Couple_ID, count(*)
from ff.fertility
group by  Couple_ID
having  count(*)>1;

-- treatment of null values
UPDATE ff.fertility
SET Treatment_Type = 'No treatment'
WHERE Treatment_Type = 'Unknown';


UPDATE ff.fertility
SET alcohol_intake = 'unknown'
WHERE alcohol_intake = 'None';

-- count of couple id where menstural regularity is regular
select count(`couple_id`)
from ff.fertility
where Menstrual_Regularity=("regular");


-- count of couple id where menstural regularity is irregular
select count(`couple_id`)
from ff.fertility
where Menstrual_Regularity="irregular";



-- Q1. Total number of couples
select count(couple_id)
from ff.fertility;

-- Q2. Average female age
select avg(female_age)
from ff.fertility;

-- Q3. Average male age
select avg(`male_age`)
from ff.fertility;


-- Q4. Count of successful pregnancies
select count(*) as successful
from ff.fertility
where pregnancy_outcome="success";

-- Q5. Count of failed pregnancies
select count(*) as successful
from ff.fertility
where pregnancy_outcome="failure";


-- Q6. PCOS-wise distribution
select pcos, count(*) as totl
from ff.fertility
group by pcos;


-- Q7. Stress level distribution
select stress_level, count(*) as total
from ff.fertility
group by Stress_Level
order by total desc;


-- Q8. Highest sperm count
select max( Sperm_Count_Million_per_ml) as high_sperm_count
from ff.fertility;


-- Q9. Lowest motility percentage
select min(`Motility_%` ) as LOW_sperm_motility
from ff.fertility;


-- Q10. Highest motility percentage
select max(`Motility_%` ) as high_sperm_motility
from ff.fertility;


-- Q11. Couples having PCOS and failure outcome
select couple_id, pcos,Pregnancy_Outcome
from ff.fertility
where Pregnancy_Outcome="failure" and pcos= "yes"
group by  couple_id, pcos, Pregnancy_Outcome;


-- Q12. Average sperm count by smoking habit
select avg(Sperm_Count_Million_per_ml), smoking
from ff.fertility
group by Smoking;


-- Q13. Top 10 couples with highest motility
select couple_id, max(`motility_%`)
from ff.fertility
group by Couple_ID
order by max(`motility_%`) desc
limit 10;


-- Q14. Average trying duration
select avg(`Trying_Duration_Months`)
from ff.fertility;

-- Q15. Couples trying more than 24 months
select couple_id , `Trying_Duration_Months`
from ff.fertility
where `Trying_Duration_Months`>24
group by couple_id ,`Trying_Duration_Months`;


-- Q16. Female age group analysis
select (
case when female_age<25 then "below 25"
when female_age between 25 and 35 then "25-35"
else 35 end) as `age_group`, count(*) as total
from ff.fertility
group by age_group;


-- Q17. Average motility by outcome
select avg(`Motility_%`) as sperm_motality, Pregnancy_Outcome
from ff.fertility
group by  Pregnancy_Outcome;


-- Q18. BMI category analysis
select(case when BMI <18.5 then "underweight"
when BMI between 18.5 and 24.9 then "normal"
when BMI between 25 and 29.9 then "overweight" else "obese" end) as bmi_category,
count(*) as total
from ff.fertility
group by bmi_category;


-- Q19. Rank couples by sperm count
select couple_id, Sperm_Count_Million_per_ml,
rank() over (order by Sperm_Count_Million_per_ml desc) as couplerank
from ff.fertility;


-- Q27. Dense rank based on motility
select couple_id, `Motility_%`,
dense_rank() over ( order by `Motility_%` desc) as couplerank
from ff.fertility;

-- Q28. Couples with high stress
select couple_id, Stress_Level
from ff.fertility where Stress_Level="high";

select * from ff.fertility;

-- Q29.  Alcohol Intake vs Pregnancy Success
select Alcohol_Intake,Pregnancy_Outcome, count(*) as total
from ff.fertility
group by Alcohol_Intake, Pregnancy_Outcome;


-- Q30.Smoking Impact on Fertility
select smoking, Pregnancy_Outcome, count(*) as total
from ff.fertility
group by smoking, Pregnancy_Outcome;

-- Q31. Most Common Treatment Type
select Treatment_Type, count(*) as total
from ff.fertility
group by Treatment_Type
order by total desc;

-- Q32. Couples with Both Smoking and Alcohol Consumption
SELECT COUNT(*) AS risky_couple
FROM ff.fertility
WHERE Smoking = 'Yes'
AND Alcohol_Intake IS NOT NULL;

-- Q33. Highest Average Sperm Count by Stress Level
select avg(`Sperm_Count_Million_per_ml`), Stress_Level
from ff.fertility
group by Stress_Level;


-- Q34. Success Rate of PCOS Patients
SELECT PCOS,
       ROUND(
       SUM(CASE WHEN Pregnancy_Outcome='Success' THEN 1 ELSE 0 END)*100.0/COUNT(*),2
       ) AS success_rate
FROM ff.fertility
GROUP BY PCOS;

-- Q35. Success rate by treatment type
SELECT Treatment_Type,
ROUND(100.0 * SUM(CASE WHEN Pregnancy_Outcome='Success' THEN 1 ELSE 0 END)/COUNT(*),2) AS success_rate
FROM ff.fertility
GROUP BY Treatment_Type;


-- insights
# ==============================

# The dataset indicates that fertility outcomes are influenced by a combination
# of biological, lifestyle, and medical factors rather than a single variable.

# Female age shows a strong relationship with pregnancy success, with success
# probability declining gradually after age 35, indicating age as a critical fertility factor.

# Male age also impacts fertility outcomes, but the effect appears less significant
# compared to female reproductive age.

# Patients with healthy BMI ranges demonstrated comparatively higher pregnancy success,
# while overweight and obese categories showed lower fertility outcomes.

# BMI appears to act as both a lifestyle and hormonal risk factor in fertility prediction.

# PCOS patients exhibited lower pregnancy success rates, suggesting that hormonal
# imbalance significantly affects reproductive health outcomes.

# PCOS-related fertility challenges may require more personalized treatment strategies
# and earlier medical intervention.

# Smoking behavior showed a negative association with pregnancy success, reinforcing
# the importance of lifestyle modification in fertility improvement programs.

# Alcohol consumption patterns may contribute to fertility risks, although additional
# behavioral and medical factors should also be considered for deeper analysis.

# Higher stress levels were associated with lower fertility success, highlighting the
# importance of psychological wellness in reproductive healthcare.

# Stress management may serve as an important non-medical intervention to improve
# fertility outcomes among high-risk patients.

# Irregular menstrual cycles appeared more frequently among unsuccessful pregnancy cases,
# indicating a potential relationship between hormonal irregularities and fertility issues.

# Higher sperm count levels generally correlated with improved pregnancy outcomes,
# emphasizing the importance of male fertility indicators in reproductive analysis.

# Sperm motility emerged as one of the strongest biological indicators affecting
# pregnancy success probability.

# Low motility cases may require advanced fertility treatments or earlier intervention.

# Fertility treatment effectiveness varied across patient groups, suggesting that
# treatment outcomes depend heavily on underlying medical and lifestyle conditions.

# Advanced fertility treatments may show higher success among patients receiving
# earlier diagnosis and intervention.

# Lifestyle-related variables such as smoking, stress, and BMI collectively showed
# a measurable impact on fertility outcomes.

# Preventive healthcare and lifestyle optimization may significantly improve
# reproductive success rates.

# The dataset contains class imbalance, with successful pregnancy cases appearing
# more frequently than unsuccessful cases, which may bias machine learning predictions.

# Logistic Regression performed effectively as a baseline classification model due to
# its interpretability and suitability for binary healthcare prediction tasks.

# The model achieved strong overall accuracy; however, lower recall for unsuccessful
# pregnancies indicates challenges in identifying high-risk fertility cases.

# Lower recall for unsuccessful pregnancy cases suggests that the model may miss some
# fertility-risk patients, which is particularly important in healthcare applications.

# Improving minority class detection through class balancing or advanced ensemble models
# could significantly enhance healthcare prediction reliability.

# The analysis demonstrates that fertility prediction is not solely dependent on medical
# treatment but is also strongly influenced by behavioral and lifestyle factors.

# Hospitals and fertility clinics can leverage predictive analytics to identify high-risk
# patients early and improve treatment planning efficiency.

# Early fertility screening, lifestyle counseling, and personalized treatment plans
# may substantially improve reproductive healthcare outcomes.

# This project highlights the potential of healthcare analytics and machine learning
# in supporting data-driven fertility prediction and reproductive healthcare decision-making.

