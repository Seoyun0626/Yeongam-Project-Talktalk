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
  `user_role` varchar(1) NULL,
  `user_type` varchar(1) NOT NULL,
  `youthAge_code` varchar(1) NULL,
  `parentsAge_code` varchar(1) NULL,
  `sex_class_code` varchar(1) NULL,
  `emd_class_code` varchar(2) NULL,
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
  `policy_target_code` varchar(2) NOT NULL,
  `policy_institution_code` varchar(2) NOT NULL,
  `description` longtext NULL,
  `policy_field_code` varchar(2) NOT NULL,
  `policy_character_code` varchar(2) NOT NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `application_start_date` timestamp NULL,
  `application_end_date` timestamp NULL,
  `scrap` int(4) NOT NULL DEFAULT '0',
  `views` int(4) NOT NULL DEFAULT '0',
  `fund` int(10) NOT NULL,
  `content` varchar(1000) NULL,
  `img` varchar(30) NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE webdb.`tb_terms` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `terms` varchar(1000) NOT NULL,
  `privacy` varchar(1000) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_terms (terms,privacy) value('회원 가입 약관','개인 정보 처리 방침');


CREATE TABLE webdb.`tb_banner` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `banner_name` varchar(30) NULL,
  `img` varchar(30) NOT NULL,
  `link` varchar(100) NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- join
create table webdb.`tb_user_type`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(1) NOT NULL,
  `user_type_name` varchar(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_user_type (user_type,user_type_name) values('0','청소년'),('1','청소년 부모'),('2','학부모');

create table webdb.`tb_youthAge_code` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `youthAge_code` varchar(1) NOT NULL,
  `youthAge_name` varchar(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_youthAge_code (youthAge_code,youthAge_name) values('0','초등학교'),('1','중학교'),('2','고등학교'),('3','대학교'),('4','기타(학교밖)'),('5','선택 안함');

create table webdb.`tb_parentsAge_code` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `parentsAge_code` varchar(1) NOT NULL,
  `parentsAge_name` varchar(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_parentsAge_code (parentsAge_code,parentsAge_name) values('0','10대'),('1','20대'),('2','30대'),('3','40대'),('4','50대'),('5','60'),('6','선택 안함');

create table webdb.`tb_sex_class_code`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `sex_class_code` varchar(1) NOT NULL,
  `sex_class_name` varchar(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_sex_class_code (sex_class_code,sex_class_name) values('0','남자'),('1','여자'),('2','선택 안함');

create table webdb.`tb_emd_class_code`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `emd_class_code` varchar(2) NOT NULL,
  `emd_class_name` varchar(20) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_emd_class_code (emd_class_code, emd_class_name) values('0','영암읍'),('1','삼호읍'),('2','덕진면'),('3','금정면'),('4','신북면'),('5','시종면'),('6','도표면')
,('7','군서면'),('8','서호면'),('9','학산면'),('10','미암면');

create table webdb.`tb_policy_target_code`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_target_code` varchar(2) NOT NULL,
  `policy_target_name` varchar(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_policy_target_code (policy_target_code, policy_target_name) values('0','부부/임산부'),('1','영유아'),('2','청소년/학생'),('3','청년/대학생'),('4','직장인'),('5','중장년'),('6','노인'),('7','선택 안함');


create table webdb.`tb_policy_institution_code`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_institution_code` varchar(2) NOT NULL,
  `policy_institution_name` varchar(20) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_policy_institution_code (policy_institution_code, policy_institution_name) values('0','영암군'),('1','청소년 수련관'),('2','방과후 아카데미'),('3','청소년상담복지센터'),('4','학교밖지원센터'),('5','삼호읍청소년문화의집');

create table webdb.`tb_policy_field_code`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_field_code` varchar(20) NOT NULL,
  `policy_field_name` varchar(10) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_policy_field_code (policy_field_code, policy_field_name) values('0','학업'),('1','상담'),('2','취업/이직'),('3','생활비'),('4','건강'),('5','주거'),('6','결혼/양육'),('7','청소년활동'),('8','학교밖청소년'),('9','돌봄');

create table webdb.`tb_policy_character_code`(
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_character_code` varchar(2) NOT NULL,
  `policy_character_name` varchar(20) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into tb_policy_character_code (policy_character_code, policy_character_name) values('0','지원.보조금/연금'),('1','도움/서비스'),('2','장학제도'),('3','분양/임대'),('4','공모전'),('5','대출/금융');
