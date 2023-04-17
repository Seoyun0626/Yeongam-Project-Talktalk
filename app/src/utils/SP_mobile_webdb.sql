
CREATE DEFINER=`webservice`@`%` PROCEDURE `SP_REGISTER_USER`(IN userid VARCHAR(255), IN userpw VARCHAR(255), IN salt VARCHAR(255), IN user_name VARCHAR(255), IN user_email VARCHAR(50), IN user_role VARCHAR(1), IN user_type VARCHAR(1), IN youthAge_code VARCHAR(1), IN parentsAge_code VARCHAR(1), IN sex_class_code VARCHAR(1), IN emd_class_code VARCHAR(1),  IN temp VARCHAR(50))
BEGIN
	
	INSERT INTO webdb.tb_user(userid, userpw, salt, user_name, user_email, user_role, user_type, youthAge_code, parentsAge_code, sex_class_code, emd_class_code, token_temp) VALUE (userid, userpw, salt, user_name, user_email, user_role, user_type, youthAge_code, parentsAge_code, sex_class_code, emd_class_code, temp);
END

CREATE DEFINER=`webservice`@`%` PROCEDURE `SP_GET_USER_BY_ID`(IN ID VARCHAR(255))
BEGIN
    SELECT u.userid, u.name, u.user_type, u.youthAge_code, u.parentsAge_code, u.sex_class_code, u.emd_class_code, u.user_email
    FROM webdb.tb_user u
    WHERE u.userid = ID AND u.user_role = 1;
END

