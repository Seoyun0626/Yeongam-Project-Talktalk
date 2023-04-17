USE webdb;


-- userid, password, name, salt, user_role, user_email, user_type,
-- youthAge_code, parentsAge_code, emd_class_code, sex_class_code) values
-- ('"+req.body.userid+"','"+hash+"','"+req.body.name+"', '"+salt+"',
-- '"+req.body.user_role+"', '"+req.body.user_email+"', '"+req.body.user_type+"',
-- '"+req.body.youthAge_code+"','"+req.body.parentsAge_code+"', '"+req.body.emd_class_code+"', 
-- '"+req.body.sex_class_code+"')";


DELIMITER //
CREATE PROCEDURE SP_REGISTER_USER(IN userid VARCHAR(255), IN userpw VARCHAR(255), IN user_name VARCHAR(255), IN user_email VARCHAR(50), IN user_type VARCHAR(1), IN youthAge_code VARCHAR(1), IN parentsAge_code VARCHAR(1), IN sex_class_code VARCHAR(1), IN emd_class_code VARCHAR(1),  IN temp VARCHAR(50))
BEGIN
	
	INSERT INTO webdb.tb_user(userid, userpw, user_name, user_email, user_role, user_type, youthAge_code, parentsAge_code, sex_class_code, emd_class_code, token_temp) VALUE (userid, userpw, user_name, user_email, user_type, youthAge_code, parentsAge_code, sex_class_code, emd_class_code, temp);
END//


CREATE PROCEDURE SP_GET_USER_BY_ID(IN ID VARCHAR(255))
BEGIN
    SELECT u.userid, u.name, u.user_type, u.youthAge_code, u.parentsAge_code, u.sex_class_code, u.emd_class_code, u.user_email
    FROM tb_user u
    WHERE u.userid = ID AND u.user_role = 1;
END