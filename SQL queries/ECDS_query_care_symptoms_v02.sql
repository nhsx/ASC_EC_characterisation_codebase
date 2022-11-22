/** march 21/22 , all **/
DROP TABLE #aux
SELECT T1.[EC_Ident]
,T1.[Der_Age_At_CDS_Activity_Date]
,T1.[Sex]
,T1.[Ethnic_Category]
,T1.[Index_Of_Multiple_Deprivation_Decile]
/***,T1.[Accommodation_Status_SNOMED_CT]
,T1.[Discharge_Destination_SNOMED_CT]
,T1.[EC_Attendance_Source_SNOMED_CT]***/
,T1.[Der_Financial_Year]
,T1.[EC_Chief_Complaint_SNOMED_CT]
,T1.[EC_Acuity_SNOMED_CT]
,T2.[Pat_Der_Age_Band]
,T2.[Pat_Der_Dimention_1]
,T2.[Pat_Der_Dimention_6]
,(CASE WHEN T1.[Accommodation_Status_SNOMED_CT] IN ('394923006','160734000') OR /*** https://digital.nhs.uk/data-and-information/data-collections-and-data-sets/data-sets/emergency-care-data-set-ecds/user-guide/data-group-patient-characteristics ***/
T1.[Discharge_Destination_SNOMED_CT] IN ('306691003','306694006') OR /*** https://termbrowser.nhs.uk/?perspective=full&conceptId1=999003011000000105&edition=uk-edition&release=v20220511&server=https://termbrowser.nhs.uk/sct-browser-api/snomed&langRefset=999000681000001101,999001251000000103 ***/
T1.[EC_Attendance_Source_SNOMED_CT] IN ('877171000000103','1077761000000105') /*** https://www.datadictionary.nhs.uk/data_elements/emergency_care_attendance_source__snomed_ct_.html ***/
  THEN 1 ELSE 0 END) care_flag
  INTO #aux
FROM 
(SELECT * FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC]
WHERE [Der_Financial_Year]='2021/22') AS T1 /**AND [Accommodation_Status_SNOMED_CT] IN ('394923006')**/
LEFT JOIN
(SELECT [EC_Ident],[Pat_Der_Age_Band],[Pat_Der_Dimention_1],[Pat_Der_Dimention_6]
FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT]) AS T2
ON T1.[EC_Ident]=T2.[EC_Ident]


SELECT TOP 1000 *
FROM #aux


SELECT *
INTO [NHSE_Sandbox_EmpowerThePerson].[dbo].[MFonseca_EC_careproxy_2122v2]
FROM #aux

DROP TABLE #aux2
SELECT [EC_Chief_Complaint_SNOMED_CT]
,[EC_Acuity_SNOMED_CT]
,[Der_Age_At_CDS_Activity_Date]
,[Sex]
,[Pat_Der_Age_Band]
,[Pat_Der_Dimention_1]
,[Pat_Der_Dimention_6]
,[care_flag]
,COUNT(EC_Ident) n
INTO #aux2
FROM [NHSE_Sandbox_EmpowerThePerson].[dbo].[MFonseca_EC_careproxy_2122v2]
GROUP BY care_flag
,[EC_Chief_Complaint_SNOMED_CT]
,[Sex]
,[EC_Acuity_SNOMED_CT]
,[Der_Age_At_CDS_Activity_Date]
,[EC_Acuity_SNOMED_CT]
,[Pat_Der_Age_Band]
,[Pat_Der_Dimention_1]
,[Pat_Der_Dimention_6]

SELECT TOP 1000 *
FROM #aux2

USE [NHSE_Sandbox_EmpowerThePerson]
GO

SELECT *
INTO [NHSE_Sandbox_EmpowerThePerson].[dbo].[MFonseca_EC_careproxy_2122v2_agg]
FROM #aux2




/** march 21/22 , all **/
DROP TABLE #aux3
SELECT T1.[EC_Ident]
,T1.[Der_Age_At_CDS_Activity_Date]
,T1.[Sex]
,T1.[Ethnic_Category]
,T1.[Index_Of_Multiple_Deprivation_Decile]
,T1.[Accommodation_Status_SNOMED_CT]
,T1.[Der_Financial_Year]
,T1.[EC_Chief_Complaint_SNOMED_CT]
,T1.[EC_Acuity_SNOMED_CT]
,T1.[Discharge_Destination_SNOMED_CT]
,T1.[EC_Attendance_Source_SNOMED_CT]
,T2.[Pat_Der_Age_Band]
,T2.[Pat_Der_Dimention_1]
,T2.[Pat_Der_Dimention_6]
,(CASE WHEN T1.[Accommodation_Status_SNOMED_CT] IN ('394923006','160734000') OR /*** https://digital.nhs.uk/data-and-information/data-collections-and-data-sets/data-sets/emergency-care-data-set-ecds/user-guide/data-group-patient-characteristics ***/
T1.[Discharge_Destination_SNOMED_CT] IN ('306691003','306694006') OR /*** https://termbrowser.nhs.uk/?perspective=full&conceptId1=999003011000000105&edition=uk-edition&release=v20220511&server=https://termbrowser.nhs.uk/sct-browser-api/snomed&langRefset=999000681000001101,999001251000000103 ***/
T1.[EC_Attendance_Source_SNOMED_CT] IN ('877171000000103','1077761000000105') /*** https://www.datadictionary.nhs.uk/data_elements/emergency_care_attendance_source__snomed_ct_.html ***/
  THEN 1 ELSE 0 END) care_flag
  INTO #aux3
