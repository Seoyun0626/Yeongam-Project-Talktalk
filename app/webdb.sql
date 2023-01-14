CREATE DATABASE webdb;

CREATE USER 'webservice'@'%' IDENTIFIED BY 'webservice';
GRANT ALL PRIVILEGES ON webdb.* TO 'webservice'@'%' WITH GRANT OPTION;
GRANT SUPER ON *.* TO 'webservice'@'%';
GRANT SELECT ON appdb.* TO 'webservice'@'%';

flush privileges;

DROP TABLE IF EXISTS webdb.`tb_user`;

CREATE TABLE webdb.`tb_user` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `reg_no` varchar(30) NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_role` int(4) NULL,
  `age_class_code` int(4) NULL,
  `sex_class_code` int(1) NULL,
  `emd_class_code` int(4) NULL,
  `user_email` varchar(50) NULL,
  `salt` varchar(255) NOT NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE webdb.`tb_policy` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(50) NOT NULL,
  `policy_target` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `policy_supervision` varchar(30) NOT NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `fund` int(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*
CREATE TABLE webdb.`tb_user` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `user_type` varchar(255) NOT NULL,
  `reg_no` varchar(30) NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`dashboard`;

CREATE TABLE webdb.`dashboard` ( 
  `id` INT(11) NOT NULL AUTO_INCREMENT, 
  `name` VARCHAR(50) NULL COMMENT '작성자 이름' COLLATE 'utf8mb4_unicode_ci', 
  `email` VARCHAR(50) NULL COMMENT '작성자 메일주소' COLLATE 'utf8mb4_unicode_ci', 
  `password` VARCHAR(255) NULL COMMENT '글 비밀번호' COLLATE 'utf8mb4_unicode_ci', 
  `subject` TEXT NULL COMMENT '글 제목' COLLATE 'utf8mb4_unicode_ci', 
  `content` LONGTEXT NULL COMMENT '글 내용' COLLATE 'utf8mb4_unicode_ci', 
  `like` SMALLINT(5) UNSIGNED NULL DEFAULT '0' COMMENT '추천수', 
  `hate` SMALLINT(5) UNSIGNED NULL DEFAULT '0' COMMENT '반대수', 
  `hit` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0' COMMENT '조회수', 
  `comment_cnt` SMALLINT(5) UNSIGNED NULL DEFAULT '0' COMMENT '코멘트 개수', 
  `ip` INT(10) UNSIGNED NULL DEFAULT '0' COMMENT 'IP', 
  `created_at` DATETIME NOT NULL COMMENT '글 작성 시간', 
  `updated_at` DATETIME NULL COMMENT '글 수정 시간', 
  `deleted_at` DATETIME NULL COMMENT '글 삭제 시간', 
  PRIMARY KEY (`id`) USING BTREE 
) COLLATE='utf8mb4_unicode_ci' ENGINE=InnoDB;

DROP TABLE IF EXISTS webdb.`tb_device`;

CREATE TABLE webdb.`tb_device` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `prj_grp` varchar(260) NOT NULL,
  `sen_grp` varchar(260) NOT NULL,
  `manufact` varchar(260) NULL,
  `sen_name` varchar(260) NULL,
  `model_nm` varchar(260) NULL,
  `sen_type` varchar(260) NULL,
  `sen_cntnt` longtext,
  `sen_url` varchar(255) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_sensor`;

CREATE TABLE webdb.`tb_sensor` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `dev_board_idx` int(11) NOT NULL,
  `sen_mng_no` varchar(18) NULL,
  `sen_id` varchar(260) NOT NULL,
  `inst_loc` varchar(30) NULL,
  `sen_name` varchar(260) NULL,
  `sen_stat` varchar(1) NULL,
  `strt_date` varchar(8) NULL,
  `end_date` varchar(8) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_file`;

CREATE TABLE webdb.`tb_file` (
  `board_idx` int(11) NOT NULL,
  `board_type` varchar(20) NOT NULL,
  `file_no` int(11) NOT NULL,
  `file_type` varchar(3) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `org_file_name` varchar(260) NOT NULL,
  `save_file_name` varchar(36) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `file_path` varchar(260) NOT NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`, `board_type`, `file_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_project`;

CREATE TABLE webdb.`tb_project` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `board_subject` varchar(260) NOT NULL,
  `board_content` longtext,
  `prj_type` varchar(3) NULL,
  `strt_date` varchar(8) NULL,
  `end_date` varchar(8) NULL,
  `read_auth` varchar(1) NOT NULL DEFAULT 'N',
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_subproject`;

CREATE TABLE webdb.`tb_subproject` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `prj_board_idx` int(11) NOT NULL,
--  `sen_board_idx` int(11) NULL,
  `board_subject` varchar(260) NOT NULL,
  `board_content` longtext,
  `prj_type` varchar(3) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`, `prj_board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_monsensor`;

CREATE TABLE webdb.`tb_monsensor` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `sub_board_idx` int(11) NOT NULL,
--  `dev_board_idx` int(11) NULL,
  `sensor_board_idx` int(11) NULL,
