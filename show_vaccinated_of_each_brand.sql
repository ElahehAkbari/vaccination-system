-- DROP PROCEDURE IF EXISTS final_project.showVaccinatedOfEachBrand;
CREATE PROCEDURE final_project.showVaccinatedOfEachBrand()
begin 
	select all_vaxxed.brand_name, count(*) as vaccinated
	from 
		(select v.brand_name as brand_name, count(*) as num from final_project.vial as v join final_project.vaccination_history as vh on vh.vial_serial = v.serial_num
		GROUP by vh.person_ID) as all_vaxxed
	join final_project.brand as b on b.name = all_vaxxed.brand_name where all_vaxxed.num = b.brand_dose_num 
	GROUP by b.name;
end;