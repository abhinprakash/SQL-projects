WITH CityTreatmentCount AS (               #CTE (Common Table Expression) #improve readability and reusability #temporary table
    SELECT          
        d.diseaseName,         
        a.city,         
        COUNT(t.treatmentID) AS treatment_count,         
        RANK() OVER (PARTITION BY d.diseaseName ORDER BY COUNT(t.treatmentID) DESC) AS `rank`  #Creates a separate ranking for each disease #Ranks cities based on treatment count (highest first)   
    FROM Treatment t     
    JOIN Patient pt ON t.patientID = pt.patientID          #Joining Necessary Tables
    JOIN Person p ON pt.patientID = p.personID            
    JOIN Address a ON p.addressID = a.addressID           
    JOIN Disease d ON t.diseaseID = d.diseaseID             
    GROUP BY d.diseaseName, a.city 
) 
SELECT diseaseName, city, treatment_count           #Filtering the Top 3 Cities Per Disease
FROM CityTreatmentCount 
WHERE `rank` <= 3                #top 3 cities with the highest treatment counts.
ORDER BY diseaseName, `rank`;

