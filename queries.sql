USE CellCultureLabDB;

-- 1. Retrieval: active cell lines
SELECT CellLineID, CellLineName, Species, TissueType
FROM CellLine
WHERE IsActive = TRUE
ORDER BY CellLineName;

-- 2. Multiple JOINs: experiment summary
SELECT e.ExperimentID, e.ExperimentName, e.Status, e.StartDate,
       r.FullName AS Researcher, c.CellLineName
FROM Experiment e
JOIN Researcher r ON e.ResearcherID = r.ResearcherID
JOIN Experiment_CellLine ec ON e.ExperimentID = ec.ExperimentID
JOIN CellLine c ON ec.CellLineID = c.CellLineID
ORDER BY e.ExperimentID;

-- 3. Culture vessel details
SELECT v.VesselID, c.CellLineName, v.VesselType,
       i.IncubatorName, i.Temperature, i.CO2Percent, v.Status
FROM CultureVessel v
JOIN CellLine c ON v.CellLineID = c.CellLineID
LEFT JOIN Incubator i ON v.IncubatorID = i.IncubatorID
ORDER BY v.VesselID;

-- 4. Passage history
SELECT p.PassageID, c.CellLineName, p.PassageNumber, p.SplitRatio,
       p.SeedingDate, m.MediaName, r.FullName AS PerformedBy
FROM Passage p
JOIN CultureVessel v ON p.VesselID = v.VesselID
JOIN CellLine c ON v.CellLineID = c.CellLineID
JOIN Media m ON p.MediaID = m.MediaID
JOIN Researcher r ON p.PerformedBy = r.ResearcherID
ORDER BY p.PassageID;

-- 5. Aggregation: number of experiments per researcher
SELECT r.ResearcherID, r.FullName, COUNT(e.ExperimentID) AS NumberOfExperiments
FROM Researcher r
LEFT JOIN Experiment e ON r.ResearcherID = e.ResearcherID
GROUP BY r.ResearcherID, r.FullName
ORDER BY NumberOfExperiments DESC, r.FullName;

-- 6. Aggregation: average confluency by cell line
SELECT c.CellLineName, ROUND(AVG(o.ConfluencyPercent),2) AS AverageConfluency
FROM Observation o
JOIN CultureVessel v ON o.VesselID = v.VesselID
JOIN CellLine c ON v.CellLineID = c.CellLineID
GROUP BY c.CellLineID, c.CellLineName
ORDER BY AverageConfluency DESC;

-- 7. Subquery: cryopreserved stocks with above-average viability
SELECT c.CellLineName, cs.VialID, cs.ViabilityPercent
FROM CryopreservedStock cs
JOIN CellLine c ON cs.CellLineID = c.CellLineID
WHERE cs.ViabilityPercent > (SELECT AVG(ViabilityPercent) FROM CryopreservedStock)
ORDER BY cs.ViabilityPercent DESC;

-- 8. Contamination test results
SELECT ct.TestID, ct.TestType, ct.Result,
       r.FullName AS PerformedBy, ct.TestDate
FROM ContaminationTest ct
JOIN Researcher r ON ct.PerformedBy = r.ResearcherID
ORDER BY ct.TestDate;

-- 9. Media expiring before a selected date
SELECT MediaID, MediaName, Brand, ExpirationDate
FROM Media
WHERE ExpirationDate < '2027-05-01'
ORDER BY ExpirationDate;

-- 10. INSERT / UPDATE / DELETE demonstration
-- Rolled back so the demonstration does not permanently change data.
START TRANSACTION;

INSERT INTO Researcher
(FullName, Email, Phone, Role, Department, DateJoined)
VALUES ('Demo Researcher','demo.researcher@lab.edu','01019999999',
        'Trainee','Cell Biology','2026-04-01');

SET @DemoResearcherID = LAST_INSERT_ID();

UPDATE Researcher
SET Role = 'Research Assistant'
WHERE ResearcherID = @DemoResearcherID;

SELECT * FROM Researcher WHERE ResearcherID = @DemoResearcherID;

DELETE FROM Researcher WHERE ResearcherID = @DemoResearcherID;

ROLLBACK;
