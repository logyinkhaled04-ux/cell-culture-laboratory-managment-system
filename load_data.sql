USE CellCultureLabDB;

INSERT INTO Researcher (FullName, Email, Phone, Role, Department, DateJoined) VALUES
('Ahmed Hassan','ahmed.hassan@lab.edu','01010000001','Research Assistant','Cell Biology','2025-01-10'),
('Sara Ali','sara.ali@lab.edu','01010000002','Research Assistant','Cell Biology','2025-01-12'),
('Omar Khaled','omar.khaled@lab.edu','01010000003','Graduate Researcher','Biotechnology','2025-02-01'),
('Mariam Adel','mariam.adel@lab.edu','01010000004','Graduate Researcher','Biotechnology','2025-02-03'),
('Youssef Samir','youssef.samir@lab.edu','01010000005','Lab Specialist','Cell Culture','2025-02-10'),
('Nour Mostafa','nour.mostafa@lab.edu','01010000006','Research Assistant','Cell Culture','2025-02-14'),
('Hana Mahmoud','hana.mahmoud@lab.edu','01010000007','Graduate Researcher','Molecular Biology','2025-03-01'),
('Karim Tarek','karim.tarek@lab.edu','01010000008','Lab Specialist','Molecular Biology','2025-03-05'),
('Laila Sameh','laila.sameh@lab.edu','01010000009','Research Assistant','Cell Biology','2025-03-10'),
('Amr Nabil','amr.nabil@lab.edu','01010000010','Graduate Researcher','Biotechnology','2025-03-12');

INSERT INTO CellLine (CellLineName, Origin, Species, TissueType, AuthenticationStatus, IsActive, MaintainedBy) VALUES
('HeLa','Cervical carcinoma','Human','Cervix','Authenticated',1,1),
('HEK293','Embryonic kidney','Human','Kidney','Authenticated',1,2),
('A549','Lung carcinoma','Human','Lung','Authenticated',1,3),
('MCF-7','Breast adenocarcinoma','Human','Breast','Authenticated',1,4),
('HepG2','Hepatocellular carcinoma','Human','Liver','Authenticated',1,5),
('CHO','Chinese hamster ovary','Hamster','Ovary','Authenticated',1,6),
('NIH3T3','Embryonic fibroblast','Mouse','Fibroblast','Authenticated',1,7),
('Jurkat','T-cell leukemia','Human','Blood','Authenticated',1,8),
('SH-SY5Y','Neuroblastoma','Human','Neural','Authenticated',1,9),
('C2C12','Myoblast','Mouse','Muscle','Authenticated',1,10);

INSERT INTO Experiment (ExperimentName, Description, StartDate, EndDate, Objective, Status, ResearcherID) VALUES
('HeLa Growth Study','Monitor HeLa proliferation under standard conditions','2026-03-01','2026-03-08','Evaluate growth pattern','Completed',1),
('HEK293 Culture Study','Assess HEK293 routine culture performance','2026-03-02','2026-03-09','Optimize routine culture','Completed',2),
('A549 Viability Study','Measure A549 viability after media change','2026-03-03','2026-03-10','Assess viability','Completed',3),
('MCF7 Morphology Study','Monitor morphology during culture','2026-03-04',NULL,'Document morphology','Running',4),
('HepG2 Media Study','Compare culture performance in complete medium','2026-03-05','2026-03-12','Evaluate media suitability','Completed',5),
('CHO Expansion Study','Expand CHO cells for downstream use','2026-03-06',NULL,'Increase cell number','Running',6),
('NIH3T3 Passage Study','Follow serial passage behavior','2026-03-07','2026-03-14','Evaluate passage stability','Completed',7),
('Jurkat Viability Test','Assess viability of suspension cells','2026-03-08','2026-03-11','Check culture quality','Completed',8),
('SH-SY5Y Differentiation','Prepare SH-SY5Y culture for differentiation','2026-03-09',NULL,'Initiate differentiation workflow','Planned',9),
('C2C12 Differentiation','Prepare C2C12 cells for myogenic differentiation','2026-03-10',NULL,'Evaluate differentiation conditions','Planned',10);

