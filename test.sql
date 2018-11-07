select * from ortholog;






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

select * from ortholog;

select g.NCBI_GeneID,g2.NCBI_GeneID, g.Annotation,g2.Annotation from Ortholog as o
inner join geneid as g on g.id = o.ProteinIDA 
inner join geneid as g2 on g2.id = o.ProteinIDB;
