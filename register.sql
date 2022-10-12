-- DROP PROCEDURE IF EXISTS final_project.register3;
CREATE PROCEDURE final_project.register3(
	in user_id varchar(255),
    in passw varchar(512),
    in name varchar(512),
	in last_name varchar(512),
	in gender varchar(10),
	in has_disease varchar(10),
	in b_date date,
	in user_type varchar(16),
    in medic_ID varchar(10),
	in nurse_level varchar(20),
    out res varchar(512)
)
begin
	SET @user_id_count = 0;
   	SET @is_user_valid = 0;
    SET @is_pass_valid = 0;
   
	SELECT count(*) into @user_id_count
    FROM final_project.systeminfo
    WHERE final_project.systeminfo.ID = user_id;
   


    SELECT (user_id regexp '[[:alpha:]]+') INTO @is_user_valid;
    IF CHAR_LENGTH(user_id) > 10 or CHAR_LENGTH(user_id) < 10 THEN
		set @is_user_valid = 1;
	END IF;
  
   
    SELECT ((passw regexp '[[:digit:]]+') AND (passw regexp '[[:alpha:]]+')) INTO @is_pass_valid;
   
    IF CHAR_LENGTH(passw) < 8 THEN
		set @is_pass_valid = 0;
	END IF;

 	IF @is_user_valid = 0 AND @is_pass_valid >= 1 AND @user_id_count = 0 then
-- 	 	INSERT INTO final_project.systeminfo values (user_id, MD5(passw), CURRENT_DATE() ,CURRENT_TIME()); 
-- 	 	INSERT into final_project.personal_info values(user_id, name, last_name, gender, b_date,has_disease);	 
-- normal
	    if user_type = "normal" then
		 	INSERT INTO final_project.systeminfo values (user_id, MD5(passw), CURRENT_DATE() ,CURRENT_TIME()); 
		 	INSERT into final_project.personal_info values(user_id, name, last_name, gender, b_date,has_disease);
		    set res = "Account created successfully";
		end if;
-- nurse
	    if user_type = "nurse" then
			SET @nurse_count = 0;
			SET @is_nurse_id_valid = 0;
		    SET @is_level_valid = 0;
		   
			SELECT count(*) into @nurse_count FROM final_project.nurse  WHERE  medic_ID = final_project.nurse .nurse_ID;
		
			if nurse_level= "supervisor" or nurse_level = "matron" or nurse_level = "paramadic" or nurse_level = "nurse" then 
				set @is_level_valid = 1;
			end if;


    		SELECT (medic_ID  regexp '[[:alpha:]]+') INTO @is_nurse_id_valid;
    		IF CHAR_LENGTH(medic_ID) < 8 or CHAR_LENGTH(medic_ID) > 8 THEN
				set @is_nurse_id_valid = 1;
			END IF;
		    -- hereeeeeeeeeeeeeeeeeeeeeeeee
		    IF @is_level_valid = 1 AND @nurse_count = 0  and @is_nurse_id_valid = 0 then
		    	INSERT INTO final_project.systeminfo values (user_id, MD5(passw), CURRENT_DATE() ,CURRENT_TIME()); 
		 	    INSERT into final_project.personal_info values(user_id, name, last_name, gender, b_date,has_disease);
				INSERT INTO final_project.nurse values (user_id, medic_ID, nurse_level);
			    set res = "user added as a nurse";
			elseif @is_nurse_id_valid > 0 then
				SET res = "please enter 8 digits";
			elseif @nurse_count > 0 then
				SET res = "this nurse id has registered before";
			elseif @is_level_valid = 0 then 
				set res = "This nurse level is not valid.";
			end if;
		end if;
	
-- doctor
		IF user_type = "doctor" THEN 
			SET @doctor_id_count = 0;
			SET @is_doc_id_valid = 0;
		
			SELECT count(*) into @doctor_id_count
		    FROM final_project.doctor
		    WHERE final_project.doctor.doc_ID  = medic_ID ;

    		SELECT (medic_ID  regexp '[[:alpha:]]+') INTO @is_doc_id_valid;
    		IF CHAR_LENGTH(medic_ID) > 5 or CHAR_LENGTH(medic_ID) < 5 THEN
				set @is_doc_id_valid = 1;
			END IF;
-- hereeeeeeeeeeeeeeeeeeeeeeeee
			IF @is_doc_id_valid =0 AND @doctor_id_count = 0 then
			    INSERT INTO final_project.systeminfo values (user_id, MD5(passw), CURRENT_DATE() ,CURRENT_TIME()); 
		 	    INSERT into final_project.personal_info values(user_id, name, last_name, gender, b_date,has_disease);
				INSERT INTO final_project.doctor values (user_id, medic_ID);
				SET res = "user added as a doctor";
			
			ELSEIF @doctor_id_count > 0 then
				SET res = "user with this doctor ID already exists";
-- 			
			ELSEIF @is_doc_id_valid > 0 then
				SET res = "please enter 5 digits exactly";
			end if;
		END IF;        
	 
--     end if;
   
--     set res = "Account created successfully";
   
  	ELSEIF @user_id_count > 0 THEN
		SET res = "Username taken";
	ELSEIF @is_user_valid > 0 THEN
    	SET res = "enter 10 digits for security number";
--     end if;
	ELSEIF CHAR_LENGTH(passw) < 8 THEN
    	SET res = "password must contain 8 letters and both characters and digits";
	ELSE
		SET res = "password must be a combination of letters and numbers";
 	END IF;
end;