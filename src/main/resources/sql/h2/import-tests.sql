-- h2 dedicated sequence
CREATE SEQUENCE IF NOT EXISTS h2_sequence INCREMENT BY 100000 START WITH 1 CACHE 1;

-- ldap connection 
INSERT INTO ldap_connection(id, uuid, label, provider_url, security_auth, security_principal, security_credentials, creation_date, modification_date) VALUES (50, 'a9b2058f-811f-44b7-8fe5-7a51961eb098', 'baseLDAP', 'ldap://localhost:33389', 'simple', null, null, now(), now());

-- user domain pattern
INSERT INTO ldap_pattern( id, uuid, pattern_type, label, description, auth_command, search_user_command, system, auto_complete_command_on_first_and_last_name, auto_complete_command_on_all_attributes, search_page_size, search_size_limit, completion_page_size, completion_size_limit, creation_date, modification_date) VALUES ( 50, 'e4db2f22-2496-4b7d-b5e5-232872652c68', 'USER_LDAP_PATTERN', 'basePattern', 'basePattern', 'ldap.search(domain, "(&(objectClass=*)(mail=*)(givenName=*)(sn=*)(|(mail="+login+")(uid="+login+")))");', 'ldap.search(domain, "(&(objectClass=*)(mail="+mail+")(givenName="+first_name+")(sn="+last_name+"))");', false, 'ldap.search(domain, "(&(objectClass=*)(mail=*)(givenName=*)(sn=*)(|(&(sn=" + first_name + ")(givenName=" + last_name + "))(&(sn=" + last_name + ")(givenName=" + first_name + "))))");', 'ldap.search(domain, "(&(objectClass=*)(mail=*)(givenName=*)(sn=*)(|(mail=" + pattern + ")(sn=" + pattern + ")(givenName=" + pattern + ")))");', 0, 100, 0, 10, now(), now()); 
INSERT INTO ldap_attribute(id, field, attribute, sync, system, enable, ldap_pattern_id, completion) VALUES (50, 'user_mail', 'mail', false, true, true, 50, true);
INSERT INTO ldap_attribute(id, field, attribute, sync, system, enable, ldap_pattern_id, completion) VALUES (51, 'user_firstname', 'givenName', false, true, true, 50, true);
INSERT INTO ldap_attribute(id, field, attribute, sync, system, enable, ldap_pattern_id, completion) VALUES (52, 'user_lastname', 'sn', false, true, true, 50, true);
INSERT INTO ldap_attribute(id, field, attribute, sync, system, enable, ldap_pattern_id, completion) VALUES (53, 'user_uid', 'uid', false, true, true, 50, false);

-- user provider
INSERT INTO user_provider(id, uuid, provider_type, base_dn, creation_date, modification_date, ldap_connection_id, ldap_pattern_id) VALUES (50, '93fd0e8b-fa4c-495d-978f-132e157c2292', 'LDAP_PROVIDER', 'dc=linshare,dc=org', now(), now(), 50, 50);

INSERT INTO domain_abstract(
	id, type , uuid, label, 
	enable, template, description, default_role, 
	default_locale, purge_step, user_provider_id, 
	domain_policy_id, parent_id, auth_show_order, mailconfig_id, 
	welcome_messages_id, creation_date, modification_date) 
VALUES
-- Top domain (MyDomain)
	(2, 1, 'MyDomain', 'MyDomain', 
	true, false, 'a simple description', 0, 
	'en','IN_USE', null, 1, 
	1, 2, null, 1,
	 now(), now()),
-- Sub domain (MySubDomain)
	(3, 2, 'MySubDomain', 'MySubDomain', 
	true, false, 'a simple description', 0, 
	'en','IN_USE', 50, 1, 
	2, 3, null, 1, 
	now(), now()),
-- Guest domain (example domain)
	(4, 3, 'GuestDomain', 'GuestDomain',
	true, false, 'a simple description', 0,
	'en','IN_USE', null, 1,
	2, 4, null, 1,
	now(), now());

