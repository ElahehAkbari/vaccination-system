-- DROP PROCEDURE IF EXISTS final_project.createVaccinationCenter;
CREATE PROCEDURE final_project.createVaccinationCenter(
    in token varchar(500), -- login time
	in center_name varchar(255),
    in center_address varchar(512),
    out res varchar(500)
)
begin
	set @is_user_doctor = 0;
    set @is_user_logged_in = 0;
    set @is_center_duplicate = 0;
   	set @current_id = null;
    set @doctor_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    if(exists (select ID from final_project.doctor where ID = @current_id)) then 
	        set @is_user_doctor = 1;
	        -- save doctor id
	        select doc_ID into @doctor_id from final_project.doctor where final_project.doctor.ID = @current_id;
	        if(exists (select name from final_project.vaccination_center where name = center_name)) then
	        	set @is_center_duplicate = 1;
	        end if;
	    end if;
	end if;


    if @is_user_doctor = 1 and @is_user_logged_in = 1 and @is_center_duplicate = 0 then
    	insert into final_project.vaccination_center values(center_name,center_address);
    	set res = "Vaccination center created successfully";
    elseif @is_user_logged_in = 0 then
    	set res = "please log in first";
    elseif @is_user_doctor = 0 then
    	set res = "only doctors can create a center";
    elseif @is_center_duplicate = 1 then
    	set res = "this center name already exists";
    end if;
end;