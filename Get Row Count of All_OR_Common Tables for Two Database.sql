WITH SERVER_A AS (
  SELECT 
      t.NAME AS TableName,
      p.[Rows] AS NumRows
  FROM 
      sys.tables t
  INNER JOIN      
      sys.indexes i ON t.OBJECT_ID = i.object_id
  INNER JOIN 
      sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
  INNER JOIN 
      sys.allocation_units a ON p.partition_id = a.container_id
  WHERE 
      t.NAME NOT LIKE 'dt%' AND
      i.OBJECT_ID > 255 AND   
      i.index_id <= 1
  GROUP BY 
      t.NAME, i.object_id, i.index_id, i.name, p.[Rows]
), 


 SERVER_B AS (
  SELECT 
      t.NAME AS TableName,
      p.[Rows] AS NumRows
  FROM 
      cctns_state_db.sys.tables t
  INNER JOIN      
      cctns_state_db.sys.indexes i ON t.OBJECT_ID = i.object_id
  INNER JOIN 
      cctns_state_db.sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
  INNER JOIN 
      cctns_state_db.sys.allocation_units a ON p.partition_id = a.container_id
  WHERE 
      t.NAME NOT LIKE 'dt%' AND
      i.OBJECT_ID > 255 AND   
      i.index_id <= 1
  GROUP BY 
      t.NAME, i.object_id, i.index_id, i.name, p.[Rows]
)-- select * from SERVER_B where TableName in (select TABLE_NAME from INFORMATION_SCHEMA.TABLES)

SELECT 
  A.TableName,
  A.NumRows AS cctns_state_MCR_Rows,
  B.NumRows AS cctns_state_db_Rows
  into #temp

FROM SERVER_A A
  LEFT JOIN SERVER_B B ON
    A.TableName = B.TableName

ORDER BY
  A.TableName ASC


  --drop table #temp

  select *,[cctns_state_MCR_Rows]-[cctns_state_db_Rows] from #temp