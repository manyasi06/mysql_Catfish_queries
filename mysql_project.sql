#SET foreign_key_checks = 0;

/*Create the  GeneID table*/
DROP table if EXISTS `RNA_seq_Sample_info`;
DROP TABLE IF EXISTS `Ortholog`;
Drop TABLE if EXISTS `GeneID`;

CREATE TABLE `GeneID` (
	`NCBI_ProteinID` varchar(255) NOT NULL PRIMARY KEY,
    `NCBI_GeneID` varchar(255) NOT NULL,
    `Annotation` varchar(255) NOT NULL
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
	`ProteinNcbiID` varchar(255) NOT NULL PRIMARY KEY,
    `Sample_info` varchar(255) DEFAULT NULL,
    `Expression` varchar(255) DEFAULT NULL,
	CONSTRAINT `RNA_seq_Sample_info` FOREIGN KEY (`ProteinNcbiID`)
		REFERENCES `GeneID`(`NCBI_ProteinID`) on delete cascade
)ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;


INSERT into `RNA_seq_Sample_info` VALUES ('ProteinA1','GSE13455','67.1'),
('ProteinA4','GSE134545','23.5'),('ProteinA2','GSE13456','89.1');



-- /* Experimental Validation Table */
DROP table if EXISTS `Experimental_validation`;

CREATE TABLE `Experimental_validation` (
	`id` varchar(255) NOT NULL PRIMARY KEY,
    `Experimental_Type` varchar(255) DEFAULT NULL,
    `PubmedID` varchar(255) DEFAULT NULL

)ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

INSERT into `Experimental_validation` VALUES ('1','Yeast-2-Hybrid','123458'),
('2','Mass Spec','234566'),('3','Yeast-2-Hybrid','CO-IP'),
('4','Pull-down','123456');


-- /*Create  the table for organism*/
DROP table if EXISTS `Organism`;

CREATE TABLE `Organism` (
  `Organism_id` varchar(255) NOT NULL,
  `Organism_Type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Organism_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 
   
 
INSERT into `Organism` VALUES ('1', ' Mouse'),('2', 'Chicken'),('3','Bakers Yeast'),
('4','Catfish'),('5','Zebrafish');


