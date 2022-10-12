-- DROP PROCEDURE IF EXISTS final_project.viewRatesOfTopBrands;
CREATE PROCEDURE final_project.viewRatesOfTopBrands()
begin 
	select*
    from (
        SELECT *, Rank() over (partition by selected.brand_name order by selected.rates desc ) AS Rank
        from (
        select v.brand_name as brand_name, vh.vaccination_center_name, avg(vh.rate) as rates
		from  final_project.vaccination_history as vh join final_project.vial as v on vh.vial_serial = v.serial_num
		GROUP by v.brand_name, vh.vaccination_center_name)as selected) as res where Rank <= 3;
end;