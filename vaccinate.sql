-- DROP PROCEDURE IF EXISTS final_project.vaccinate;
CREATE PROCEDURE final_project.vaccinate(
    in token varchar(500), -- login time
	in vaccinated_user_id varchar(255),
	in vaccination_center_name varchar(255),
	in vial_serial_num varchar(32),
	in vaccination_date date,
    out res varchar(500)
)
begin
    set @is_user_logged_in = 0;
    set @is_user_nurse = 0;
   	set @is_vaccinated_user_valid = 0;
    set @is_center_valid = 0;
    set @is_serial_valid = 0;
    set @current_id = null;
    set @current_nurse_id = null;
    set @is_vaccination_over = 0;
    set @is_second_dose_valid = 0;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    if(exists (select ID from final_project.nurse where ID = @current_id)) then 
	        set @is_user_nurse = 1;
	        select nurse_ID into @current_nurse_id from final_project.nurse where final_project.nurse.ID = @current_id;
	       
	        if (exists (select ID from final_project.systeminfo where ID = vaccinated_user_id)) then
	        	set @is_vaccinated_user_valid = 1;
	        end if;
	       
	        if(exists (select name from final_project.vaccination_center where name = vaccination_center_name)) then
	        	set @is_center_valid  = 1;
	        end if;
	       
	        if(exists(select serial_num from final_project.vial where final_project.vial.serial_num = vial_serial_num)) then
	        	set @is_serial_valid = 1;
	        	select count(*) into @serialCount from final_project.vaccination_history where final_project.vaccination_history.person_ID  = vaccinated_user_id ;
	        	select brand_name into @vial_brand from final_project.vial where final_project.vial.serial_num  = vial_serial_num;
	        	select brand_dose_num into @doseCount from final_project.brand  where final_project.brand.name = @vial_brand;
	        	if (@serialCount = @doseCount) then
	        		set @is_vaccination_over = 1;
	        	end if;
	        	
	        	select vial_serial into @first_dose_vial from final_project.vaccination_history 
	        	where final_project.vaccination_history.person_ID = vaccinated_user_id;
	        
	        	select brand_name into @first_dose_brandName from final_project.vial
	        	where final_project.vial.serial_num = @first_dose_vial;
	        
	        	select brand_name into @current_brandName from final_project.vial
	        	where final_project.vial.serial_num = vial_serial_num;
	        	
	        	if (@current_brandName = @first_dose_brandName or @serialCount = 0)	then
	        		set @is_second_dose_valid = 1;
	        	end if;
	        		
	        	
	        end if;
	    end if;
	end if;


    if @is_user_nurse = 1 and @is_user_logged_in = 1 and @is_vaccinated_user_valid = 1 and @is_center_valid = 1 and @is_serial_valid = 1 and @is_vaccination_over = 0 and @is_second_dose_valid = 1 then
    	insert into final_project.vaccination_history  values(vaccinated_user_id , @current_nurse_id, vaccination_center_name , vial_serial_num, vaccination_date, null);
    	set res = "history created successfully";
    elseif @is_user_logged_in = 0 then
    	set res = "please log in first";
    elseif @is_user_nurse = 0 then
    	set res = "only nurses can modify vaccination histories";
    elseif @is_vaccinated_user_valid = 0 then
    	set res = "this user is not valid, no accounts found.";
    elseif @is_center_valid = 0 then
    	set res = "this center is not valid.";
    elseif @is_serial_valid = 0 then
    	set res = "this serial number is not valid.";
    elseif @is_vaccination_over = 1 then
    	set res = "this user has been fully vaxxed!!";
    elseif @is_second_dose_valid = 0 then
    	set res = "this brand is not valid for the second dose.";
    end if;
end;