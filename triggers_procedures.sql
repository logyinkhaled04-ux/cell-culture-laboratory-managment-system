USE CellCultureLabDB;

DROP TRIGGER IF EXISTS trg_prevent_observation_on_disposed_vessel;
DELIMITER $$
CREATE TRIGGER trg_prevent_observation_on_disposed_vessel
BEFORE INSERT ON Observation
FOR EACH ROW
BEGIN
    DECLARE vessel_status VARCHAR(30);
    SELECT Status INTO vessel_status
    FROM CultureVessel
    WHERE VesselID = NEW.VesselID;

    IF vessel_status = 'Disposed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Observation cannot be added to a disposed culture vessel.';
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS GetCellLineHistory;
DELIMITER $$
CREATE PROCEDURE GetCellLineHistory(IN p_CellLineID INT)
BEGIN
    SELECT c.CellLineName, v.VesselID, v.VesselType,
           p.PassageNumber, p.SeedingDate, m.MediaName,
           r.FullName AS PerformedBy
    FROM CellLine c
    JOIN CultureVessel v ON c.CellLineID = v.CellLineID
    LEFT JOIN Passage p ON v.VesselID = p.VesselID
    LEFT JOIN Media m ON p.MediaID = m.MediaID
    LEFT JOIN Researcher r ON p.PerformedBy = r.ResearcherID
    WHERE c.CellLineID = p_CellLineID
    ORDER BY p.SeedingDate;
END$$
DELIMITER ;

CALL GetCellLineHistory(1);
