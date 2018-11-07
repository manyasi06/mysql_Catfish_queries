#SET foreign_key_checks = 0;

/*Create the  GeneID table*/
DROP table if EXISTS `RNA_seq_Sample_info`;
DROP TABLE IF EXISTS `Ortholog`;
Drop TABLE if EXISTS `GeneID`;
DROP table if EXISTS `Organism`;
DROP table if EXISTS `Experimental_validation`;


CREATE TABLE `Organism` (
  `Organism_id` int  auto_increment NOT NULL,
  `Organism_Type` varchar(255) NOT NULL,
  PRIMARY KEY (`Organism_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 
   
 
INSERT into `Organism` (Organism_Type) VALUES (' Mouse'),( 'Chicken'),('Bakers Yeast'),
('Catfish'),('Zebrafish');

CREATE TABLE `GeneID` (
	`NCBI_ProteinID` varchar(255) NOT NULL PRIMARY KEY,
    `NCBI_GeneID` varchar(255)  NULL,
    `Annotation` varchar(255)  NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `GeneID` VALUES ('ProteinA1','GeneA1','Chromatin modeling'),('ProteinA2','GeneA2','RNA processing'),
('ProteinA3', 'GeneA3','Cellular Process'), ('ProteinA4','GeneA4','Mitchondria'),('ProteinA11','GeneA5','Chromatin Remodeling');


/*Create the ortholog table*/


CREATE TABLE `Ortholog` (
  `ProteinIDA` varchar(255) NOT NULL,
  `Organism` varchar(255) DEFAULT NULL,
    `ProteinIDB` varchar(255) NULL,
  `Experimental_condition` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ProteinIDA`),
  CONSTRAINT `Ortholog_ibfk_1` FOREIGN KEY (`ProteinIDA`) 
  REFERENCES `GeneID` (`NCBI_ProteinID`) ON delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


 INSERT INTO `Ortholog` VALUES ('ProteinA1','Mouse','ProteinA4','Y2Hybrid'),
('ProteinA11','Ecoli','ProteinAZ2','Y2Hybrid'),('ProteinA2','Yeast','ProteinAZ3','Y2Hybrid'),
('ProteinA3','Yeast','ProteinAZ4','Y2Hybrid');


/*Create the Sample info table*/


CREATE TABLE `RNA_seq_Sample_info` (
	`id`int auto_increment NOT NULL PRIMARY KEY,
	`ProteinNcbiID` varchar(255) NOT NULL,
    `Sample_info` varchar(255) DEFAULT NULL,
    `Expression` float DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT into `RNA_seq_Sample_info`  (ProteinNcbiID, Sample_info, Expression) VALUES ('ProteinA1','GSE13455',67.1),
('ProteinA4','GSE134545',23.5),('ProteinA2','GSE13456',89.1);



-- /* Experimental Validation Table */

CREATE TABLE `Experimental_validation` (
	`id` int  auto_increment NOT NULL PRIMARY KEY,
    `Experimental_Type` varchar(255) DEFAULT NULL,
    `PubmedID` int DEFAULT NULL

)ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

INSERT into `Experimental_validation` (Experimental_Type, PubmedID) VALUES ('Yeast-2-Hybrid',123458),
('Mass Spec',234566),('Yeast-2-Hybrid',129586),
('Pull-down',123456);