--  `board_subject` varchar(260) NOT NULL,
--  `board_content` longtext,
--  `sensor_id` varchar(255) NULL,
--  `device_code` varchar(2) NULL,
--  `sensor_code` varchar(2) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`, `sub_board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_cart`;

CREATE TABLE webdb.`tb_cart` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `tb_board_idx` int(11) NOT NULL,
  `use_type` varchar(1) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_usergrp`;

CREATE TABLE webdb.`tb_usergrp` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `grp_name` varchar(255) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_usergrpdtl`;

CREATE TABLE webdb.`tb_usergrpdtl` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `usergrp_board_idx` int(11) NULL,
  `usr_board_idx` int(11) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_access`;

CREATE TABLE webdb.`tb_access` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `tb_board_idx` int(11) NULL,
  `board_type` varchar(20) NULL,
  `usergrp_board_idx` int(11) NULL,
  `grp_name` varchar(255) NULL,
  `access_type` varchar(3) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_datause`;

CREATE TABLE webdb.`tb_datause` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_board_idx` int(11) NULL,
  `permit_type` varchar(1) NOT NULL DEFAULT 'N',
  `req_dtl` longtext,
  `strt_date` varchar(8) NULL,
  `end_date` varchar(8) NULL,
  `datafile_type` varchar(3) NULL,
  `data_cnt` int(11) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_dataif`;

CREATE TABLE webdb.`tb_dataif` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_board_idx` int(11) NULL,
  `permit_type` varchar(1) NOT NULL DEFAULT 'N',
  `req_dtl` longtext,
  `strt_date` varchar(8) NULL,
  `end_date` varchar(8) NULL,
  `if_type` varchar(3) NULL,
  `if_subtype` varchar(3) NULL,
  `hostip` varchar(15) NULL,
  `port` varchar(8) NULL,
  `userid` varchar(255) NULL,
  `password` varchar(255) NULL,
  `dbname` varchar(255) NULL,
  `tbname` varchar(255) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_stat`;

CREATE TABLE webdb.`tb_stat` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_board_idx` int(11) NULL,
  `stat_type` varchar(2) NULL,
  `sen_date` varchar(8) NULL,
  `sen_count` int(11) NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS webdb.`tb_dataupload`;

CREATE TABLE webdb.`tb_dataupload` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_board_idx` int(11) NULL,
  `proc_type` varchar(1) NOT NULL DEFAULT 'N',
  `data_cnt` int(11) NULL,
  `req_dtl` longtext,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ins_id` varchar(30) NOT NULL,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/
/* FOREIGN KEY (board_idx) REFERENCES tb_sensor (board_idx) */
/*
ALTER TABLE webdb.tb_monsensor DROP COLUMN sen_mng_no;

ALTER TABLE webdb.tb_user ADD COLUMN reg_no varchar(30) NULL;
ALTER TABLE webdb.tb_datause ADD COLUMN `data_cnt` int(11) NULL;
ALTER TABLE webdb.tb_sensor ADD COLUMN `strt_date` varchar(8) NULL;
ALTER TABLE webdb.tb_sensor ADD COLUMN sen_mng_no varchar(18) NULL;
ALTER TABLE webdb.tb_sensor MODIFY COLUMN sen_mng_no varchar(18) NULL;
ALTER TABLE webdb.tb_usergrp MODIFY COLUMN usr_board_idx int(11) NULL;
ALTER TABLE webdb.tb_datause MODIFY COLUMN `permit_type` varchar(1) NOT NULL DEFAULT 'N';

ALTER TABLE appdb.sensor ADD INDEX idx_senid (senid);
ALTER TABLE appdb.sensor ADD INDEX idx_download (sendatetime, senid);

ALTER TABLE webdb.tb_datause ADD COLUMN `file_type` varchar(3) NULL;
ALTER TABLE webdb.tb_sensor ADD COLUMN `sen_stat` varchar(1) NULL;
ALTER TABLE webdb.tb_sensor ADD COLUMN `end_date` varchar(8) NULL;

ALTER TABLE webdb.tb_monsensor ADD COLUMN `sensor_board_idx` int(11) NULL;
ALTER TABLE webdb.tb_monsensor MODIFY COLUMN dev_board_idx int(11) NULL;

ALTER TABLE webdb.tb_device ADD COLUMN `sen_url` varchar(255) NULL;

ALTER TABLE webdb.tb_project ADD COLUMN `strt_date` varchar(8) NULL;
ALTER TABLE webdb.tb_project ADD COLUMN `end_date` varchar(8) NULL;
ALTER TABLE webdb.tb_sensor ADD COLUMN `prj_type` varchar(4) NULL;
ALTER TABLE webdb.tb_sensor ADD COLUMN `stop_date` varchar(8) NULL;
ALTER TABLE webdb.tb_access MODIFY COLUMN `access_type` varchar(3) NULL; 

ALTER TABLE webdb.tb_user CHANGE `sn` `board_idx` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE webdb.tb_access CHANGE `usrgrp_board_idx` `usergrp_board_idx` int(11) NULL;
ALTER TABLE webdb.tb_project ADD COLUMN read_auth varchar(1) NOT NULL DEFAULT 'N';

*/