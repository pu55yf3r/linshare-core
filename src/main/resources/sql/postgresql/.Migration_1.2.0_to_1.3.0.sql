b0VIM 7.3      )��Q�� 2*  ben                                     PC-Ben                                  ~ben/workspace/linshare/src/main/resources/sql/postgresql/Migration_1.2.0_to_1.3.0.sql                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       utf-8U3210    #"! U                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 tp                                       L                     ��������)       ?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ad  >  r            �  �  �  �  �  r  #    �  �  }  T    �  �  t  :     �  �  k  9    �  �  �  �  v  Z  >  *  �
  �
  �
  �
  y
  U
  1
  
   
  �	  �	  �	  s	  N	  +	  	  �  �  �  }  U  5    �  �  �  �  �  h  J  /  	  �  �  �  l  8    �  �  �  T  )  �  �  �  �  _  2    �  �  �  �  m  K     �  �  �  �  a  2    �  �  �  �    identifier            varchar(255) NOT NULL,    domain_pattern_id      int8 NOT NULL,  CREATE TABLE domain_pattern (     PRIMARY KEY (id));   CONSTRAINT linshare_domain_access_rule_pkey    rule_index              int4,    domain_access_policy_id int8 NOT NULL,    domain_id               int8,    regexp                  varchar(255),    domain_access_rule_type int4 NOT NULL,    id                       int8 NOT NULL,  CREATE TABLE domain_access_rule (     PRIMARY KEY (id));   CONSTRAINT linshare_domain_access_policy_pkey    id  int8 NOT NULL,  CREATE TABLE domain_access_policy (     PRIMARY KEY (id));   CONSTRAINT linshare_domain_abstract_pkey    auth_show_order           int8 NOT NULL,     messages_configuration_id int8 NOT NULL,    parent_id                 int8,    domain_policy_id          int8 NOT NULL,    user_provider_id          int8,    used_space                int8 NOT NULL,    default_locale            varchar(255),    default_role              int4 NOT NULL,    description               text NOT NULL,    template                  bool NOT NULL,    enable                    bool NOT NULL,    label                     varchar(255) NOT NULL,    identifier                varchar(255) NOT NULL,    type                      int4 NOT NULL,    id                         int8 NOT NULL,  CREATE TABLE domain_abstract (     UNIQUE (entry_id, document_id));   CONSTRAINT "unique document entry"    PRIMARY KEY (entry_id),    ciphered    int2 NOT NULL,    document_id int8 NOT NULL,    entry_id    int8 NOT NULL,  CREATE TABLE document_entry (     PRIMARY KEY (id));   CONSTRAINT linshare_document_pkey    timestamp     bytea,    thmb_uuid     varchar(255),    size          int8 NOT NULL,    type          varchar(255) NOT NULL,    creation_date timestamp(6) NOT NULL,    uuid          varchar(255) NOT NULL UNIQUE,    id             int8 NOT NULL,  CREATE TABLE document (     PRIMARY KEY (cookie_id));   CONSTRAINT linshare_cookie_pkey    last_use   timestamp(6) NOT NULL,    value      varchar(255) NOT NULL,    user_name  varchar(255) NOT NULL,    identifier varchar(255) NOT NULL,    cookie_id   int8 NOT NULL,  CREATE TABLE cookie (   PRIMARY KEY (entry_id));   anonymous_url_id  int8 NOT NULL,    document_entry_id int8 NOT NULL,    downloaded        int8 NOT NULL,    entry_id          int8 NOT NULL,  CREATE TABLE anonymous_share_entry (     PRIMARY KEY (id));   CONSTRAINT linshare_allowed_mimetype_pkey    status     int4,    mimetype   varchar(255),    extensions varchar(255),    id          int8 NOT NULL,  CREATE TABLE allowed_mimetype (     PRIMARY KEY (id));   CONSTRAINT account_pkey    account_id                      int8,     thread_view_id                  int8,    destroyed                       bool NOT NULL,    password                        varchar(255),    account_type                    int4 NOT NULL,    enable                          bool NOT NULL,    external_mail_locale            varchar(255) NOT NULL,    locale                          varchar(255) NOT NULL,    role_id                         int4 NOT NULL,    modification_date               timestamp(6) NOT NULL,    creation_date                   timestamp(6) NOT NULL,    ls_uuid                         varchar(255) NOT NULL,    owner_id                        int8,    technical_account_permission_id int8,    domain_id                       int8 NOT NULL,    id                               int8 NOT NULL,   CREATE TABLE account ( CCREATE SEQUENCE hibernate_sequence INC  extern  destroyed                       bool NOT NULL,   SET default_with_oids = false; SET client_min_messages = warning; SET client_encoding = 'UTF8'; SET statement_timeout = 0; ad    k     L       �  �  �  {  [  =  !    �  �  �  �  d  @    �  �  �  �  �  _  :    �  �  �  �  l  D    �  �  �  �  �  k  M  /    �
  �
  �
  �
  _
  3
  �	  �	  �	  s	  G	  	  �  �  �  u  R  &  �  �  �  �  |  K  4    �  �  �  s  I  (  �  �  �  �  k  9    �  �  j  0  �  �  �  P  '  �  �  �  �  !                                                                                                                                                             identifier            varchar(255) NOT NULL,    domain_pattern_id      int8 NOT NULL,  CREATE   identifier             identifier            varchar(255) NOT NULL,    do  identifier            varchar(255) NOT NULL,      identifier            varchar(255) NOT   identifier            varchar(255) NOT   identifier            varchar(255) NOT NULL,    domain_p  identifier            varchar(255) NOT NULL,    domain_p  identifier            varchar(255) NOT NULL,    domain_p  identifier            varchar(255) NOT NULL,      identifier            varchar(255) NOT NULL,    domain_p  identifier            varchar(255) NOT NULL,    domain_p  identifier            varchar(255) NOT NULL,      identifier            varchar(255) NOT NULL,      identifier            varchar(255) NOT NULL,     identifier            varchar(255) NOT NULL,      identifier            varchar(255) NOT NULL,    domain_pattern_id      int8 NOT NULL,  CREATE TABLE domain_pattern (     PRIMARY KEY (id));   CONSTRAINT linshare_domain_access_rule_pkey    rule_index              int4,    domain_access_policy_id int8 NOT NULL,    domain_id               int8,    regexp                  varchar(255),    domain_access_rule_type int4 NOT NULL,    id                       int8 NOT NULL,  CREATE TABLE domain_access_rule (     PRIMARY KEY (id));   CONSTRAINT linshare_domain_access_policy_pkey    id  int8 NOT NULL,  CREATE TABLE domain_access_policy (     PRIMARY KEY (id));   CONSTRAINT linshare_domain_abstract_pkey    auth_show_order           int8 NOT NULL,     messages_configuration_id int8 NOT NULL,    parent_id                 int8,    domain_policy_id          int8 NOT NULL,    user_provider_id          int8,    used_space                int8 NOT NULL,    default_locale            varchar(255),    default_role              int4 NOT NULL,    description               text NOT NULL,    template                  bool NOT NULL,    enable                    bool NOT NULL,    label                     varchar(255) NOT NULL,    identifier                varchar(255) NOT NULL,    type                      int4 NOT NULL,    id                         int8 NOT NULL,  CREATE TABLE domain_abstract (     UNIQUE (entry_id, document_id));   CONSTRAINT "unique document entry"    PRIMARY KEY (entry_id),    ciphered    int2 NOT NULL,    document_id int8 NOT NULL,    entry_id    int8 NOT NULL,  CREATE TABLE document_entry (     PRIMARY KEY (id));   CONSTRAINT linshare_document_pkey    timestamp     bytea,    thmb_uuid     varchar(255),    size          int8 NOT NULL,    type          varchar(255) NOT NULL,    creation_date timestamp(6) NOT NULL,    uuid          varchar(255) NOT NULL UNIQUE,    id             int8 NOT NULL,  CREATE TABLE document (     PRIMARY KEY (cookie_id));   CONSTRAINT linshare_cookie_pkey    last_use   timestamp(6) NOT NULL,    value      varchar(255) NOT NULL,    user_name  varchar(255) NOT NULL,    identifier varchar(255) NOT NULL,    cookie_id   int8 NOT NULL,  CREATE TABLE cookie (   PRIMARY KEY (entry_id));   anonymous_url_id  int8 NOT NULL,    document_entry_id int8 NOT NULL,    downloaded        int8 NOT NULL,    entry_id          int8 NOT NULL,  CREATE TABLE anonymous_share_entry (     PRIMARY KEY (id));   CONSTRAINT linshare_allowed_mimetype_pkey    status     int4,    mimetype   varchar(255),    extensions varchar(255),    id          int8 NOT NULL,  CREATE TABLE allowed_mimetype (     PRIMARY KEY (id));   CONSTRAINT account_pkey    account_id                      int8,     thread_view_id                  int8,  