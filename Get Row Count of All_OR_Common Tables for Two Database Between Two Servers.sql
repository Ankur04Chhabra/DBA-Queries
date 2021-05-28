/* Use the WITH keyword to start your first expression */
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

/* Then chain additional expressions (this time adding the linked server into the table name) */
SERVER_B AS (
  SELECT 
      t.NAME AS TableName,
      p.[Rows] AS NumRows
  FROM 
      LINKED_SERVER_NAME.sys.tables t
  INNER JOIN      
      LINKED_SERVER_NAME.sys.indexes i ON t.OBJECT_ID = i.object_id
  INNER JOIN 
      LINKED_SERVER_NAME.sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
  INNER JOIN 
      LINKED_SERVER_NAME.sys.allocation_units a ON p.partition_id = a.container_id
  WHERE 
      t.NAME NOT LIKE 'dt%' AND
      i.OBJECT_ID > 255 AND   
      i.index_id <= 1
  GROUP BY 
      t.NAME, i.object_id, i.index_id, i.name, p.[Rows]
)

/* Then join the two together on a common column */
SELECT
  A.TableName,
  A.NumRows AS DB1_Rows,
  B.NumRows AS DB2_Rows

FROM SERVER_A A
  LEFT JOIN SERVER_B B ON
    A.TableName = B.TableName

ORDER BY
  A.TableName ASC