SET @my_domain_id = SELECT 2;
SET @my_sub_domain_id = SELECT 3;
SET @guest_domain_id = SELECT 4;


UPDATE domain_abstract SET mime_policy_id=1 WHERE id < 100000;
UPDATE domain_abstract SET mailconfig_id = 1;



-- LinShare Users 
INSERT INTO account(
	id, mail, account_type, ls_uuid, 
	creation_date, modification_date, role_id, locale, 
	external_mail_locale, cmis_locale, enable, password, 
	destroyed, domain_id, purge_step, first_name, 
	last_name, can_upload, comment, restricted, 
	CAN_CREATE_GUEST, inconsistent) 
VALUES
-- John Do  (10)
	(10, 'user1@linshare.org', 2, 'aebe1b64-39c0-11e5-9fa8-080027b8274b', 
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	0, @my_domain_id , 'IN_USE', 'John', 
	'Do', true, '', false, 
	true, false),
-- Jane smith (11)
	(11, 'user2@linshare.org', 2, 'd896140a-39c0-11e5-b7f9-080027b8274b', 
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	0, @my_domain_id , 'IN_USE', 'Jane', 
	'Simth', true, '', false, 
	true, false),
-- Foo Bar (12)	
	(12, 'user3@linshare.org', 2, 'e524e1ba-39c0-11e5-b704-080027b8274b', 
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	0, @my_domain_id , 'IN_USE', 'Foo', 
	'Bar', true, '', false, 
	true, false),
-- Guest (13)	
	(13, 'guest@linshare.org', 3, '46455499-f703-46a2-9659-24ed0fa0d63c', 
	now(), now(), 0, 'en', 
	'en', 'en', true, 'JYRd2THzjEqTGYq3gjzUh2UBso8=', 
	0, @guest_domain_id , 'IN_USE', 'Guest', 
	'Test', true, '', false, 
	true, false);
	
SET @john_do_id = SELECT 10;
SET @jane_simth_id = SELECT 11;
SET @foo_bar_id = SELECT 12;
SET @guest1_id = SELECT 13;


-- WORKGROUPS 
INSERT INTO account(
	id, mail, account_type, ls_uuid,
	creation_date, modification_date, role_id, locale, 
	external_mail_locale, cmis_locale, enable, password, 
	destroyed, domain_id, purge_step) 
VALUES
	(20, 'cf32c1e4-4f44-11ea-9f38-f7f9633276e3', 5, 'cf32c1e4-4f44-11ea-9f38-f7f9633276e3', 
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	false, @my_domain_id , 'IN_USE'),
	
	(21, 'd5a8e558-4f44-11ea-bacf-4ff46dad21b7', 5, 'd5a8e558-4f44-11ea-bacf-4ff46dad21b7',
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	false, @my_domain_id, 'IN_USE'),
	
	(22, 'da79e852-4f44-11ea-90a3-238dff97526d', 5, 'da79e852-4f44-11ea-90a3-238dff97526d', 
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	0, @my_domain_id, 'IN_USE'),
	
	(23, 'dabb0364-4f44-11ea-9fe7-eb275404c745', 5, 'dabb0364-4f44-11ea-9fe7-eb275404c745', 
	now(), now(), 0, 'en', 
	'en', 'en', true, null, 
	0, @my_domain_id, 'IN_USE');
	
INSERT INTO thread (account_id, name) VALUES (20, 'Linagora');
INSERT INTO thread (account_id, name) VALUES (21, 'RATP');
INSERT INTO thread (account_id, name) VALUES (22, 'THREAD_TEST_A');
INSERT INTO thread (account_id, name) VALUES (23, 'THREAD_TEST_B');
SET @workgroup_20_id = SELECT 20;
SET @workgroup_21_id = SELECT 21;
SET @workgroup_22_id = SELECT 22;
SET @workgroup_23_id = SELECT 23;


UPDATE policy SET status = true where id=27;


--- QUOTA insertions


-- MyDomain QUOTA
INSERT INTO quota(
	id, uuid, creation_date, modification_date, batch_modification_date,
	current_value, last_value, domain_id, domain_parent_id,
	quota, quota_override, quota_warning, default_quota,
	default_quota_override, quota_type, current_value_for_subdomains)
