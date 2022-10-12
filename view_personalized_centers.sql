-- DROP PROCEDURE IF EXISTS final_project.viewPersonalizedCenters;
CREATE PROCEDURE final_project.viewPersonalizedCenters(
	in token varchar(64), -- login_time
	out res varchar(64)
)
begin 
	set @current_id = null;
	set @current_serial_num = null;
	set @current_brand_name = null;
	set @is_user_logged_in = 0;

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    set res = "you can view personalized centers";
		select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	
		SELECT vial_serial INTO @current_serial_num FROM final_project.vaccination_history
	    where final_project.vaccination_history.person_ID = @current_id;
	   
		SELECT brand_name INTO @current_brand_name FROM final_project.vial where final_project.vial.serial_num = @current_serial_num;
	
		select v.brand_name as brand_name, vh.vaccination_center_name, avg(vh.rate) as avg_rates
			from final_project.vial as v join final_project.vaccination_history as vh on vh.vial_serial = v.serial_num
			where v.brand_name = @current_brand_name
			GROUP by v.brand_name, vh.vaccination_center_name
			order by brand_name, avg_rates desc;
	 end if;
	
	 if @is_user_logged_in = 0 then
    	 set res = "please log in first";
     end if;
end;
