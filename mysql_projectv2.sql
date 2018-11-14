/*1st Create the  GeneID table before preceeding to the next steps.*/


/*Create the  GeneID table*/
DROP table if EXISTS `RNA_seq_Sample_info`;
DROP TABLE IF EXISTS `Ortholog`;
Drop TABLE if EXISTS `GeneID`;
DROP table if EXISTS `Organism`;
DROP table if EXISTS `Experimental_validation`;


/*Create the ortholog table*/

use data2;
CREATE TABLE `GeneID` (
	`id` int auto_increment KEY NOT NULL,
	`NCBI_ProteinID` varchar(255) NOT NULL,
    `NCBI_GeneID` varchar(255)  NULL,
    `Annotation` varchar(255)  NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Ortholog` (
  `id` INT auto_increment KEY NOT NULL,
  `ProteinIDA` int NOT NULL,
  `Organism` int DEFAULT NULL,
    `ProteinIDB` int NULL,
  `Experimental_condition` varchar(255) DEFAULT NULL,
  CONSTRAINT `Ortholog_ibfk_1` FOREIGN KEY (`ProteinIDA`) 
  REFERENCES `GeneID` (`id`) ON delete cascade,
  CONSTRAINT `Ortholog_ibfk_2` FOREIGN KEY (`ProteinIDB`) 
  REFERENCES `GeneID` (`id`) ON delete cascade  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Organism` (
  `Organism_id` int  auto_increment NOT NULL,
  `Organism_Type` varchar(255) NOT NULL,
  PRIMARY KEY (`Organism_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 


INSERT INTO `GeneID` (NCBI_ProteinID, NCBI_GeneID, Annotation)VALUES ('ProteinA1','GeneA1','Chromatin modeling'),('ProteinA2','GeneA2','RNA processing'),
('ProteinA3', 'GeneA3','Cellular Process'), ('ProteinA4','GeneA4','Mitchondria'),('ProteinA11','GeneA5','Chromatin Remodeling');

INSERT into `Organism` (Organism_Type) VALUES (' Mouse'),( 'Chicken'),('Bakers Yeast'),
('Catfish'),('Zebrafish');


select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null;


insert into ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values 
(
(select id from GeneID where NCBI_ProteinID = "ProteinA11"),
(select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null),
(select id from GeneID where NCBI_ProteinID = "ProteinA3"),
'Yeast-2-hybrid'
);

/*Query is testing with selecting the value before inserting*/
set @ValOne = (select id from GeneID where NCBI_ProteinID = "ProteinA1" and NCBI_ProteinID is not null);
set @ValTwo = (select id from GeneID where NCBI_ProteinID = "ProteinA4"  and NCBI_ProteinID is not null);
set @Org = (select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null);

insert into ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values 
(
(select @ValOne),
(select @Org),
(select @ValTwo),
'Yeast-2-hybrid' /*make into a id later*/
);

/*The RNA-seq information table*/
CREATE TABLE `RNA_seq_Sample_info` (
	`id`int auto_increment NOT NULL PRIMARY KEY,
	`ProteinNcbiID` varchar(255) NOT NULL,
    `Sample_info` varchar(255) DEFAULT NULL,
    `Expression` float DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

set @Val3 = (select id from geneid where NCBI_ProteinID ='ProteinA1');
set @Val4 = (select id from geneid where NCBI_ProteinID ='ProteinA4');
set @Val5 = (select id from geneid where NCBI_ProteinID ='ProteinA2');

INSERT into `RNA_seq_Sample_info`  (ProteinNcbiID, Sample_info, Expression) VALUES ((select  @Val3),'GSE13455',67.1),
((select  @Val3),'GSE134545',23.5),((select  @Val3),'GSE13456',89.1);

CREATE TABLE `Experimental_validation` (
	`id` int  auto_increment NOT NULL PRIMARY KEY,
    `Experimental_Type` varchar(255) DEFAULT NULL,
    `PubmedID` int DEFAULT NULL

)ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

INSERT into `Experimental_validation` (Experimental_Type, PubmedID) VALUES ('Yeast-2-Hybrid',123458),
('Mass Spec',234566),('Yeast-2-Hybrid',129586),
('Pull-down',123456);







