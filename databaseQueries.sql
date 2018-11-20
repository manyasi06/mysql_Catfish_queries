-- GeneID table functions include delete  that cascades, update and add.
-- remove a geneId and ortholog from a table  This is my M to M relationship
delete from GeneID where NCBI_ProteinID=:Input_ProteinID;

-- update the geneID
UPDATE GeneID SET GeneID = :newGeneID WHERE NCBI_ProteinID = (:Current_NCBIProteinID);

-- add a new annotation to the table
insert into GeneID ( NCBI_ProteinID, NCBI_GeneID, Annotation) Value ( :ProteinID, :GeneID, :Annotation);

-- get all the NCBI IDs from the annotation table
select NCBI_ProteinID, Annotation FROM GeneID Order by NCBI_ProteinID;

-- get all the proteins and orthologs
select NCBI_ProteinID, ProteinIDB, Annotation, Organism From GeneID as a
inner join Ortholog as b On a.NCBI_ProteinID = b.ProteinIDA order by Organism;



-- Add a new ortholog from GeneID and ortholog information;
insert into GeneID ( NCBI_ProteinID, NCBI_GeneID, Annotation) values (:proteinID , : geneID,:Annotation);
INSERT INTO Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) VALUES (:ProteinA1, :Mouse, :ProteinA4, :Y2Hybrid);
 
 
-- add to experiment the following information
 insert into experimental_validation (Experimental_Type) 
select ? from experimental_validation where not exists (select Experimental_Type from experimental_validation
	where Experimental_Type = ?)
Limit 1;


-- update the annotation
UPDATE GeneID SET Annotation = :annotationUpdate WHERE NCBI_ProteinID = :Current_NCBIProteinID;


-- This for the RNA-seq table
-- Select experiment information
select ProteinNcbiID, Sample_info, Expression from RNA_seq_Sample_info;

-- get a list of gene expression values and inner join with geneid table
select ra.id,ge.NCBI_ProteinID,ge.Annotation,ra.Sample_info,ra.Expression from rna_seq_sample_info as ra
inner join geneid as ge on ge.id = ra.ProteinNcbiID;

-- update the Experiment information
UPDATE RNA_seq_Sample_info SET Sample_info = :sampleName WHERE ProteinNcbiID = (:selected_ProteinId); 

-- delete RNA_seq_experiment
delete from RNA_seq_Sample_info where Sample_info =(:removeSample);

-- add new RNA-seq experiment FIXE THIS
INSERT INTO RNA_seq_Sample_info 
(ProteinNcbiID, Sample_info, Expression) 
select (
(select id from geneid where NCBI_ProteinID =?),
?,
?) 
-- add to organism
insert into organism (Organism_Type)
select ? from organism where not exists (select Organism_Type from Organism 
	where Organism_Type = ?)
Limit 1;


#Normalized Query
insert into ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) values ('ProteinA3',(select Organism_id from Organism where Organism_Type = "Zebrafish" and Organism_Type is not null),'ProteinA4','Yeast-2-hybrid');
