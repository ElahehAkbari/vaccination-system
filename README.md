# vaccination-system

Implementation of a vaccination system database using SQL. The system can support three types of users: doctors, nurses, and visitors of a vaccination center.

This database keeps all the necessary records, including account information and transactions, while enabling users to modify and keep track of their actions.

Necessary information is kept in [tables](/all_tables.sql). Each tale corresponds to either an entity or a relation. What users can do based on their role in the system is listed below.

## All users
  * [Sign up](/register.sql)
  * [Login](/login.sql)
  * [Access account information](/view_profile.sql)
  * [Change password](/change_password.sql)
  * [Rate a vaccination center](/rate_center.sql)
  * View
    * [Each center's rate](/view_rates.sql)
    * [The number of injected vaccine shots per day](/view_vaccines_per_day.sql)
    * [The number of vaccinated visitors from each vaccine brand](/show_vaccinated_of_each_brand.sql)
    * [The top three centers of each vaccine brand](/view_rates_of_top_brands.sql)
    * [Available centers for their second dose](/view_personalized_centers.sql)
## Doctors
  * [Add a new brand to the system](/create_brand.sql)
  * [Add new centers to the system](/create_vaccination_center.sql)
  * [Delete accounts](/doctor_Delete_Acc.sql)
## Nurses
  * [Add a vaccination(injection) record](/vaccinate.sql): Matrons, Nurses, Paramedics, Supervisors
  * [Add new vials](/CreateVial.sql): Matrons
