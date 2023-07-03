CREATE TABLE webdb.`tb_feedback` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `feedback_name` varchar(30) NULL,
  `tester` varchar(30) NULL,
  `feedback_content` varchar(100) NULL,
  `ins_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upd_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_idx`) USING BTREE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
