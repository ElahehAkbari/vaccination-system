CREATE DEFINER=`root`@`localhost` PROCEDURE `final_project`.`doctorDeleteAcc`(
    in token varchar(500), -- login time
	in deleted_user_id char(10),
    out res varchar(500)
)
begin
	set @is_user_doctor = 0;
    set @is_user_logged_in = 0;
    set @is_deleted_user_valid = 0;
   	set @current_id = null;
    set @doctor_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    if(exists (select ID from final_project.doctor where ID = @current_id)) then 
	        set @is_user_doctor = 1;
	        -- save doctor id
-- 	        select doc_ID into @doctor_id from final_project.doctor where final_project.doctor.ID = @current_id;
	        if(exists (select ID from final_project.systeminfo where ID = deleted_user_id)) then
	        	set @is_deleted_user_valid = 1;
	        end if;
	    end if;
	end if;


    if @is_user_doctor = 1 and @is_user_logged_in = 1 and @is_deleted_user_valid = 1 then
    	delete from final_project.systeminfo where final_project.systeminfo.ID = deleted_user_id ;
    	set res = "deleted successfully";
    elseif @is_user_logged_in = 0 then
    	set res = "please log in first";
    elseif @is_user_doctor = 0 then
    	set res = "only doctors can delete an account";
    elseif @is_deleted_user_valid = 0 then
    	set res = "this account does not exist";
    end if;
end