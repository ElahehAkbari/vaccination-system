-- view all tables
select * from final_project.systeminfo
select * from final_project.personal_info
select * from final_project.nurse
select * from final_project.doctor
select * from final_project.brand
select * from final_project.login_info
select * from final_project.vial
select * from final_project.vaccination_history
select * from final_project.vaccination_center

-- delete a row from tables
delete from final_project.systeminfo where final_project.systeminfo.ID  = "0333333333";
delete from final_project.vaccination_center where final_project.vaccination_center.name = "my center";

-- register users
call final_project.register3("1111111111", "12345678ab", "first name1", "last name1", "female", "no", "2000-01-01", "normal",null,null,@res1);
select @res1

call final_project.register3("2222222222", "12345678ab", "first name2", "last name2", "male", "no", "2000-01-02", "normal",null,null,@res2);
select @res2

call final_project.register3("3333333333", "12345678ab", "first name3", "last name3", "female", "no", "2000-01-03", "normal",null,null,@res3);
select @res3

call final_project.register3("4444444444", "12345678ab", "first name4", "last name4", "female", "yes", "2000-01-01", "normal",null,null,@res4);
select @res4

call final_project.register3("5555555555", "12345678ab", "first name5", "last name5", "female", "yes", "2000-02-01", "normal",null,null,@res5);
select @res5

call final_project.register3("0111111111", "12345678ab", "first name d1", "last name d1", "female", "no", "2000-01-01", "doctor","11111",null,@res6);
select @res6

call final_project.register3("0222222222", "12345678ab", "first name d2", "last name d2", "male", "no", "2000-01-01", "doctor","22222",null,@res7);
select @res7

call final_project.register3("0333333333", "12345678ab", "first name d3", "last name d3", "male", "no", "2000-03-01", "doctor","33333",null,@res8);
select @res8

call final_project.register3("0444444444", "12345678ab", "first name d4", "last name d4", "female", "no", "2000-01-04", "doctor","44444",null,@res9);
select @res9

call final_project.register3("0555555555", "12345678ab", "first name d5", "last name d5", "female", "yes", "2000-01-01", "doctor","55555",null,@res10);
select @res10

call final_project.register3("1111111110", "12345678ab", "first name n1", "last name n1", "female", "yes", "2000-05-01", "nurse","11111111","nurse",@res11);
select @res11

call final_project.register3("2222222220", "12345678ab", "first name n2", "last name n2", "male", "yes", "2000-05-01", "nurse","22222222","matron",@res12);
select @res12

call final_project.register3("3333333330", "12345678ab", "first name n3", "last name n3", "female", "no", "2000-02-01", "nurse","33333333","matron",@res13);
select @res13

call final_project.register3("4444444440", "12345678ab", "first name n4", "last name n4", "female", "yes", "2000-03-01", "nurse","44444444","supervisor",@res14);
select @res14

call final_project.register3("5555555550", "12345678ab", "first name n5", "last name n5", "male", "yes", "2001-01-01", "nurse","55555555","paramadic",@res15);
select @res15

-- for checking wrong inputs
call final_project.register3("5555555550", "12345678ab", "first name n5", "last name n5", "male", "yes", "2001-01-01", "nurse","55555555","paramadic",@res16);
select @res16

-- login
call final_project.login("1111111111","12345678ab",@R1,@token1);
select @R1
select @token1 

call final_project.login("2222222222","12345678ab",@R2,@token2);
select @R2
select @token2 

call final_project.login("3333333333","12345678ab",@R3,@token3);
select @R3
select @token3

call final_project.login("4444444444","12345678ab",@R4,@token4);
select @R4
select @token4

call final_project.login("5555555555","12345678ab",@R5,@token5);
select @R5
select @token5

-- docs
call final_project.login("0111111111","12345678ab",@R6,@token6);
select @R6
select @token6


call final_project.login("0222222222","12345678ab",@R7,@token7);
select @R7
select @token7

call final_project.login("0333333333","12345678ab",@R8,@token8);
select @R8
select @token8

call final_project.login("0444444444","12345678ab",@R9,@token9);
select @R9
select @token9

call final_project.login("0555555555","12345678ab",@R10,@token10);
select @R10
select @token10

-- nurses
call final_project.login("1111111110","12345678ab",@R11,@token11);
select @R11
select @token11

call final_project.login("2222222220","12345678ab",@R12,@token12);
select @R12
select @token12

call final_project.login("3333333330","12345678ab",@R13,@token13);
select @R13
select @token13

call final_project.login("4444444440","12345678ab",@R15,@token15);
select @R15
select @token15

call final_project.login("5555555550","12345678ab",@R13,@token13);
select @R13
select @token13


-- create brands
call final_project.createBrand(@token6, "brand1",3,10,@res17);
select @res17

call final_project.createBrand(@token7, "brand2",2,10,@res18);
select @res18

