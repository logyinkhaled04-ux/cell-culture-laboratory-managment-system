USE CellCultureLabDB;

DROP VIEW IF EXISTS ActiveCellLines;
CREATE VIEW ActiveCellLines AS
SELECT c.CellLineID, c.CellLineName, c.Species, c.TissueType,
       c.AuthenticationStatus, r.FullName AS MaintainedBy
FROM CellLine c
LEFT JOIN Researcher r ON c.MaintainedBy = r.ResearcherID
WHERE c.IsActive = TRUE;

DROP VIEW IF EXISTS ExperimentSummary;
CREATE VIEW ExperimentSummary AS
SELECT e.ExperimentID, e.ExperimentName, e.Status, e.StartDate, e.EndDate,
       r.FullName AS Researcher, c.CellLineName
FROM Experiment e
JOIN Researcher r ON e.ResearcherID = r.ResearcherID
JOIN Experiment_CellLine ec ON e.ExperimentID = ec.ExperimentID
JOIN CellLine c ON ec.CellLineID = c.CellLineID;

SELECT * FROM ActiveCellLines;
SELECT * FROM ExperimentSummary;
