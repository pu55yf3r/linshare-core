-- h2 dedicated sequence
CREATE SEQUENCE IF NOT EXISTS h2_sequence INCREMENT BY 100000 START WITH 1 CACHE 1;


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



INSERT INTO account(id, Mail, account_type, ls_uuid, creation_date, modification_date, role_id, locale, external_mail_locale, cmis_locale, enable, password, destroyed, domain_id, purge_step, First_name, Last_name, Can_upload, Comment, Restricted, CAN_CREATE_GUEST, inconsistent, authentication_failure_count) 
VALUES (100001, 'root@localhost.localdomain@test', 6, 'root@localhost.localdomain@test', current_date(), current_date(), 3, 'en', 'en', 'en', true, '{bcrypt}$2a$10$LQSvbfb2ZsCrWzPp5lj2weSZCz2fWRDBOW4k3k0UxxtdFIEquzTA6', 0, 100001, 'IN_USE', 'Administrator', 'LinShare', true, '', false, false, false, 0);

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
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (110001, 200, 110001);


-- Functionality : TEST_QUOTA_GLOBAL
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110003, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110004, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110002, true, 'TEST_QUOTA_GLOBAL', 110003, 110004, 100001, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (110002, 1, 2);
-- Value : 1
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (110002, 1, 110002);


-- Functionality : TEST_QUOTA_USER
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110005, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (110006, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (110003, false, 'TEST_QUOTA_USER', 110005, 110006, 100001, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (110003, 1, 1);
-- Value : 500
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (110003, 500, 110003);


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
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (111001, 100, 111001);


-- Functionality : TEST_QUOTA_USER
INSERT INTO policy(id, status, default_status, policy, system) VALUES (111005, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (111006, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (111003, false, 'TEST_QUOTA_USER', 111005, 111006, 100002, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (111003, 1, 1);
-- Value : 500
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (111003, 250, 111003);






-- subDomainName 1
-- Functionality : TEST_FILESIZE_MAX
INSERT INTO policy(id, status, default_status, policy, system) VALUES (112001, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (112002, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (112001, false, 'TEST_FILESIZE_MAX', 112001, 112002, 100004, now(), now());
-- Size : MEGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (112001, 1, 1);
-- Value : 200
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (112001, 50, 112001);

-- subDomainName 2
-- Functionality : TEST_QUOTA_USER
INSERT INTO policy(id, status, default_status, policy, system) VALUES (113005, true, true, 1, false);
INSERT INTO policy(id, status, default_status, policy, system) VALUES (113006, true, true, 1, false);
INSERT INTO functionality(id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, modification_date) VALUES (113003, false, 'TEST_QUOTA_USER', 113005, 113006, 100005, now(), now());
-- Size : GIGA
INSERT INTO unit(id, unit_type, unit_value) VALUES (113003, 1, 1);
-- Value : 500
INSERT INTO functionality_unit(functionality_id, integer_max_value, unit_id) VALUES (113003, 125, 113003);

UPDATE domain_abstract SET mailconfig_id = 1;
