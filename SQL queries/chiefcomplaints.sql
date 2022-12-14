/****** Script for SelectTopNRows command from SSMS  ******/
SELECT * FROM 
(SELECT [ChiefComplaintCode]
      ,[ChiefComplaintGrouping]
  FROM [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Chief_Complaint_Group]) a
  LEFT JOIN (SELECT [ChiefComplaintCode], [ChiefComplaintDescription] FROM [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Chief_Complaint]) b
  ON a.[ChiefComplaintCode]=b.[ChiefComplaintCode]