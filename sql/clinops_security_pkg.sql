create or replace PACKAGE "CLINOPS_SECURITY_PKG"  
AS            
            
function get_user_id (
	p_app_user		varchar2
	) return number;
  
function hash_password (  
	p_username		clinops_users.username%type,  
	p_password		clinops_users.password %type  
	) return varchar2;  
  
function  authenticate_user (  
	p_username in clinops_users.username%type,  
	p_password in varchar2  
	) return boolean;  
  
function is_account_locked (  
	p_username	clinops_users.username%type  
	) return boolean;  
  
function is_account_expired (  
	p_username	clinops_users.username%type  
	) return boolean;  
  
function too_many_attempts (  
	p_username	clinops_users.username%type  
	) return boolean;  
  
procedure add_failed_attempt (  
	p_username		in	clinops_users.username%type  
	);  
  
function reset_password (  
	p_username	in	clinops_users.username%type  
	) return varchar2;  
   
function set_first_password (  
	p_username	in	clinops_users.username%type  
	) return varchar2;  
function is_change_pwd_req (  
	p_username	clinops_users.username%type  
	) return varchar2;  
  
procedure assign_roles (  
	p_username		in	clinops_users.username%type,  
	p_user_role_ids		in	varchar2,  
	p_application_id	in	number  
	);  

procedure email_status_change (
	p_username		clinops_users.username%type,   
	p_old_status		number,
	p_new_status		number
	);   



procedure email_role_change (
	p_username		clinops_users.username%type,   
	p_old_role		clinops_users.user_roles%type,
	p_new_role		clinops_users.user_roles%type
	);   
end CLINOPS_SECURITY_PKG;
/