VALUES (
	2, '164783e8-b9d1-11e5-87e9-bfc0aac925c2', NOW(), NOW(), null,
	6666666, 0, @my_domain_id , 1,
	1000000000000, false, 1000000000000, 1000000000000,
	 false, 'DOMAIN_QUOTA', 0);
UPDATE quota SET 
	domain_shared_override = false,
	domain_shared = false 
WHERE id = 2;
UPDATE quota SET 
	default_domain_shared_override = false,
	default_domain_shared = false
WHERE id = 2;
SET @quota_my_domain_id = SELECT 2;
-- quota : 1 To
-- quota_warning : 1000000000000 : 1 To
-- default_quota : 1000000000000 : 1 To (1 To per sub domain)

-- 'CONTAINER_QUOTA', 'USER' for MyDomain
INSERT INTO quota(
	id, uuid, creation_date, modification_date, batch_modification_date,
	quota_domain_id, current_value, last_value, domain_id, domain_parent_id,
	quota, quota_override, quota_warning, default_quota, default_quota_override,
	default_max_file_size, default_max_file_size_override, default_account_quota, default_account_quota_override,
	max_file_size, max_file_size_override, account_quota, account_quota_override,
	quota_type, container_type, shared)
VALUES (
	3, '37226d66-b9d2-11e5-b4d8-f7b730449724', NOW(), NOW(), null,
	@quota_my_domain_id , 0, 0, @my_domain_id , 1,
	400000000000, false, 400000000000, 400000000000, false,
	10000000000, false, 100000000000, false,
	10000000000, false, 100000000000, false,
	'CONTAINER_QUOTA', 'USER', false);
SET @quota_on_my_domain_container_user_id = SELECT 3;	
-- quota : 400000000000 : 400 Go for all users
-- quota_warning : 400000000000 : 400 Go
-- default_quota : 400000000000 : 400 Go
-- default_max_file_size : 10000000000  : 10 Go
-- default_account_quota : 100000000000 : 100 Go
-- max_file_size : 10000000000  : 10 Go
-- account_quota : 100000000000 : 100 Go


-- 'CONTAINER_QUOTA', 'WORK_GROUP' for MyDomain
INSERT INTO quota(id, uuid, creation_date, modification_date,
	batch_modification_date, quota_domain_id, current_value, last_value,
	domain_id, domain_parent_id, quota, quota_override, 
	quota_warning, default_quota, default_quota_override, default_max_file_size, 
	default_max_file_size_override, default_account_quota, default_account_quota_override, max_file_size, 
	max_file_size_override, account_quota, account_quota_override, quota_type, 
	container_type, shared)
VALUES ( 4, '6a442450-b9d2-11e5-8c67-5b2367500fc4', NOW(), NOW(),
	null, @quota_my_domain_id , 0, 0, 
	@my_domain_id , 1, 400000000000, false,
	400000000000, 400000000000, false, 10000000000, 
	false, 400000000000, false, 10000000000, 
	false, 400000000000, false, 'CONTAINER_QUOTA', 
	'WORK_GROUP', true);
SET @quota_on_my_domain_container_workgroup_id = SELECT 4;	
-- quota : 400000000000 : 400 Go for all workgroups
-- quota_warning : 400000000000 : 400 Go
-- default_quota : 400000000000 : 400 Go
-- default_max_file_size : 10000000000  : 10 Go
-- default_account_quota : 400000000000 : 400 Go, also 400 Go for one workgroup
-- max_file_size : 10000000000  : 10 Go
-- account_quota : 400000000000 : 400 Go, also 400 Go for one workgroup

-- MyDomain ACCOUNT_QUOTA - John (10)
INSERT INTO quota (
	id, uuid, creation_date, modification_date, batch_modification_date,
	quota_domain_id, quota_container_id, current_value, last_value,
	domain_id, account_id, domain_parent_id, quota,
	quota_warning, max_file_size, container_type, quota_type,
	domain_shared_override, domain_shared)
