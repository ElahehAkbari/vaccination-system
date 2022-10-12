-- DROP PROCEDURE IF EXISTS final_project.viewRates;
CREATE PROCEDURE final_project.viewRates(
	in start_row integer,
	out end_row integer
)
begin 
	set end_row = start_row + 5;
	WITH rates_per_page_table AS
	(
    	select rank_table.*, ROW_NUMBER() over (order by rank_table.average_rate desc) AS row_num
    	from
        	(select vh.vaccination_center_name, avg(vh.rate) as average_rate from final_project.vaccination_history as vh
			group by vh.vaccination_center_name
    		order by average_rate desc)as rank_table
	)
	select * from rates_per_page_table where row_num between start_row and end_row - 1;
end;