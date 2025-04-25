SELECT 
    d.diseaseName,
    SUM(CASE WHEN p.gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN p.gender = 'Female' THEN 1 ELSE 0 END) AS female_count,
    CASE 
        WHEN SUM(CASE WHEN p.gender = 'Female' THEN 1 ELSE 0 END) = 0 
        THEN NULL  -- Avoid division by zero
        ELSE ROUND(
            CAST(SUM(CASE WHEN p.gender = 'Male' THEN 1 ELSE 0 END) AS FLOAT) / 
            SUM(CASE WHEN p.gender = 'Female' THEN 1 ELSE 0 END), 2)
    END AS male_female_ratio
FROM Treatment t
JOIN Patient pt ON t.patientID = pt.patientID
JOIN Person p ON pt.patientID = p.personID
JOIN Disease d ON t.diseaseID = d.diseaseID
WHERE YEAR(t.date) = 2021
GROUP BY d.diseaseName
ORDER BY d.diseaseName;