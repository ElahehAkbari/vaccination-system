-- DROP PROCEDURE IF EXISTS final_project.viewProfile;
CREATE PROCEDURE final_project.viewProfile(
    in token varchar(500), -- login time
    out res varchar(500)
)
begin
    set @is_user_logged_in = 0;
    set @current_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    set res = "you can view your profile.";
	    select * from final_project.systeminfo join final_project.personal_info on final_project.systeminfo.ID = final_project.personal_info.user_id 
	    where final_project.systeminfo.ID = @current_id;
	end if;

    if @is_user_logged_in = 0 then
    	set res = "please log in first";
    end if;
end;