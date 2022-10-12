-- DROP PROCEDURE IF EXISTS final_project.createVial;
CREATE PROCEDURE final_project.createVial(
    in token varchar(500), -- login time
	in vial_serial_num varchar(255),
	in brand_name varchar(255),
	in production_date date,
	in num_of_doses integer,
    out res varchar(500)
)
begin
	set @is_user_nurse = 0;
    set @is_user_logged_in = 0;
    set @is_nurse_level_valid = 0;
    set @is_brand_valid = 0;
    set @is_serial_num_valid = 0;
    set @is_serial_num_duplicate = 0;
    set @current_level = null;
    set @current_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    if(exists (select ID from final_project.nurse where ID = @current_id)) then 
	        set @is_user_nurse = 1;
	        -- save doctor id
-- 	        select doc_ID into @doctor_id from final_project.doctor where final_project.doctor.ID = @current_id;
	        if(exists (select name from final_project.brand where name = brand_name)) then
	        	set @is_brand_valid  = 1;
	        end if;
	        select nurse_level into @current_level from final_project.nurse where final_project.nurse.ID  = @current_id ;
	        if (@current_level = "matron") then
	        	set @is_nurse_level_valid = 1;
	        end if;
	        SELECT (vial_serial_num regexp '[[:digit:]]+') INTO @is_serial_num_valid;
	        if(exists(select serial_num from final_project.vial where final_project.vial.serial_num = vial_serial_num)) then
	        	set @is_serial_num_duplicate = 1; 
	        end if;
	    end if;
	end if;


    if @is_user_nurse = 1 and @is_user_logged_in = 1 and @is_nurse_level_valid = 1 and @is_brand_valid = 1 and @is_serial_num_valid >= 1 and @is_serial_num_duplicate = 0 then
    	insert into final_project.vial values(vial_serial_num, brand_name, production_date, num_of_doses);
    	set res = "vial created successfully";
    elseif @is_user_logged_in = 0 then
    	set res = "please log in first";
    elseif @is_user_nurse = 0 then
    	set res = "only nurses can create a vial";
    elseif @is_nurse_level_valid = 0 then
    	set res = "only matrons can create a vial";
    elseif @is_brand_valid = 0 then
    	set res = "brand does not exist";
    elseif @is_serial_num_valid = 0 then
    	set res = "please enter DIGITS for serial number";
    elseif @is_serial_num_duplicate = 1 then
    	set res = "this serial number already exists";
    end if;
end;