VALUES (
	111, '1fadebd2-4cdc-11ea-a153-b3bffa7a6089', NOW(), NOW(), NOW(),
	@quota_my_domain_id , @quota_on_my_domain_container_user_id , 0, 0,
	@my_domain_id , @john_do_id , 1, 100000000000,
	100000000000, 1000000, null, 'ACCOUNT_QUOTA',
	false, false);
SET @quota_account_jhon_id = SELECT 111;	
-- quota : 100 Go
-- max_file_size : 10 Go
	
-- MyDomain ACCOUNT_QUOTA - Jane (11)
INSERT INTO quota (
	id, uuid, creation_date, modification_date, batch_modification_date,
	quota_domain_id, quota_container_id, current_value, last_value,
	domain_id, account_id, domain_parent_id, quota,
	quota_warning, max_file_size, container_type, quota_type,
	domain_shared_override, domain_shared)
VALUES (
	122, '0f3771b0-4cdc-11ea-9b45-7fefda9e3980', NOW(), NOW(), NOW(),
	@quota_my_domain_id, @quota_on_my_domain_container_user_id, 0, 0,
	@my_domain_id , @jane_simth_id , 1, 100000000000,
	100000000000, 1000000, null, 'ACCOUNT_QUOTA',
	false, false);
SET @quota_account_jane_id = SELECT 122;	
-- quota : 100 Go
-- max_file_size : 10 Go	
	
-- MyDomain ACCOUNT_QUOTA - Foo (12)
INSERT INTO quota (
	id, uuid, creation_date, modification_date, batch_modification_date,
	quota_domain_id, quota_container_id, current_value, last_value,
	domain_id, account_id, domain_parent_id, quota,
	quota_warning, max_file_size, container_type, quota_type,
	domain_shared_override, domain_shared)
VALUES (
	133, '17dfa008-4cdc-11ea-9db9-d7476f882ea8', NOW(), NOW(), NOW(),
	@quota_my_domain_id, @quota_on_my_domain_container_user_id, 0, 0,
	@my_domain_id , @foo_bar_id , 1, 100000000000,
	100000000000, 1000000, null, 'ACCOUNT_QUOTA',
	false, false);
SET @quota_account_foo_id = SELECT 133;
-- quota : 100 Go
-- max_file_size : 10 Go


-- MyDomain, ACCOUNT_QUOTA - workgroup (20)
INSERT INTO quota (
	id, uuid, creation_date, modification_date, batch_modification_date,
	quota_domain_id, quota_container_id, current_value, last_value,
	domain_id, account_id, domain_parent_id, quota,
	quota_warning, max_file_size, container_type, quota_type)
VALUES 
	(103, 'b87b9700-4f44-11ea-8b3e-bbbf9093ff0e', NOW(), NOW(), NOW(),
	@quota_my_domain_id, @quota_on_my_domain_container_workgroup_id , 700, 0,
	@my_domain_id , @workgroup_20_id , null, 1000,
	800, 5, null, 'ACCOUNT_QUOTA'),
-- MyDomain, ACCOUNT_QUOTA - workgroup (21)
	(104, 'bd0f0b44-4f44-11ea-ae4f-bbde575ffbd3', NOW(), NOW(), NOW(),
	@quota_my_domain_id , @quota_on_my_domain_container_workgroup_id, 500, 200,
	@my_domain_id , @workgroup_21_id , null, 1300,
	1000, 6, null, 'ACCOUNT_QUOTA');
SET @quota_workgroup_20_id = SELECT 103;
SET @quota_workgroup_21_id = SELECT 104;

-- MySubDomain QUOTA
INSERT INTO quota(id, uuid, creation_date, modification_date,
	batch_modification_date, current_value, last_value, domain_id,
	domain_parent_id, quota, quota_override, quota_warning,
	default_quota, default_quota_override, quota_type, current_value_for_subdomains)
