/*1st Create the  GeneID table before preceeding to the next steps.*/


/*Create the  GeneID table*/
DROP table if EXISTS `RNA_seq_Sample_info`;
DROP TABLE IF EXISTS `Ortholog`;
Drop TABLE if EXISTS `GeneID`;
DROP table if EXISTS `Organism`;
DROP table if EXISTS `Experimental_validation`;


/*Create the Ortholog table*/


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


/*Modification removed the many to 1 interaction for the pubmed IDS
The table will only have a unique id for the experiment as well as the Type of the experiment
NOTE: Remove pubmed from the table statement.alter*/
CREATE TABLE `Experimental_validation` (
	`id` int  auto_increment NOT NULL PRIMARY KEY,
    `Experimental_Type` varchar(255) DEFAULT NULL

)ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

INSERT into `Experimental_validation` (Experimental_Type) VALUES 
('Mass Spec'),('Yeast-2-Hybrid'),
('Pull-down');



insert into Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values 
(
(select id from GeneID where NCBI_ProteinID = "ProteinA11" and NCBI_ProteinID is not null),
(select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null),
(select id from GeneID where NCBI_ProteinID = "ProteinA3" and NCBI_ProteinID is not null),
(select id from Experimental_validation where Experimental_Type = "Yeast-2-hybrid" and Experimental_Type is not null)
);

insert into Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values 
(
(select id from GeneID where NCBI_ProteinID = "ProteinA11" and NCBI_ProteinID is not null),
(select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null),
(select id from GeneID where NCBI_ProteinID = "ProteinA2" and NCBI_ProteinID is not null),
(select id from Experimental_validation where Experimental_Type = "Yeast-2-hybrid" and Experimental_Type is not null)
);

insert into Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values 
(
(select id from GeneID where NCBI_ProteinID = "ProteinA1" and NCBI_ProteinID is not null),
(select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null),
(select id from GeneID where NCBI_ProteinID = "ProteinA11" and NCBI_ProteinID is not null),
(select id from Experimental_validation where Experimental_Type = "Yeast-2-hybrid" and Experimental_Type is not null)
);

/*Query is testing with selecting the value before inserting*/
set @ValOne = (select id from GeneID where NCBI_ProteinID = "ProteinA1" and NCBI_ProteinID is not null);
set @ValTwo = (select id from GeneID where NCBI_ProteinID = "ProteinA4"  and NCBI_ProteinID is not null);
set @Org = (select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null);
set @Exp = (select id from Experimental_validation where Experimental_Type = "Yeast-2-hybrid" and Experimental_Type is not null);

insert into Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values 
(
(select @ValOne),
(select @Org),
(select @ValTwo),
(select @Exp) /*make into a id later*/
);

/*The RNA-seq information table*/
CREATE TABLE `RNA_seq_Sample_info` (
	`id`int auto_increment NOT NULL PRIMARY KEY,
	`ProteinNcbiID` varchar(255) NOT NULL,
    `Sample_info` varchar(255) DEFAULT NULL,
    `Expression` float DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

set @Val3 = (select id from GeneID where NCBI_ProteinID ='ProteinA1');
set @Val4 = (select id from GeneID where NCBI_ProteinID ='ProteinA4');
set @Val5 = (select id from GeneID where NCBI_ProteinID ='ProteinA2');

INSERT into `RNA_seq_Sample_info`  (ProteinNcbiID, Sample_info, Expression) VALUES ((select  @Val3),'GSE13455',67.1),
((select  @Val3),'GSE134545',23.5),((select  @Val3),'GSE13456',89.1);









