DELIMITER $$
CREATE DEFINER=`bcsql`@`%` PROCEDURE `validate_session_token`(
IN _user_id char(12), IN _session_token varchar(128), OUT _statusCode INT)
BEGIN

	IF EXISTS (SELECT 1 FROM USER_SESSIONS WHERE 
		USER_ID = _user_id AND 
		SESSION_TOKEN = _session_token AND 
		DATE_ADD(CREATED_ON,INTERVAL 10 MINUTE) > NOW() AND 
		ACTIVE=1) THEN 
			SET _statusCode = 200;
	ELSE
			SET _statusCode = 1001;
	END IF;
END$$
DELIMITER ;

