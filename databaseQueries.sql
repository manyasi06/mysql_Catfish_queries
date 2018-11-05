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

-- add data for the organism table
insert into Organism (Organism_id, Organism_Type) Value (:Org_id, :type_of_organism);

-- Add a new ortholog from GeneID and ortholog information;
insert into GeneID ( NCBI_ProteinID, NCBI_GeneID, Annotation) values (:proteinID , : geneID,:Annotation);
INSERT INTO Ortholog (ProteinIDA, Organism, ProteinIDB, Experimental_condition) VALUES (:ProteinA1, :Mouse, :ProteinA4, :Y2Hybrid);
 
-- update the annotation
UPDATE GeneID SET Annotation = :annotationUpdate WHERE NCBI_ProteinID = :Current_NCBIProteinID;


-- This for the RNA-seq table
-- Select experiment information
select ProteinNcbiID, Sample_info, Expression from RNA_seq_Sample_info;

-- get a single character's data for the Update People form
SELECT ProteinNCbiID, Sample_info,Expression FROM RNA_seq_Sample_info WHERE ProteinNCbiID = :proteinID_A_selected;

-- update the Experiment information
UPDATE RNA_seq_Sample_info SET Sample_info = :sampleName WHERE ProteinNcbiID = (:selected_ProteinId); 

-- delete RNA_seq_experiment
delete from RNA_seq_Sample_info where Sample_info =(:removeSample);

-- add new RNA-seq experiment
INSERT INTO RNA_seq_Sample_info (ProteinNcbiID, Sample_info, Expression) values (:PI_ID, :Sample_ID, :Expression_val);
