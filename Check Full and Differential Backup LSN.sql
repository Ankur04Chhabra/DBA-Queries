/*Match checkpoint_lsn cloumn value of Full Backup  
with differential_base_lsn column for differential database
from master.dbo.backupset
*/
select top 10 name,type,software_major_version,first_lsn,last_lsn,
checkpoint_lsn,database_backup_lsn,database_creation_date,backup_start_date,
backup_finish_date,compatibility_level,recovery_model,database_version,backup_size,compressed_backup_size,
server_name,collation_name,differential_base_lsn from msdb.dbo.backupset 
where database_name='cctns_state_db' and type='D'
and name='cctns_state_db_backup_2020_09_07_100013_0131356'
order by backup_finish_date
desc

select top 10 name,type,software_major_version,differential_base_lsn,first_lsn,last_lsn,
checkpoint_lsn,database_backup_lsn,database_creation_date,backup_start_date,
backup_finish_date,compatibility_level,recovery_model,database_version,backup_size,compressed_backup_size,
server_name,collation_name from msdb.dbo.backupset 
where database_name='cctns_state_db' and type='I' 
--and name='cctns_state_db_backup_2020_09_07_100013_0131356'
order by backup_start_date
desc


--select (((53621048168/1024)/1024)/1024)