create or replace package "DL_SECURITY_PKG" as
   function get_user_id (
      p_app_user varchar2
   ) return number;

   function hash_password (
      p_username dl_users.username%type,
      p_password dl_users.password%type
   ) return varchar2;

/*
   function authenticate_user (
      p_username in dl_users.username%type,
      p_password in varchar2
   ) return boolean;

   function is_account_locked (
      p_username dl_users.username%type
   ) return boolean;

   function is_account_expired (
      p_username dl_users.username%type
   ) return boolean;

   function too_many_attempts (
      p_username dl_users.username%type
   ) return boolean;

   procedure add_failed_attempt (
      p_username in dl_users.username%type
   );

   function reset_password (
      p_username in dl_users.username%type
   ) return varchar2;

   function set_first_password (
      p_username in dl_users.username%type
   ) return varchar2;
   function is_change_pwd_req (
      p_username dl_users.username%type
   ) return varchar2;

   procedure assign_roles (
      p_username       in dl_users.username%type,
      p_user_role_ids  in varchar2,
      p_application_id in number
   );

   procedure email_status_change (
      p_username   dl_users.username%type,
      p_old_status number,
      p_new_status number
   );

*/
end "DL_SECURITY_PKG";
/