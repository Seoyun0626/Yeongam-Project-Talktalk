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
  `terms_agree` varchar(2) NOT NULL DEFAULT 'x',
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


-- 공통 코드 설계
create table webdb.`tb_common_code`(
  `code` varchar(2) NOT NULL,
  `code_name` varchar(30) NOT NULL,
  `code_english_name` varchar(30) NULL,
  `code_desc` varchar(100) NULL,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`code`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 공통 코드 유형
insert into tb_common_code (code,code_name,code_english_name) values('01','사용자 유형','user_type');
insert into tb_common_code (code,code_name,code_english_name) values('02','청소년/청소년부모 나이','youthAge_code');
insert into tb_common_code (code,code_name,code_english_name) values('03','학부모  나이 코드','parentsAge_code');
insert into tb_common_code (code,code_name,code_english_name) values('04','성별','sex_class_code');
insert into tb_common_code (code,code_name,code_english_name) values('05','읍면동','emd_class_code');
insert into tb_common_code (code,code_name,code_english_name) values('06','정책 대상','policy_target_code');
insert into tb_common_code (code,code_name,code_english_name) values('07','기관','policy_institution_code');
insert into tb_common_code (code,code_name,code_english_name) values('08','분야','policy_field_code');
insert into tb_common_code (code,code_name,code_english_name) values('09','정책 성격','policy_character_code');

-- 공통 코드 설계
create table webdb.`tb_common_code_detail`(
  `code` varchar(2) NOT NULL,
  `code_detail` varchar(2) NOT NULL,
  `code_detail_name` varchar(30) NOT NULL,
  `code_detail_desc` varchar(100) NULL,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`code`,`code_detail`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 공통 코드 유형
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('01','0','청소년'),('01','1','청소년 부모'),('01','2','학부모');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('02','0','초등학교'),('02','1','중학교'),('02','2','고등학교'),('02','3','대학교'),('02','4','기타(학교밖)'),('02','5','선택 안함'); 
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('03','0','10대'),('03','1','20대'),('03','2','30대'),('03','3','40대'),('03','4','50대'),('03','5','60대 이상'),('03','6','선택 안함');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('04','0','남자'),('04','1','여자'),('04','2','선택 안함');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('05','00','영암읍'),('05','01','삼호읍'),('05','02','덕진면'),('05','03','금정면'),('05','04','신북면'),('05','05','시종면'),('05','06','도표면'),('05','07','군서면'),('05','08','서호면'),('05','09','학산면'),('05','10','미암면');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('06','00','부부/임산부'),('06','01','영유아'),('06','02','청소년/학생'),('06','03','청년/대학생'),('06','04','직장인'),('06','05','중장년'),('06','06','노인'),('06','07','선택 안함');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('07','00','영암군'),('07','01','청소년 수련관'),('07','02','방과후 아카데미'),('07','03','청소년상담복지센터'),('07','04','학교밖지원센터'),('07','05','삼호읍청소년문화의집');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('08','00','학업'),('08','01','상담'),('08','02','취업/이직'),('08','03','생활비'),('08','04','건강'),('08','05','주거'),('08','06','결혼/양육'),('08','07','청소년활동'),('08','08','학교밖청소년'),('08','09','돌봄');
insert into tb_common_code_detail (code,code_detail,code_detail_name) values('09','00','지원.보조금/연금'),('09','01','도움/서비스'),('09','02','장학제도'),('09','03','분양/임대'),('09','04','공모전'),('09','05','대출/금융');


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
  `banner_img` varchar(30) NOT NULL,
  `banner_link` varchar(100) NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE webdb.`tb_policy_scrap` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_idx` int(11) NOT NULL,
  `user_idx` int(11) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;