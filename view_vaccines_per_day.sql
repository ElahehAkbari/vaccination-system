-- DROP PROCEDURE IF EXISTS final_project.viewVaccinesPerDay;
CREATE PROCEDURE final_project.viewVaccinesPerDay()
begin
	select vh.vaccination_date, count(*) as count_of_vaccines from final_project.vaccination_history as vh
	group by vh.vaccination_date
    order by vh.vaccination_date desc;
end;