CREATE DATABASE webdb;

CREATE USER 'webservice'@'%' IDENTIFIED BY 'webservice';
GRANT ALL PRIVILEGES ON webdb.* TO 'webservice'@'%' WITH GRANT OPTION;
GRANT SUPER ON *.* TO 'webservice'@'%';
GRANT SELECT ON appdb.* TO 'webservice'@'%';

flush privileges;

DROP TABLE IF EXISTS webdb.`tb_user`;

CREATE TABLE webdb.`tb_user` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `userid` varchar(255) NOT NULL, -- **사용자 고유 식별 번호 컬럼 추가 쿼리 : alter table `tb_user` add `uid` varchar(100) NOT NULL after `board_idx` ;
  `reg_no` varchar(30) NULL,
  `userpw` varchar(255) NOT NULL, -- **password -> userpw 이름 변경 쿼리 : alter table `tb_user` change `password` `userpw` varchar(255) NOT NULL;
  `user_name` varchar(255) NOT NULL, -- **name -> user_name 이름 변경 쿼리 : alter table `tb_user` change `name` `user_name` varchar(255) NOT NULL;
  `user_role` varchar(1) NULL,
  `user_type` varchar(1) NOT NULL,
  `youthAge_code` varchar(1) NULL,
  `parentsAge_code` varchar(1) NULL,
  `sex_class_code` varchar(1) NULL,
  `emd_class_code` varchar(2) NULL,
  `user_email` varchar(50) NULL,
  `salt` varchar(255) NOT NULL,
  `fig` varchar(4) NOT NULL DEFAULT 0, 
  `token_temp` VARCHAR(100) NULL, -- **사용자 토큰 추가 커리 : alter table `tb_user` add `token_temp` varchar(100) NULL after `fig` ;
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 최고 관리자 id 설정
insert into tb_user (userid, password, name, user_role, salt) values ('admin', 'NNNq1ZZBr3kfAIhMCxsxAn7LWe73aPjZEblZHtFPn0DNysXK8qGUXBewTNhkFzeaaBmS0qi2sWws89Ra/iTNjaQrZjIzkRswFLOy5qhOGWa6CKujexk8L/Yv07wMTGRF2ZTK8301Z5QLqawDWjTgt5hyUtabSK0kmS06+s1VAHg=', 'admin', '0', 'yFfmKDozNt6TLMf+9tOni7zbrnqTOZqZWmF1i57q2rNMS5pMlxqAVdiJwPyVWBDKYT5G6wa4V389/tsSS/Ydeg==');
-- **PK 추가 :  uid
alter table `webdb`.`tb_user` add primary key `uid`;


CREATE TABLE webdb.`tb_policy` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL, -- 정책 고유 번호 컬럼 추가 쿼리 : alter table `tb_policy` add `uid` varchar(100) NOT NULL after `board_idx` ;
  `policy_name` varchar(50) NOT NULL,
  `policy_target_code` varchar(2) NOT NULL,
  `policy_institution_code` varchar(2) NOT NULL,
  `description` longtext NULL,
  `policy_field_code` varchar(2) NOT NULL,
  `policy_character_code` varchar(2) NOT NULL,
  `del_chk` varchar(1) NOT NULL DEFAULT 'N',
  `policy_link` varchar(100) NULL,
  `application_start_date` timestamp NULL,
  `application_end_date` timestamp NULL,
  `count_scraps` int(4) NOT NULL DEFAULT 0,
  -- **is_scrap 컬럼 삭제 : alter table tb_policy drop is_scrap;
  `count_views` int(4) NOT NULL DEFAULT 0, 
  `min_fund` int(10) NOT NULL,
  `max_fund` int(10) NOT NULL,
  `content` varchar(1000) NULL,
  `img` varchar(30) NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- **PK 추가 : uid
alter table `webdb`.`tb_policy` add primary key `uid`;



-- 공통 코드 설계
create table webdb.`tb_common_code`(
  `code` varchar(2) NOT NULL,
  `code_name` varchar(30) NOT NULL,
  `code_english_name` varchar(30) NULL,
  `code_desc` varchar(100) NULL,
  `code_use_yn` varchar(1) NOT NULL DEFAULT 'Y',
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
  `code_detail_use_yn` varchar(1) NOT NULL DEFAULT 'Y',
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
  `terms` text NOT NULL,
  `privacy` text NOT NULL,
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

-- **기존 tb_policy_scrap drop
-- 쿼리 : drop table tb_policy_scrap;
/* 
CREATE TABLE webdb.`tb_policy_scrap` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `policy_idx` int(11) NOT NULL,
  `user_idx` int(11) NOT NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/


-- ** 스크랩 (new)
-- ** add index (tb_policy와 tb_user의 uid 컬럼을 Foregin key로 가져오기 위해)
ALTER TABLE `webdb.tb_user` ADD INDEX (`uid`);
ALTER TABLE `webdb.tb_policy` ADD INDEX (`uid`);

-- ** 그 다음 새로 create하기
CREATE TABLE webdb.`tb_policy_scrap`
(
	`uid_scraps` VARCHAR(100) PRIMARY KEY,
	`user_uid` VARCHAR(100) NOT NULL,
	`policy_uid` VARCHAR(100) NOT NULL,
  `is_scrapped` BOOL NOT NULL DEFAULT 0,
	`ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY(user_uid) REFERENCES webdb.`tb_user`(`uid`),
	FOREIGN KEY(policy_uid) REFERENCES webdb.`tb_policy`(`uid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