FROM 
(SELECT * FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC]
WHERE [Der_Financial_Year]='2021/22'
AND
(CASE WHEN [Accommodation_Status_SNOMED_CT] IN ('394923006','160734000') OR /*** https://digital.nhs.uk/data-and-information/data-collections-and-data-sets/data-sets/emergency-care-data-set-ecds/user-guide/data-group-patient-characteristics ***/
[Discharge_Destination_SNOMED_CT] IN ('306691003','306694006') OR /*** https://termbrowser.nhs.uk/?perspective=full&conceptId1=999003011000000105&edition=uk-edition&release=v20220511&server=https://termbrowser.nhs.uk/sct-browser-api/snomed&langRefset=999000681000001101,999001251000000103 ***/
[EC_Attendance_Source_SNOMED_CT] IN ('877171000000103','1077761000000105') /*** https://www.datadictionary.nhs.uk/data_elements/emergency_care_attendance_source__snomed_ct_.html ***/
  THEN 1 ELSE 0 END)=1
  ) AS T1 /**AND [Accommodation_Status_SNOMED_CT] IN ('394923006')**/
LEFT JOIN
(SELECT [EC_Ident],[Pat_Der_Age_Band],[Pat_Der_Dimention_1],[Pat_Der_Dimention_6]
FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT]) AS T2
ON T1.[EC_Ident]=T2.[EC_Ident]


SELECT TOP 1000 *
FROM #aux3

DROP TABLE #aux4
SELECT [Ethnic_Category]
,[Der_Age_At_CDS_Activity_Date]
,[Sex]
,[Index_Of_Multiple_Deprivation_Decile]
,[Accommodation_Status_SNOMED_CT]
,[Discharge_Destination_SNOMED_CT]
,[EC_Attendance_Source_SNOMED_CT]
,[EC_Chief_Complaint_SNOMED_CT]
,[EC_Acuity_SNOMED_CT]
,[Pat_Der_Age_Band]
,[Pat_Der_Dimention_1]
,[Pat_Der_Dimention_6]
,[care_flag]
,COUNT(EC_Ident) n
INTO #aux4
FROM #aux3
GROUP BY [Ethnic_Category]
,[Index_Of_Multiple_Deprivation_Decile]
,[Der_Age_At_CDS_Activity_Date]
,[Sex]
,care_flag
,[Accommodation_Status_SNOMED_CT]
,[Discharge_Destination_SNOMED_CT]
,[EC_Attendance_Source_SNOMED_CT]
,[EC_Chief_Complaint_SNOMED_CT]
,[EC_Acuity_SNOMED_CT]
,[Pat_Der_Age_Band]
,[Pat_Der_Dimention_1]
,[Pat_Der_Dimention_6]

SELECT TOP 1000 *
FROM #aux4

USE [NHSE_Sandbox_EmpowerThePerson]
GO

SELECT *
INTO [NHSE_Sandbox_EmpowerThePerson].[dbo].[MFonseca_EC_careproxy_2122]
FROM #aux4





/**
SELECT [Accommodation_Status_SNOMED_CT],
[Discharge_Destination_SNOMED_CT],
[EC_Attendance_Source_SNOMED_CT],
care_flag,
COUNT([EC_Ident])
FROM  #aux
GROUP BY care_flag,
[Accommodation_Status_SNOMED_CT],
[Discharge_Destination_SNOMED_CT],
[EC_Attendance_Source_SNOMED_CT]**/


/*** Distinct reasons for access 
SELECT DISTINCT [Reason_For_Access]
FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC]
 Output: national only***/

SELECT DISTINCT [Der_Financial_Year]
  FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT] /*** from 17/18 ***/


SELECT DISTINCT [Pat_Der_Age_Band]
  FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT] /*** male female in steps of 5 ***/

SELECT DISTINCT [Pat_Der_Dimention_1]
  FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT] /*** type of a&e dep (6 levels) ***/

SELECT DISTINCT [Pat_Der_Dimention_6]
  FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT] /*** 7 outcomes incl died, admitted, transfer, discharge ***/

SELECT DISTINCT
       ,[EC_Load_ID]
      ,[Generated_Record_ID]
      ,[Pat_Der_Age_Band]
      ,[Pat_Der_Record_Classification]
      ,[Pat_Der_Dimention_1]
      ,[Pat_Der_Dimention_2]
      ,[Pat_Der_Dimention_3]
      ,[Pat_Der_Dimention_4]
      ,[Pat_Der_Dimention_5]
      ,[Pat_Der_Dimention_6]
      ,[Der_Financial_Year]
  FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_EC_PAT]