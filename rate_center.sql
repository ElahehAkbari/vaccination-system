-- DROP PROCEDURE IF EXISTS final_project.rateCenter;
CREATE PROCEDURE final_project.rateCenter(
    in token varchar(500), -- login time
    in center_name varchar(50),
    in center_rate integer,
    out res varchar(500)
)
begin
    set @is_user_logged_in = 0;
    set @is_user_vaccinated = 0;
    set @is_rate_valid = 0;
    set @is_rate_field_empty = 0;
    set @current_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	   
	    if (exists (select person_ID from final_project.vaccination_history where (final_project.vaccination_history.person_ID  = @current_id)
	    and (final_project.vaccination_history.vaccination_center_name = center_name) and (final_project.vaccination_history.rate is null))) then
	    	set @is_user_vaccinated = 1;
	        set @is_rate_field_empty = 1;
	    end if;
	    
	    if center_rate >= 1 and center_rate <= 5 then
	    	set @is_rate_valid = 1;
	    end if;
	end if;

    if @is_user_logged_in = 1 and  @is_user_vaccinated = 1 and @is_rate_valid = 1 and @is_rate_field_empty = 1 then
    	update final_project.vaccination_history  set final_project.vaccination_history.rate = center_rate where final_project.vaccination_history.person_ID  = @current_id and 
        final_project.vaccination_history.vaccination_center_name = center_name; 
    	set res = "thanks for rating!!";
    elseif @is_user_logged_in = 0 then
    	set res = "please log in first";
    elseif @is_rate_field_empty = 0 then
    	set res = "you have voted for this center already.";
    elseif @is_user_vaccinated = 0 then
    	set res = "you have not been vaccinated in this center";
    elseif @is_rate_valid = 0 then
    	set res = "please enter a number between 1 and 5 to rate this center.";
    end if;
end;