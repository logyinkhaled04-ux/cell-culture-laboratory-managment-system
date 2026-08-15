DROP DATABASE IF EXISTS CellCultureLabDB;
CREATE DATABASE CellCultureLabDB;
USE CellCultureLabDB;

CREATE TABLE Researcher (
    ResearcherID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Role VARCHAR(50),
    Department VARCHAR(100),
    DateJoined DATE
);

CREATE TABLE CellLine (
    CellLineID INT AUTO_INCREMENT PRIMARY KEY,
    CellLineName VARCHAR(100) NOT NULL,
    Origin VARCHAR(100),
    Species VARCHAR(100),
    TissueType VARCHAR(100),
    AuthenticationStatus VARCHAR(50),
    IsActive BOOLEAN DEFAULT TRUE,
    MaintainedBy INT,
    CONSTRAINT fk_cellline_researcher FOREIGN KEY (MaintainedBy)
        REFERENCES Researcher(ResearcherID) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Experiment (
    ExperimentID INT AUTO_INCREMENT PRIMARY KEY,
    ExperimentName VARCHAR(150) NOT NULL,
    Description TEXT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Objective TEXT,
    Status VARCHAR(30),
    ResearcherID INT NOT NULL,
    CONSTRAINT fk_experiment_researcher FOREIGN KEY (ResearcherID)
        REFERENCES Researcher(ResearcherID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_experiment_dates CHECK (EndDate IS NULL OR EndDate >= StartDate)
);

CREATE TABLE Experiment_CellLine (
    ExperimentID INT NOT NULL,
    CellLineID INT NOT NULL,
    PRIMARY KEY (ExperimentID, CellLineID),
    CONSTRAINT fk_exp_cell_experiment FOREIGN KEY (ExperimentID)
        REFERENCES Experiment(ExperimentID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_exp_cell_cellline FOREIGN KEY (CellLineID)
        REFERENCES CellLine(CellLineID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Incubator (
    IncubatorID INT AUTO_INCREMENT PRIMARY KEY,
    IncubatorName VARCHAR(100) NOT NULL,
    Model VARCHAR(100),
    Manufacturer VARCHAR(100),
    Temperature DECIMAL(4,1) DEFAULT 37.0,
    CO2Percent DECIMAL(4,1) DEFAULT 5.0,
    Location VARCHAR(100),
    Status VARCHAR(30) DEFAULT 'Available',
    CONSTRAINT chk_temperature CHECK (Temperature > 0),
    CONSTRAINT chk_co2 CHECK (CO2Percent BETWEEN 0 AND 100)
);

CREATE TABLE CultureVessel (
    VesselID INT AUTO_INCREMENT PRIMARY KEY,
    CellLineID INT NOT NULL,
    IncubatorID INT,
    VesselType VARCHAR(50) NOT NULL,
    SurfaceArea DECIMAL(8,2),
    Coating VARCHAR(100),
    CurrentVolume DECIMAL(8,2),
    Status VARCHAR(30),
    DateInUse DATE,
    CONSTRAINT fk_vessel_cellline FOREIGN KEY (CellLineID)
        REFERENCES CellLine(CellLineID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_vessel_incubator FOREIGN KEY (IncubatorID)
        REFERENCES Incubator(IncubatorID) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT chk_surface_area CHECK (SurfaceArea IS NULL OR SurfaceArea > 0),
    CONSTRAINT chk_volume CHECK (CurrentVolume IS NULL OR CurrentVolume >= 0)
);

CREATE TABLE Media (
    MediaID INT AUTO_INCREMENT PRIMARY KEY,
    MediaName VARCHAR(100) NOT NULL,
    Brand VARCHAR(100),
    BaseType VARCHAR(100),
    SupplementDetails TEXT,
    ExpirationDate DATE
);

CREATE TABLE Passage (
    PassageID INT AUTO_INCREMENT PRIMARY KEY,
    VesselID INT NOT NULL,
    MediaID INT NOT NULL,
    PassageNumber INT NOT NULL,
    SplitRatio VARCHAR(20),
    SeedingDate DATE NOT NULL,
    PerformedBy INT NOT NULL,
    NextPassageDue DATE,
    Notes TEXT,
    CONSTRAINT fk_passage_vessel FOREIGN KEY (VesselID)
        REFERENCES CultureVessel(VesselID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_passage_media FOREIGN KEY (MediaID)
        REFERENCES Media(MediaID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_passage_researcher FOREIGN KEY (PerformedBy)
        REFERENCES Researcher(ResearcherID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_passage_number CHECK (PassageNumber >= 0)
);

CREATE TABLE Observation (
    ObservationID INT AUTO_INCREMENT PRIMARY KEY,
    VesselID INT NOT NULL,
    ObservationDateTime DATETIME NOT NULL,
    ObservedBy INT NOT NULL,
    Morphology VARCHAR(200),
    ConfluencyPercent DECIMAL(5,2),
    Notes TEXT,
    AttachmentPath VARCHAR(255),
    CONSTRAINT fk_observation_vessel FOREIGN KEY (VesselID)
        REFERENCES CultureVessel(VesselID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_observation_researcher FOREIGN KEY (ObservedBy)
        REFERENCES Researcher(ResearcherID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_confluency CHECK (ConfluencyPercent BETWEEN 0 AND 100)
);

CREATE TABLE CryopreservedStock (
    StockID INT AUTO_INCREMENT PRIMARY KEY,
    CellLineID INT NOT NULL,
    FreezeDate DATE NOT NULL,
    VialID VARCHAR(50) NOT NULL UNIQUE,
    StorageLocationID VARCHAR(100),
    FreezeMedium VARCHAR(100),
    ViabilityPercent DECIMAL(5,2),
    Notes TEXT,
    CONSTRAINT fk_stock_cellline FOREIGN KEY (CellLineID)
        REFERENCES CellLine(CellLineID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_viability CHECK (ViabilityPercent BETWEEN 0 AND 100)
);

CREATE TABLE Instrument (
    InstrumentID INT AUTO_INCREMENT PRIMARY KEY,
    InstrumentName VARCHAR(100) NOT NULL,
    Model VARCHAR(100),
    Manufacturer VARCHAR(100),
    Location VARCHAR(100),
    Status VARCHAR(30) DEFAULT 'Available'
);

CREATE TABLE ContaminationTest (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    PassageID INT NOT NULL,
    InstrumentID INT,
    TestDate DATE NOT NULL,
    TestType VARCHAR(100) NOT NULL,
    Result VARCHAR(50) NOT NULL,
    PerformedBy INT NOT NULL,
    Notes TEXT,
    CONSTRAINT fk_test_passage FOREIGN KEY (PassageID)
        REFERENCES Passage(PassageID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_test_instrument FOREIGN KEY (InstrumentID)
        REFERENCES Instrument(InstrumentID) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_test_researcher FOREIGN KEY (PerformedBy)
        REFERENCES Researcher(ResearcherID) ON UPDATE CASCADE ON DELETE RESTRICT
);
