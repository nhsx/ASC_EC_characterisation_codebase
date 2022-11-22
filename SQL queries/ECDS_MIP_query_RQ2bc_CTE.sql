
WITH MPI_CTE (Pseudo_NHS_Number, Care_Home_Flag, Care_Home_Service_Type, CCG_of_Residence)

AS
-- Define MIP QUERY
(
	SELECT Pseudo_NHS_Number,
	(CASE WHEN Care_Home_Flag IS NULL THEN 0 ELSE 1 END),
	lower(Care_Home_Service_Type),
	[CCG_of_Residence]
	FROM [NHSE_MPI].[mpi].[NHAIS_MPI_Latest]
	---WHERE Death_Month IS NULL AND 
	---Country_Code = 'E92000001' AND
	WHERE Pseudo_NHS_Number!=0
	)
,
ECDS_CTE_rq2bc (EC_Ident, Der_Pseudo_NHS_Number, Sex, [Der_Age_At_CDS_Activity_Date], [EC_Chief_Complaint_SNOMED_CT])

AS
--- Define ECDS RQ2bc query
( 
	SELECT EC_Ident, Der_Pseudo_NHS_Number, Sex, [Der_Age_At_CDS_Activity_Date], [EC_Chief_Complaint_SNOMED_CT]
	FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC]
	WHERE [Der_Financial_Year]='2021/22'
	)

SELECT *
INTO #aux_rq2a2b
FROM ECDS_CTE_rq2bc
LEFT JOIN MPI_CTE
ON ECDS_CTE_rq2bc.Der_Pseudo_NHS_Number = MPI_CTE.Pseudo_NHS_Number


--USE [NHSE_Sandbox_EmpowerThePerson]
--GO

DROP TABLE [NHSE_PSDM_0037].[dbo].[MFonseca_EC_MPI_2122_q2bc]

SELECT TOP 1000 * FROM #aux_rq2a2b

--- slightly aggregate view
SELECT Sex,
Der_Age_At_CDS_Activity_Date,
EC_Chief_Complaint_SNOMED_CT,
Care_Home_Flag,
Care_Home_Service_Type,
CCG_of_Residence,
COUNT(EC_Ident) n
INTO [NHSE_PSDM_0037].[dbo].[MFonseca_EC_MPI_2122_q2bc]
FROM  #aux_rq2a2b
GROUP BY Sex,
Der_Age_At_CDS_Activity_Date,
EC_Chief_Complaint_SNOMED_CT,
Care_Home_Flag,
Care_Home_Service_Type,
CCG_of_Residence



SELECT TOP 1000 * FROM [NHSE_PSDM_0037].[dbo].[MFonseca_EC_MPI_2122_q2bc]

/**
SELECT Care_Home_Flag, COUNT(DISTINCT Pseudo_NHS_Number)
FROM MIP_CTE
GROUP BY Care_Home_Flag
**/


------- SECOND COMMON REFERENCE TABLE ON ACUITY , DEPARTMENT TYPE, OUTCOME . PLUS COVARIATES CARE HOME, LOCATION, AGE, GENDER



WITH MPI_CTE_rq1 (Pseudo_NHS_Number, Care_Home_Flag, Care_Home_Service_Type, CCG_of_Residence)

AS
-- Define MIP QUERY
(
	SELECT Pseudo_NHS_Number,
	(CASE WHEN Care_Home_Flag IS NULL THEN 0 ELSE 1 END),
	lower(Care_Home_Service_Type),
	[CCG_of_Residence]
	FROM [NHSE_MPI].[mpi].[NHAIS_MPI_Latest]
	---WHERE Death_Month IS NULL AND 
	---Country_Code = 'E92000001' AND
	WHERE Pseudo_NHS_Number!=0
	)
,
ECDS_CTE_rq1cde (EC_Ident, Der_Pseudo_NHS_Number, Sex, [Der_Age_At_CDS_Activity_Date], [EC_Acuity_SNOMED_CT])

AS
--- Define ECDS RQ2bc query
( 
	SELECT EC_Ident, Der_Pseudo_NHS_Number, Sex, [Der_Age_At_CDS_Activity_Date], [EC_Acuity_SNOMED_CT]
	FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC]
	WHERE [Der_Financial_Year]='2021/22'
	)
,
ECDS_PAT_CTE_rq1cde (EC_Ident , [Pat_Der_Dimention_1],[Pat_Der_Dimention_6])

AS
--- Define ECDS PAT RQ2bc query
(SELECT [EC_Ident],[Pat_Der_Dimention_1],[Pat_Der_Dimention_6]
FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT])

SELECT T1.EC_Ident, T1.Der_Pseudo_NHS_Number, T1.Sex, T1.[Der_Age_At_CDS_Activity_Date], T1.[EC_Acuity_SNOMED_CT], T1.Care_Home_Flag, T1.Care_Home_Service_Type, T1.CCG_of_Residence, T2.[Pat_Der_Dimention_1], T2.[Pat_Der_Dimention_6]
INTO  #aux_rq1cde
FROM
(SELECT EC_Ident, Der_Pseudo_NHS_Number, Sex, [Der_Age_At_CDS_Activity_Date], [EC_Acuity_SNOMED_CT], Care_Home_Flag, Care_Home_Service_Type, CCG_of_Residence
FROM ECDS_CTE_rq1cde
LEFT JOIN MPI_CTE_rq1
ON ECDS_CTE_rq1cde.Der_Pseudo_NHS_Number = MPI_CTE_rq1.Pseudo_NHS_Number) AS T1
LEFT JOIN ECDS_PAT_CTE_rq1cde AS T2
ON T1.EC_Ident = T2.EC_Ident


--- slightly aggregate view
SELECT Sex,
Der_Age_At_CDS_Activity_Date,
Care_Home_Flag,
Care_Home_Service_Type,
CCG_of_Residence,
[EC_Acuity_SNOMED_CT],
[Pat_Der_Dimention_1],
[Pat_Der_Dimention_6],
COUNT(EC_Ident) n
INTO [NHSE_PSDM_0037].[dbo].[MFonseca_EC_MPI_2122_q1cde]
FROM  #aux_rq1cde
GROUP BY Sex,
Der_Age_At_CDS_Activity_Date,
Care_Home_Flag,
Care_Home_Service_Type,
CCG_of_Residence,
[EC_Acuity_SNOMED_CT],
[Pat_Der_Dimention_1],
[Pat_Der_Dimention_6]



/**
SELECT *
INTO #aux_rq1cde
FROM
(SELECT EC_Ident, Der_Pseudo_NHS_Number, Sex, [Der_Age_At_CDS_Activity_Date], [EC_Acuity_SNOMED_CT], Care_Home_Flag, Care_Home_Service_Type, CCG_of_Residence
FROM ECDS_CTE_rq1cde
LEFT JOIN MPI_CTE_rq1
ON ECDS_CTE_rq1cde.Der_Pseudo_NHS_Number = MPI_CTE_rq1.Pseudo_NHS_Number) AS T1
LEFT JOIN ECDS_PAT_CTE_rq1cde
ON T1.EC_Ident = ECDS_PAT_CTE_rq1cde.EC_Ident
**/