VALUES ( 5, 'b69b9d1a-b9d2-11e5-aab9-e337a9ab2b58', NOW(), NOW(),
	null, 0, 0, @my_sub_domain_id ,
	@my_domain_id , 1000000000000, false, 1000000000000,
	1000000000000, false, 'DOMAIN_QUOTA', 0);
-- quota : 1 To
-- quota_warning : 1000000000000 : 1 To
-- default_quota : 1000000000000 : 1 To (1 To per sub domain)
UPDATE quota SET 
	domain_shared_override = false,
	domain_shared = false
WHERE id = 5;
UPDATE quota SET 
	default_domain_shared_override = null,
	default_domain_shared = null
WHERE id = 5;
SET @quota_my_subdomain_id = SELECT 5;

-- 'CONTAINER_QUOTA', 'USER' for MySubDomain
INSERT INTO quota(id, uuid, creation_date, modification_date, 
	batch_modification_date, quota_domain_id, current_value, last_value, 
	domain_id, domain_parent_id, quota, quota_override, 
	quota_warning, default_quota, default_quota_override, default_max_file_size, 
	default_max_file_size_override, default_account_quota, default_account_quota_override, max_file_size, 
	max_file_size_override, account_quota, account_quota_override, quota_type, 
	container_type, shared)
VALUES ( 6, 'f8733bd0-b9d2-11e5-a247-2b9505cfdddf', NOW(), NOW(), 
	null, 5, 0, 0, 
	@my_sub_domain_id , @my_domain_id , 400000000000, false, 
	400000000000, 400000000000, false, 10000000000, 
	false, 100000000000, false, 10000000000, 
	false, 100000000000, false, 'CONTAINER_QUOTA', 
	'USER', false);
SET @quota_onsubdomain_container_user_id = SELECT 6;	
-- quota : 400000000000 : 400 Go for all users
-- quota_warning : 400000000000 : 400 Go
-- default_quota : 400000000000 : 400 Go
-- default_max_file_size : 10000000000  : 10 Go
-- default_account_quota : 100000000000 : 100 Go
-- max_file_size : 10000000000  : 10 Go
-- account_quota : 100000000000 : 100 Go


-- 'CONTAINER_QUOTA', 'WORK_GROUP' for MySubDomain
INSERT INTO quota(id, uuid, creation_date, modification_date,
	batch_modification_date, quota_domain_id, current_value, last_value, 
	domain_id, domain_parent_id, quota, quota_override, 
	quota_warning, default_quota, default_quota_override, default_max_file_size, 
	default_max_file_size_override, default_account_quota, default_account_quota_override, max_file_size, 
	max_file_size_override, account_quota, account_quota_override, quota_type, 
	container_type, shared)
VALUES ( 7, '002310d0-b9d3-11e5-9413-d3f63c53e650', NOW(), NOW(), 
	null, 5, 0, 0, 
	@my_sub_domain_id , @my_domain_id , 400000000000, false, 
	400000000000, 400000000000, false, 10000000000, 
	false, 400000000000, false, 10000000000, 
	false, 400000000000, false, 'CONTAINER_QUOTA', 
	'WORK_GROUP', true);
SET @quota_onsubdomain_container_workgroup_id = SELECT 7;
-- quota : 400000000000 : 400 Go for all workgroups
-- quota_warning : 400000000000 : 400 Go
-- default_quota : 400000000000 : 400 Go
-- default_max_file_size : 10000000000  : 10 Go
-- default_account_quota : 400000000000 : 400 Go, also 400 Go for one workgroup
-- max_file_size : 10000000000  : 10 Go
-- account_quota : 400000000000 : 400 Go, also 400 Go for one workgroup


-- GuestDomain QUOTA
INSERT INTO quota(id, uuid, creation_date, modification_date, 
	batch_modification_date, current_value, last_value, domain_id, 
	domain_parent_id, quota, quota_override, quota_warning, 
	default_quota, default_quota_override, quota_type, current_value_for_subdomains)
VALUES ( 8, '0b866494-b9d4-11e5-be35-afca154efca0', NOW(), NOW(),
	null, 0, 0, @guest_domain_id , 
	@my_domain_id , 1000000000000, false, 1000000000000, 
	1000000000000, false, 'DOMAIN_QUOTA', 0);
