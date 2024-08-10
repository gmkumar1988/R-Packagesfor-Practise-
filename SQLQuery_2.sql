SELECT TOP (1000) [FactID]
      ,[Date]
      ,[Open]
      ,[High]
      ,[Low]
      ,[Close]
      ,[AdjClose]
      ,[Volume]
      ,[SecurityID]
  FROM [dbo].[FactPrices_Daily]


--   select top(1000)
--         max([DateTime]) as MaxDate,
--         min([DateTime]) as MinDate
--         from [dbo].[FactAttributes_Intraday];

