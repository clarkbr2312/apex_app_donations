create or replace package body dl_security_pkg as             
             
	-- constants used for debug    
-- 	gc_debug_level		number	:=	apex_debug.c_log_level_warn;    
   gc_debug_level     number := apex_debug.c_log_level_app_enter;
   gc_app_id          number := '115';
   gc_page_id         number := 50000;
   gc_session_user    varchar2(30) := 'dl_security_pkg';
   gc_workspace_name  varchar2(100) := 'SEASCAPE_DEV';  
	-- constants user for user account statuses   
   gc_account_locked  number := 4;
   gc_account_expired number := 3;
   gc_from_email      varchar2(150) := 'support@donorlink.com';
   function get_user_id (
      p_app_user varchar2
   ) return number is
      l_app_user dl_users.username%type := p_app_user;
      l_user_id  number;
   begin
      select user_id
        into l_user_id
        from dl_users
       where username = l_app_user;

      return l_user_id;
   exception
      when others then
         l_user_id := -1;
   end;



   procedure condition_env is
      l_workspace_id number;
   begin
      l_workspace_id := apex_util.find_security_group_id(p_workspace => 'DONATIONS');
      apex_util.set_security_group_id(p_security_group_id => l_workspace_id);
      apex_debug.enable(p_level => gc_debug_level);
      if v('APP_ID') is null then
         apex_session.create_session(
            p_app_id   => '115',
            p_page_id  => gc_page_id,
            p_username => gc_session_user
         );
      end if;

   end condition_env;

   function hash_password (
      p_username dl_users.username%type,
      p_password dl_users.password%type
   ) return varchar2 is
   begin
      null;
   end;

end dl_security_pkg;