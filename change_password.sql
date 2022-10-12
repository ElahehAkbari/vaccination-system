-- DROP PROCEDURE IF EXISTS final_project.changePassword;
CREATE PROCEDURE final_project.changePassword(
    in token varchar(500), -- login time
    in new_pass varchar(50),
    out res varchar(500)
)
begin
    set @is_user_logged_in = 0;
    set @is_pass_valid = 0;
    set @current_id = null;
   

	IF (EXISTS (SELECT * FROM final_project.login_info WHERE final_project.login_info.login_time = token)) then
	    set @is_user_logged_in  = 1;
	    select user_id into @current_id from final_project.login_info where final_project.login_info.login_time = token;
	    SELECT ((new_pass regexp '[[:digit:]]+') AND (new_pass regexp '[[:alpha:]]+')) INTO @is_pass_valid;
	    if char_length(new_pass) < 8 then
	    	set @is_pass_valid = 0; 
	    end if;
	    if @is_pass_valid >= 1 then
	        update final_project.systeminfo set final_project.systeminfo.pass = MD5(new_pass) where final_project.systeminfo.ID = @current_id; 
	    	set res = "password updated succeessfully";
	    elseif @is_pass_valid = 0 then
	    	set res = "new password is invalid";
	    end if;
	end if;

    if @is_user_logged_in = 0 then
    	set res = "please log in with your current password first";
    end if;
end;