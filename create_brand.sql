-- DROP PROCEDURE IF EXISTS final_project.createBrand;
CREATE PROCEDURE final_project.createBrand(
    in token varchar(500), -- login time
	in brand_name varchar(255),
    in brand_dose_num integer,
    in days integer,
    out res varchar(500)
)
begin
	set @is_user_doctor = 0;
    set @is_user_logged_in = 0;
    set @is_brand_duplicate = 0;
   	set @current_id = null;
    set @doctor_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    if(exists (select ID from final_project.doctor where ID = @current_id)) then 
	        set @is_user_doctor = 1;
	        -- save doctor id
	        select doc_ID into @doctor_id from final_project.doctor where final_project.doctor.ID = @current_id;
	        if(exists (select name from final_project.brand where name = brand_name)) then
	        	set @is_brand_duplicate = 1;
	        end if;
	    end if;
	end if;


    if @is_user_doctor = 1 and @is_user_logged_in = 1 and @is_brand_duplicate = 0 then
    	insert into final_project.brand values(brand_name, brand_dose_num, days, @doctor_id);
    	set res = "Brand created successfully";
    elseif @is_user_logged_in = 0 then
    	set res = "please log in first";
    elseif @is_user_doctor = 0 then
    	set res = "only doctors can create a brand";
    elseif @is_brand_duplicate = 1 then
    	set res = "this brand name already exists";
    end if;
end;