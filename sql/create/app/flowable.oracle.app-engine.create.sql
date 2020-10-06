

CREATE TABLE ACT_APP_DATABASECHANGELOGLOCK (ID INTEGER NOT NULL, LOCKED NUMBER(1) NOT NULL, LOCKGRANTED TIMESTAMP, LOCKEDBY VARCHAR2(255), CONSTRAINT PK_ACT_APP_DATABASECHANGELOGLO PRIMARY KEY (ID));

DELETE FROM ACT_APP_DATABASECHANGELOGLOCK;

INSERT INTO ACT_APP_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

UPDATE ACT_APP_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:37.354', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

CREATE TABLE ACT_APP_DATABASECHANGELOG (ID VARCHAR2(255) NOT NULL, AUTHOR VARCHAR2(255) NOT NULL, FILENAME VARCHAR2(255) NOT NULL, DATEEXECUTED TIMESTAMP NOT NULL, ORDEREXECUTED INTEGER NOT NULL, EXECTYPE VARCHAR2(10) NOT NULL, MD5SUM VARCHAR2(35), DESCRIPTION VARCHAR2(255), COMMENTS VARCHAR2(255), TAG VARCHAR2(255), LIQUIBASE VARCHAR2(20), CONTEXTS VARCHAR2(255), LABELS VARCHAR2(255), DEPLOYMENT_ID VARCHAR2(10));

CREATE TABLE ACT_APP_DEPLOYMENT (ID_ VARCHAR2(255) NOT NULL, NAME_ VARCHAR2(255), CATEGORY_ VARCHAR2(255), KEY_ VARCHAR2(255), DEPLOY_TIME_ TIMESTAMP, TENANT_ID_ VARCHAR2(255) DEFAULT '', CONSTRAINT PK_ACT_APP_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE ACT_APP_DEPLOYMENT_RESOURCE (ID_ VARCHAR2(255) NOT NULL, NAME_ VARCHAR2(255), DEPLOYMENT_ID_ VARCHAR2(255), RESOURCE_BYTES_ BLOB, CONSTRAINT PK_APP_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_));

ALTER TABLE ACT_APP_DEPLOYMENT_RESOURCE ADD CONSTRAINT ACT_FK_APP_RSRC_DPL FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_APP_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_APP_RSRC_DPL ON ACT_APP_DEPLOYMENT_RESOURCE(DEPLOYMENT_ID_);

CREATE TABLE ACT_APP_APPDEF (ID_ VARCHAR2(255) NOT NULL, REV_ INTEGER NOT NULL, NAME_ VARCHAR2(255), KEY_ VARCHAR2(255) NOT NULL, VERSION_ INTEGER NOT NULL, CATEGORY_ VARCHAR2(255), DEPLOYMENT_ID_ VARCHAR2(255), RESOURCE_NAME_ VARCHAR2(4000), DESCRIPTION_ VARCHAR2(4000), TENANT_ID_ VARCHAR2(255) DEFAULT '', CONSTRAINT PK_ACT_APP_APPDEF PRIMARY KEY (ID_));

ALTER TABLE ACT_APP_APPDEF ADD CONSTRAINT ACT_FK_APP_DEF_DPLY FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_APP_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_APP_DEF_DPLY ON ACT_APP_APPDEF(DEPLOYMENT_ID_);

INSERT INTO ACT_APP_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', SYSTIMESTAMP, 1, '7:ec9776f6c57a3953c7d27499108df3d1', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', 'EXECUTED', NULL, NULL, '3.5.3', '1993557477');

CREATE UNIQUE INDEX ACT_IDX_APP_DEF_UNIQ ON ACT_APP_APPDEF(KEY_, VERSION_, TENANT_ID_);

INSERT INTO ACT_APP_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', SYSTIMESTAMP, 2, '7:4ef4a0a9e9cfb636c22126d540cdd38e', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', 'EXECUTED', NULL, NULL, '3.5.3', '1993557477');

UPDATE ACT_APP_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

