-- DROP PROCEDURE IF EXISTS final_project.login;
CREATE PROCEDURE final_project.login(
	in user_id char(10),
    in passw varchar(500),
    out res varchar(500),
    out token varchar(500)
)
begin
	if (EXISTS (SELECT * FROM final_project.systeminfo WHERE (final_project.systeminfo.ID = user_id AND final_project.systeminfo.pass = MD5(passw)))) then
		INSERT INTO final_project.login_info VALUES(user_id, CURRENT_TIME());
	    set res = "Login process was successful";
		set token = CURRENT_TIME();
	else
	    set res = "Incorrect username or password.";
		set token = CURRENT_TIME();
	end if;
end;