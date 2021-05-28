

--1 Get SQL Server Memory Details

select (total_physical_memory_kb/1024)/1024 As [In GB],(available_physical_memory_kb/1024)/1024 As [In GB],system_memory_state_desc 
from sys.dm_os_sys_memory


--2 Get SQL Server SQL Details

select cpu_count,os_quantum as [No of Scockets],sqlserver_start_time,virtual_machine_type,virtual_machine_type_desc 
from sys.dm_os_sys_info

exec sys.xp_readerrorlog 0,1,N'detected',N'socket'