create or replace PACKAGE "CLINOPS_AUTHORIZATION"  
as 
 
function has_app_access ( 
	p_username		clinops_users.username%type 
	) return boolean; 
 
function get_role ( 
	p_username		clinops_users.username%type 
	) return varchar2; 
 
function has_functionality_access ( 		  
	p_username		clinops_users.username%type, 
	p_code			functionality_access.code%type 
	) return boolean; 
 function has_functionality_access_var ( 		  
	p_username		clinops_users.username%type, 
	p_code			functionality_access.code%type 
	) return varchar2; 


function set_tracker_branch ( 
	p_username		clinops_users.username%type 
	) return number; 
function get_initials (
	p_username		clinops_users.username%type
	) return varchar2;
end  clinops_authorization;
/