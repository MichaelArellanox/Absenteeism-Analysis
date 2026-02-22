USE Project2;

-- creating a full table 

SELECT *
FROM Absenteeism_at_work aw
-- first join brings in the compensation table
LEFT JOIN compensation comp
ON aw.ID = comp.ID
-- second join brings in the reasons table
LEFT JOIN Reasons r
ON aw.Reason_for_absence = r.Number;

-- created joins to merge all the info of the tables together
-- when transferring to Power BI, we only want the columns we need
-- question 1, find the healthiest employees. Look through data to see what is considered healthy

SELECT *
FROM Absenteeism_at_work
WHERE Social_smoker = 0 and Social_drinker = 0 and Body_mass_index > 25
-- create a subquery here
-- calculation gets who has less absents than the average absents 
and Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)



-- question 2, compensation rate increase for non smokers
-- budget is 983,221, we now have to find the total hours worked a year for the 686 non smokers
-- 40 hr work weeks x 52 weeks in a year = 2080 hrs worked for an employee
-- 2080 hrs x 686 employees is the total hrs worked for 686 employees
-- 1426880 is our result, now it is 983221/1426880 which is .68 increase per hour or $1,414.4 per year 

SELECT COUNT(*) as non_smokers 
FROM Absenteeism_at_work
WHERE Social_smoker = 0


-- optimizing query
SELECT aw.ID, r.Reason, Month_of_absence, Body_mass_index,
-- case statement 1
CASE WHEN Month_of_absence IN (12, 1, 2) THEN 'Winter'
     WHEN Month_of_absence IN (3, 4, 5) THEN 'Spring'
     WHEN Month_of_absence IN (6, 7, 8) THEN 'Summer'
     WHEN Month_of_absence IN (9, 10, 11) THEN 'Fall'
     ELSE 'Uknown'
     END as Seasons,
-- case statement 2
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
     WHEN Body_mass_index between 18.5 and 25 THEN 'Healthy'
     WHEN Body_mass_index between 25 and 30 THEN 'Overweight'
     WHEN Body_mass_index < 30 THEN 'Obese'
     ELSE 'Unknown' 
     END as BMI_status,
Day_of_the_week,
Transportation_expense,
Age,
Education,
Son,
Social_drinker,
Social_smoker,
Disciplinary_failure,
Pet,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work aw
-- first join brings in the compensation table
LEFT JOIN compensation comp
ON aw.ID = comp.ID
-- second join brings in the reasons table
LEFT JOIN Reasons r
ON aw.Reason_for_absence = r.Number;