call final_project.createBrand(@token8, "brand3",2,10,@res19);
select @res19

call final_project.createBrand(@token8, "brand4",2,10,@res20);
select @res20

call final_project.createBrand(@token8, "brand5",2,10,@res21);
select @res21

-- create centers
call final_project.createVaccinationCenter(@token6, "my center1","24 street",@res22);
call final_project.createVaccinationCenter(@token6, "my center2","25 street",@res23);

call final_project.createVaccinationCenter(@token7, "my center3","25 street",@res24);
call final_project.createVaccinationCenter(@token7, "my center4","25 street",@res25);

call final_project.createVaccinationCenter(@token8, "my center5","25 street",@res26);
call final_project.createVaccinationCenter(@token8, "my center6","25 street",@res27);

call final_project.createVaccinationCenter(@token9, "my center7","25 street",@res28);
call final_project.createVaccinationCenter(@token9, "my center8","25 street",@res29);

call final_project.createVaccinationCenter(@token10, "my center9","25 street",@res30);
call final_project.createVaccinationCenter(@token10, "my center10","25 street",@res31);

-- to check delete account
call final_project.register3("9876543210", "12345678ab", "first name1", "last name1", "female", "no", "2000-01-01", "normal",null,null,@res32);
select @res32

call final_project.doctorDeleteAcc(@token6,"9876543210",@res33);
select @res33

-- create vial
call final_project.createVial(@token12, "120", "brand1", "2021-01-01", 3, @res34);
select @res34
call final_project.createVial(@token12, "121", "brand1", "2021-02-01", 3, @res35);
call final_project.createVial(@token12, "122", "brand2", "2021-01-01", 2, @res36);
call final_project.createVial(@token12, "123", "brand3", "2021-03-01", 3, @res37);
call final_project.createVial(@token12, "124", "brand4", "2021-01-02", 3, @res38);
call final_project.createVial(@token12, "125", "brand5", "2021-01-01", 3, @res39);
call final_project.createVial(@token12, "126", "brand2", "2021-01-01", 2, @res41);
call final_project.createVial(@token12, "127", "brand2", "2021-01-01", 2, @res42);

-- vaccinate
-- delete from final_project.vaccination_history where final_project.vaccination_history.person_ID = "5555555550";
call final_project.vaccinate(@token11, "1111111111", "my center1", "120","2021-01-01", @res40); 
select @res40
call final_project.vaccinate(@token11, "1111111111", "my center1", "121","2021-01-01", @res43);
call final_project.vaccinate(@token11, "2222222222", "my center2", "122","2021-01-01", @res44); 
call final_project.vaccinate(@token11, "3333333333", "my center3", "123","2021-01-01", @res45);
call final_project.vaccinate(@token11, "4444444444", "my center4", "124","2021-01-01", @res46);
call final_project.vaccinate(@token11, "5555555555", "my center5", "125","2021-01-01", @res47);

call final_project.vaccinate(@token11, "0111111111", "my center6", "121","2021-01-01", @res48); 
select @res48
call final_project.vaccinate(@token11, "0222222222", "my center7", "122","2021-01-01", @res49);
call final_project.vaccinate(@token11, "0333333333", "my center8", "121","2021-01-01", @res50); 
call final_project.vaccinate(@token11, "0444444444", "my center9", "123","2021-01-01", @res51);  
call final_project.vaccinate(@token11, "0555555555", "my center10", "125","2021-01-01", @res52);
call final_project.vaccinate(@token11, "1111111110", "my center1", "125","2021-01-01", @res53);


-- rate
call final_project.rateCenter(@token1, "my center1",4, @res54);
call final_project.rateCenter("05:22:53", "my center2",3, @res55);
call final_project.rateCenter(@token3, "my center3",4, @res56);
call final_project.rateCenter(@token4, "my center4",2, @res57);
call final_project.rateCenter(@token5, "my center5",5, @res58);
call final_project.rateCenter(@token5, "my center5",5, @res59);

call final_project.rateCenter(@token6, "my center6",5, @res60);
call final_project.rateCenter(@token7, "my center7",3, @res61);
call final_project.rateCenter(@token8, "my center8",2, @res62);
call final_project.rateCenter(@token9, "my center9",4, @res63);
call final_project.rateCenter(@token10, "my center10",5, @res64);
call final_project.rateCenter(@token11, "my center1",5, @res65);

-- view viewRates 
call final_project.viewRates (1,@res67);
select @res67
call final_project.viewRates (@res67,@res68);

-- view per day
call final_project.viewVaccinesPerDay();

-- view viewProfile 
call final_project.viewProfile (@token1, @res69);

-- view vaccinated in each brand
call final_project.showVaccinatedOfEachBrand();

call final_project.viewRatesOfTopBrands();

call final_project.viewPersonalizedCenters(@token3);

