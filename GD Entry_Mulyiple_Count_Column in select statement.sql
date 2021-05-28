select dis.DISTRICT,
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=89) as 'Accused Sent to Juditial custody',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=1) as 'Missing person',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=6) as 'Criminal case ',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=16) as 'Arrest/Re-Arrest/Surrender',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=23) as 'Arrest in Preventive Action',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=26) as 'Bail',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=90) as 'Accused Sent to Transit Remand',
(select COUNT(gd_srno) from t_gd_entry where DISTRICT_CD=dis.DISTRICT_CD and RECORD_STATUS='C' and GD_TYPE_CD=100) as 'Unnatural death/morgue',
(select COUNT(FIR_REG_NUM) from t_fir_registration where RECORD_STATUS='C' and dis.DISTRICT_CD=DISTRICT_CD and LANG_CD=99) as 'FIR'
from m_district as dis
where RECORD_STATUS='C' 
and LANG_CD=99 and STATE_CD=24



--select top 5 * from t_gd_entry