-- quota : 1 To
-- quota_warning : 1000000000000 : 1 To
-- default_quota : 1000000000000 : 1 To (1 To per sub domain)
UPDATE quota SET 
	domain_shared_override = false, 
	domain_shared = false
WHERE id = 8;
UPDATE quota SET 
	default_domain_shared_override = null,
	default_domain_shared = null 
WHERE id = 8;
SET @quota_guest_domain_id = SELECT 8;


-- 'CONTAINER_QUOTA', 'USER' for GuestDomain
INSERT INTO quota(id, uuid, creation_date, modification_date, 
	batch_modification_date, quota_domain_id, current_value, last_value, 
	domain_id, domain_parent_id, quota, quota_override, 
	quota_warning, default_quota, default_quota_override, default_max_file_size, 
	default_max_file_size_override, default_account_quota, default_account_quota_override, 
	max_file_size, max_file_size_override, account_quota, account_quota_override, quota_type, 
	container_type, shared)
VALUES ( 9, '1515e6e2-b9d4-11e5-997e-0b5792ea886a', NOW(), NOW(), 
	null, 8, 0, 0, 
	@guest_domain_id , @my_sub_domain_id , 400000000000, false, 
	400000000000, 400000000000, false, 10000000000, 
	false, 100000000000, false, 10000000000, 
	false, 100000000000, false, 'CONTAINER_QUOTA', 
	'USER', false);
SET @quota_on_guest_domain_container_user_id = SELECT 9;	
-- quota : 400000000000 : 400 Go for all users
-- quota_warning : 400000000000 : 400 Go
-- default_quota : 400000000000 : 400 Go
-- default_max_file_size : 10000000000  : 10 Go
-- default_account_quota : 100000000000 : 100 Go
-- max_file_size : 10000000000  : 10 Go
-- account_quota : 100000000000 : 100 Go


-- 'CONTAINER_QUOTA', 'WORK_GROUP' for GuestDomain
INSERT INTO quota(id, uuid, creation_date, modification_date,
	batch_modification_date, quota_domain_id, current_value, last_value, 
	domain_id, domain_parent_id, quota, quota_override, 
	quota_warning, default_quota, default_quota_override, default_max_file_size, 
	default_max_file_size_override, default_account_quota, default_account_quota_override, max_file_size, 
	max_file_size_override, account_quota, account_quota_override, quota_type, 
	container_type, shared)
VALUES ( 10, '1f468522-b9d4-11e5-916d-a713a67dd225', NOW(), NOW(), 
	null, 8, 0, 0, 
	@guest_domain_id , @my_domain_id , 400000000000, false, 
	400000000000, 400000000000, false, 10000000000, 
	false, 400000000000, false, 10000000000, 
	false, 400000000000, false, 'CONTAINER_QUOTA', 
	'WORK_GROUP', true);
SET @quota_on_guest_domain_container_workgroup_id = SELECT 9;	
-- quota : 400000000000 : 400 Go for all workgroups
-- quota_warning : 400000000000 : 400 Go
-- default_quota : 400000000000 : 400 Go
-- default_max_file_size : 10000000000  : 10 Go
-- default_account_quota : 400000000000 : 400 Go, also 400 Go for one workgroup
-- max_file_size : 10000000000  : 10 Go
-- account_quota : 400000000000 : 400 Go, also 400 Go for one workgroup






-- TESTS

-- default domain policy
INSERT INTO domain_access_policy(id, creation_date, modification_date) VALUES (100001, now(), now());
INSERT INTO domain_access_rule(id, domain_access_rule_type, domain_id, domain_access_policy_id, rule_index) VALUES (100001, 0, null, 100001,0);
INSERT INTO domain_policy(id, uuid, label, domain_access_policy_id) VALUES (100001, 'TestAccessPolicy0-test', 'TestAccessPolicy0-test', 100001);