INSERT INTO Experiment_CellLine (ExperimentID, CellLineID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(1,2),(5,3);

INSERT INTO Incubator (IncubatorName, Model, Manufacturer, Temperature, CO2Percent, Location, Status) VALUES
('Incubator A','MCO-170AIC','PHCbi',37.0,5.0,'Room 101','Available'),
('Incubator B','Heracell VIOS 160i','Thermo Fisher',37.0,5.0,'Room 101','Available'),
('Incubator C','CB 170','Binder',37.0,5.0,'Room 102','Available'),
('Incubator D','MCO-230AIC','PHCbi',37.0,5.0,'Room 102','Available'),
('Incubator E','ICO150','Memmert',37.0,5.0,'Room 103','Available'),
('Incubator F','Heracell 150i','Thermo Fisher',37.0,5.0,'Room 103','Maintenance'),
('Incubator G','CB 160','Binder',37.0,5.0,'Room 104','Available'),
('Incubator H','MCO-170M','PHCbi',37.0,5.0,'Room 104','Available'),
('Incubator I','ICO105','Memmert',37.0,5.0,'Room 105','Available'),
('Incubator J','Heracell VIOS 250i','Thermo Fisher',37.0,5.0,'Room 105','Available');

INSERT INTO CultureVessel (CellLineID, IncubatorID, VesselType, SurfaceArea, Coating, CurrentVolume, Status, DateInUse) VALUES
(1,1,'T75 Flask',75.00,'None',15.00,'Active','2026-03-01'),
(2,2,'T75 Flask',75.00,'None',15.00,'Active','2026-03-02'),
(3,3,'T25 Flask',25.00,'None',5.00,'Active','2026-03-03'),
(4,4,'6-well Plate',57.00,'None',12.00,'Active','2026-03-04'),
(5,5,'T75 Flask',75.00,'Collagen',15.00,'Active','2026-03-05'),
(6,6,'T175 Flask',175.00,'None',35.00,'Active','2026-03-06'),
(7,7,'T75 Flask',75.00,'None',15.00,'Active','2026-03-07'),
(8,8,'T25 Flask',25.00,'None',5.00,'Active','2026-03-08'),
(9,9,'6-well Plate',57.00,'Poly-D-Lysine',12.00,'Active','2026-03-09'),
(10,10,'T75 Flask',75.00,'Collagen',15.00,'Active','2026-03-10');

INSERT INTO Media (MediaName, Brand, BaseType, SupplementDetails, ExpirationDate) VALUES
('DMEM High Glucose','Gibco','DMEM','10% FBS + 1% Pen/Strep','2027-01-15'),
('DMEM/F12','Gibco','DMEM/F12','10% FBS + 1% Pen/Strep','2027-02-10'),
('RPMI 1640','Gibco','RPMI','10% FBS + 1% Pen/Strep','2027-03-01'),
('MEM','Corning','MEM','10% FBS + NEAA','2027-03-15'),
('EMEM','ATCC','EMEM','10% FBS','2027-04-01'),
('Ham F12','Gibco','F12','10% FBS','2027-04-20'),
('DMEM Low Glucose','Gibco','DMEM','10% FBS + 1% Pen/Strep','2027-05-05'),
('RPMI Complete','Lonza','RPMI','10% FBS + L-glutamine','2027-05-22'),
('Neurobasal','Gibco','Neurobasal','B27 + L-glutamine','2027-06-10'),
('Differentiation Medium','Custom','DMEM','2% Horse Serum','2027-06-30');

INSERT INTO Passage (VesselID, MediaID, PassageNumber, SplitRatio, SeedingDate, PerformedBy, NextPassageDue, Notes) VALUES
(1,1,12,'1:5','2026-03-01',1,'2026-03-04','Routine HeLa passage'),
(2,2,8,'1:4','2026-03-02',2,'2026-03-05','Routine HEK293 passage'),
(3,1,15,'1:3','2026-03-03',3,'2026-03-06','A549 passage'),
(4,1,22,'1:4','2026-03-04',4,'2026-03-07','MCF-7 passage'),
(5,5,10,'1:3','2026-03-05',5,'2026-03-08','HepG2 passage'),
(6,6,6,'1:5','2026-03-06',6,'2026-03-09','CHO expansion passage'),
(7,7,18,'1:4','2026-03-07',7,'2026-03-10','NIH3T3 passage'),
(8,8,11,'1:2','2026-03-08',8,'2026-03-10','Jurkat split'),
(9,9,14,'1:3','2026-03-09',9,'2026-03-12','SH-SY5Y culture'),
(10,10,9,'1:4','2026-03-10',10,'2026-03-13','C2C12 culture');

INSERT INTO Observation (VesselID, ObservationDateTime, ObservedBy, Morphology, ConfluencyPercent, Notes, AttachmentPath) VALUES
(1,'2026-03-02 10:00:00',1,'Adherent epithelial morphology',70.0,'Healthy culture','images/hela_01.jpg'),
(2,'2026-03-03 10:15:00',2,'Adherent polygonal cells',75.0,'Normal appearance','images/hek293_01.jpg'),
(3,'2026-03-04 09:45:00',3,'Epithelial-like morphology',68.0,'No visible contamination','images/a549_01.jpg'),
(4,'2026-03-05 11:00:00',4,'Cobblestone morphology',72.0,'Good attachment','images/mcf7_01.jpg'),
(5,'2026-03-06 10:30:00',5,'Polygonal hepatocyte-like morphology',80.0,'Healthy monolayer','images/hepg2_01.jpg'),
(6,'2026-03-07 09:30:00',6,'Adherent epithelial-like morphology',65.0,'Expansion proceeding normally','images/cho_01.jpg'),
(7,'2026-03-08 10:10:00',7,'Fibroblast-like morphology',78.0,'Healthy culture','images/nih3t3_01.jpg'),
(8,'2026-03-09 11:20:00',8,'Suspension round cells',60.0,'Good cell density','images/jurkat_01.jpg'),
(9,'2026-03-10 09:50:00',9,'Neuronal-like morphology',55.0,'Ready for next step','images/shsy5y_01.jpg'),
(10,'2026-03-11 10:40:00',10,'Myoblast morphology',74.0,'Healthy growth','images/c2c12_01.jpg');

INSERT INTO CryopreservedStock (CellLineID, FreezeDate, VialID, StorageLocationID, FreezeMedium, ViabilityPercent, Notes) VALUES
(1,'2026-02-01','VIAL-HL-001','LN2-A1','90% FBS + 10% DMSO',95.0,'Master stock'),
(2,'2026-02-02','VIAL-HEK-001','LN2-A2','90% FBS + 10% DMSO',94.0,'Master stock'),
(3,'2026-02-03','VIAL-A549-001','LN2-A3','90% FBS + 10% DMSO',93.0,'Working stock'),
(4,'2026-02-04','VIAL-MCF7-001','LN2-A4','90% FBS + 10% DMSO',92.0,'Working stock'),
(5,'2026-02-05','VIAL-HEPG2-001','LN2-B1','90% FBS + 10% DMSO',96.0,'Master stock'),
(6,'2026-02-06','VIAL-CHO-001','LN2-B2','90% FBS + 10% DMSO',95.0,'Master stock'),
(7,'2026-02-07','VIAL-NIH-001','LN2-B3','90% FBS + 10% DMSO',91.0,'Working stock'),
(8,'2026-02-08','VIAL-JURKAT-001','LN2-B4','90% FBS + 10% DMSO',90.0,'Working stock'),
(9,'2026-02-09','VIAL-SHSY5Y-001','LN2-C1','90% FBS + 10% DMSO',94.0,'Master stock'),
(10,'2026-02-10','VIAL-C2C12-001','LN2-C2','90% FBS + 10% DMSO',93.0,'Master stock');

INSERT INTO Instrument (InstrumentName, Model, Manufacturer, Location, Status) VALUES
('Inverted Microscope','CKX53','Olympus','Room 101','Available'),
('Automated Cell Counter','Countess 3','Thermo Fisher','Room 101','Available'),
('Plate Reader','Synergy H1','BioTek','Room 102','Available'),
('Centrifuge','5810R','Eppendorf','Room 102','Available'),
('Biosafety Cabinet','Safe 2020','Thermo Fisher','Room 103','Available'),
('Mycoplasma Detector','MycoAlert','Lonza','Room 103','Available'),
('PCR System','QuantStudio 5','Applied Biosystems','Room 104','Available'),
('CO2 Analyzer','Fyrite','Bacharach','Room 104','Available'),
('Freezer Monitor','T-TEC 7','T-TEC','Storage Room','Available'),
('Water Bath','WNB14','Memmert','Room 105','Available');

INSERT INTO ContaminationTest (PassageID, InstrumentID, TestDate, TestType, Result, PerformedBy, Notes) VALUES
(1,6,'2026-02-02','Mycoplasma','Negative',1,'No contamination detected'),
(2,6,'2026-02-03','Mycoplasma','Negative',2,'No contamination detected'),
(3,7,'2026-02-04','Bacterial','Negative',3,'No bacterial growth'),
(4,6,'2026-02-05','Mycoplasma','Negative',4,'No contamination detected'),
(5,7,'2026-02-06','Fungal','Negative',5,'No fungal contamination'),
(6,6,'2026-02-07','Mycoplasma','Negative',6,'No contamination detected'),
(7,7,'2026-02-08','Bacterial','Negative',7,'No bacterial contamination'),
(8,6,'2026-02-09','Mycoplasma','Inconclusive',8,'Repeat testing recommended'),
(9,6,'2026-02-10','Mycoplasma','Negative',9,'No contamination detected'),
(10,7,'2026-02-11','Fungal','Negative',10,'No fungal contamination');
