SELECT 
    p.personName AS Patient_Name,
    COUNT(t.treatmentID) AS Number_of_Treatments,
    TIMESTAMPDIFF(YEAR, pa.dob, CURDATE()) AS Age
FROM Patient pa
JOIN Person p ON pa.patientID = p.personID
JOIN Treatment t ON pa.patientID = t.patientID
GROUP BY p.personID, p.personName, pa.dob       #Groups records by each unique patient
HAVING COUNT(t.treatmentID) > 1       #only patients with more than one treatment
ORDER BY Number_of_Treatments DESC;