-- Root domain (application domain)
INSERT INTO domain_abstract(id, type , uuid, label, enable, template, description, default_role, default_locale, purge_step, user_provider_id, domain_policy_id, parent_id, welcome_messages_id, creation_date, modification_date) VALUES (100001, 0, 'TEST_Domain-0', 'TEST_Domain-0', true, false, 'The root test application domain', 3, 'en','IN_USE', null, 100001, null, 1, now(), now());
-- id : 100001

-- topDomainName
-- id : 100002
INSERT INTO domain_abstract(id, type , uuid, label, enable, template, description, default_role, default_locale, purge_step, user_provider_id, domain_policy_id, parent_id, auth_show_order, welcome_messages_id, creation_date, modification_date) VALUES (100002, 1, 'TEST_Domain-0-1', 'TEST_Domain-0-1 (Topdomain)', true, false, 'a simple description', 0, 'en','IN_USE', null, 100001, 100001, 2, 1, now(), now());

-- topDomainName2
-- id : 100003
INSERT INTO domain_abstract(id, type , uuid, label, enable, template, description, default_role, default_locale, purge_step, user_provider_id, domain_policy_id, parent_id, auth_show_order, welcome_messages_id, creation_date, modification_date) VALUES (100003, 1, 'TEST_Domain-0-2', 'TEST_Domain-0-2 (Topdomain)', true, false, 'a simple description', 0, 'en','IN_USE', null, 100001, 100001, 3, 1, now(), now());

-- subDomainName1
-- id : 100004
INSERT INTO domain_abstract(id, type , uuid, label, enable, template, description, default_role, default_locale, purge_step, user_provider_id, domain_policy_id, parent_id, auth_show_order, welcome_messages_id, creation_date, modification_date) VALUES (100004, 2, 'TEST_Domain-0-1-1', 'TEST_Domain-0-1-1 (Subdomain)', true, false, 'a simple description', 0, 'en','IN_USE', null, 100001, 100002, 4, 1, now(), now());

-- subDomainName2
-- id : 100005
INSERT INTO domain_abstract(id, type , uuid, label, enable, template, description, default_role, default_locale, purge_step, user_provider_id, domain_policy_id, parent_id, auth_show_order, welcome_messages_id, creation_date, modification_date) VALUES (100005, 2, 'TEST_Domain-0-1-2', 'TEST_Domain-0-1-2 (Subdomain)', true, false, 'a simple description', 0, 'en','IN_USE', null, 100001, 100002, 5, 1, now(), now());


-- Guest domain (example domain)
-- id : 100006
INSERT INTO domain_abstract(id, type , uuid, label, enable, template, description, default_role, default_locale, purge_step, user_provider_id, domain_policy_id, parent_id, auth_show_order, welcome_messages_id, creation_date, modification_date) VALUES (100006, 3, 'guestDomainName1', 'guestDomainName1 (GuestDomain)', true, false, 'a simple description', 0, 'en','IN_USE', null, 100001, 100002, 6, 1, now(), now());

-- Default mime policy
INSERT INTO mime_policy(id, domain_id, uuid, name, mode, displayable, creation_date, modification_date) VALUES(100001, 100001, 'ec51317c-086c-442a-a4bf-1afdf8774079', 'Default Mime Policy de test', 0, 0, now(), now());
UPDATE domain_abstract SET mime_policy_id=1 WHERE id >= 100001;



INSERT INTO account(id, Mail, account_type, ls_uuid, creation_date, modification_date, role_id, locale, external_mail_locale, cmis_locale, enable, password, destroyed, domain_id, purge_step, First_name, Last_name, Can_upload, Comment, Restricted, CAN_CREATE_GUEST, inconsistent) 
VALUES (100001, 'root@localhost.localdomain@test', 6, 'root@localhost.localdomain@test', current_date(), current_date(), 3, 'en', 'en', 'en', true, 'JYRd2THzjEqTGYq3gjzUh2UBso8=', 0, 100001, 'IN_USE', 'Administrator', 'LinShare', true, '', false, false, false);

