SELECT 
    ph.pharmacyName,
    d.diseaseName,
    SUM(CASE WHEN YEAR(t.date) = 2021 THEN 1 ELSE 0 END) AS prescriptions_2021,
    SUM(CASE WHEN YEAR(t.date) = 2022 THEN 1 ELSE 0 END) AS prescriptions_2022
FROM Prescription p
JOIN Treatment t ON p.treatmentID = t.treatmentID
JOIN Disease d ON t.diseaseID = d.diseaseID
JOIN Pharmacy ph ON p.pharmacyID = ph.pharmacyID
WHERE YEAR(t.date) IN (2021, 2022)  -- Ensures we only consider these years
GROUP BY ph.pharmacyName, d.diseaseName
ORDER BY ph.pharmacyName, d.diseaseName;