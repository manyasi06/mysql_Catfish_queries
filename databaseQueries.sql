#insert into GeneID values ('ProteinA5','GeneID','IGF5');
-- remove a geneId and ortholog from a table
delete from GeneID where NCBI_ProteinID=:Input_ProteinID;

-- get all the NCBI IDs from the annotation table
select NCBI_ProteinID, Annotation FROM GeneID;

-- get all the proteins and orthologs
select NCBI_ProteinID, ProteinIDB, Annotation, Organism From GeneID as a
inner join Ortholog as b On a.NCBI_ProteinID = b.ProteinIDA;


-- get a single character's data for the Update People form
SELECT ProteinNCbiID, Sample_info,Expression FROM RNA_seq_Sample_info WHERE ProteinNCbiID = :proteinID_A_selected;

-- select all the gene annotation table
select NCBI_ProteinID, NCBI_GeneID, Annotation from GeneID;

-- add a new annotation to the table
insert into GeneID ( NCBI_ProteinID, NCBI_GeneID, Annotation) Value ( :ProteinID, :GeneID, :Annotation);

-- delete a ortholog
delete from Ortholog where ProteinIDA = :ProteinID_input;

-- Add a new ortholog from GeneID and ortholog information;
insert into GeneID ( NCBI_ProteinID, NCBI_GeneID, Annotation) values (:proteinID , : geneID,:Annotation);
INSERT INTO Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) VALUES (:ProteinA1, :Mouse, :ProteinA4, :Y2Hybrid);
 
 
-- update the annotation
UPDATE GeneID SET Annotation = :annotationUpdate WHERE NCBI_ProteinID = :Current_NCBIProteinID;

-- Select experiment information
select * from RNA_seq_Sample_info;

-- update the Experiment information
UPDATE RNA_seq_Sample_info SET Sample_info = :sampleName WHERE ProteinNcbiID = :selected_ProteinId; 