-- root domain de test
-- Functionality : TEST_TIME_STAMPING
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110013, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110014, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110007, false, 'TEST_TIME_STAMPING', 110013, 110014, 100001, now(), now());
INSERT INTO functionality_string(functionality_id, string_value) VALUES (110007, 'http://server/service');

-- Functionality : TEST_FILESIZE_MAX
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110001, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110002, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110001, false, 'TEST_FILESIZE_MAX', 110001, 110002, 100001, now(), now());
-- Size : MEGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (110001, 1, 1);
-- Value : 200
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (110001, 200, 110001);


-- Functionality : TEST_QUOTA_GLOBAL
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110003, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110004, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110002, true, 'TEST_QUOTA_GLOBAL', 110003, 110004, 100001, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (110002, 1, 2);
-- Value : 1
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (110002, 1, 110002);


-- Functionality : TEST_QUOTA_USER
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110005, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110006, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110003, false, 'TEST_QUOTA_USER', 110005, 110006, 100001, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (110003, 1, 1);
-- Value : 500
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (110003, 500, 110003);


-- Functionality : GUESTS
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110027, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110028, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110014, true, 'GUESTS', 110027, 110028, 100001, now(), now());


-- Functionality : TEST_FUNC1
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110059, true, true, 2, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110060, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110029, false, 'TEST_FUNC1', 110059, 110060, 100001, now(), now());
INSERT INTO functionality_string(functionality_id, string_value) VALUES (110029, 'blabla');

-- Functionality : TEST_FUNC2
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110061, true, true, 2, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110062, true, true, 2, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES(110030, false, 'TEST_FUNC2', 110061, 110062, 100001, now(), now()); 
INSERT INTO functionality_string(functionality_id, string_value) VALUES (110030, 'blabla');


-- Functionality : TEST_FUNC3
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110049, true, true, 0, true);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110050, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110025, false, 'TEST_FUNC3', 110049, 110050, 100001, now(), now());
INSERT INTO functionality_string(functionality_id, string_value) VALUES (110025, 'blabla');


-- Functionality : TEST_FUNC4
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110017, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110018, true, true, 1, true);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110009, false, 'TEST_FUNC4', 110017, 110018, 100001, now(), now());
INSERT INTO functionality_string(functionality_id, string_value) VALUES (110009, 'blabla');


-- Functionality : TEST_FUNC5
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110025, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110026, false, false, 1, true);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110013, true, 'TEST_FUNC5', 110025, 110026, 100001, now(), now());
INSERT INTO functionality_string(functionality_id, string_value) VALUES (110013, 'blabla');










-- topDomainName 1
-- Functionality : TEST_FILESIZE_MAX
INSERT INTO policy(id, status, default_status, policy, system) VALUES (111001, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (111002, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (111001, false, 'TEST_FILESIZE_MAX', 111001, 111002, 100002, now(), now());
-- Size : MEGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (111001, 1, 1);
-- Value : 200
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (111001, 100, 111001);


-- Functionality : TEST_QUOTA_USER
INSERT INTO policy(id, status, default_status, policy, system) VALUES (111005, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (111006, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (111003, false, 'TEST_QUOTA_USER', 111005, 111006, 100002, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (111003, 1, 1);
-- Value : 500
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (111003, 250, 111003);






-- subDomainName 1
-- Functionality : TEST_FILESIZE_MAX
INSERT INTO policy(id, status, default_status, policy, system) VALUES (112001, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (112002, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (112001, false, 'TEST_FILESIZE_MAX', 112001, 112002, 100004, now(), now());
-- Size : MEGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (112001, 1, 1);
-- Value : 200
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (112001, 50, 112001);

-- subDomainName 2
-- Functionality : TEST_QUOTA_USER
INSERT INTO policy(id, status, default_status, policy, system) VALUES (113005, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (113006, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (113003, false, 'TEST_QUOTA_USER', 113005, 113006, 100005, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (113003, 1, 1);
-- Value : 500
INSERT INTO functionality_unit(functionality_id, integer_value, unit_id) VALUES (113003, 125, 113003);

UPDATE domain_abstract SET mailconfig_id = 1;
