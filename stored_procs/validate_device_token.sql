DELIMITER $$
CREATE DEFINER=`bcsql`@`%` PROCEDURE `validate_device_token`(
IN _user_id char(12), IN _device_token varchar(128), OUT _statusCode INT)
BEGIN

	IF EXISTS (SELECT DEVICE_ID FROM USER_DEVICES WHERE 
		USER_ID = _user_id AND 
		DEVICE_TOKEN = _device_token AND 
		STATUS_BIT & b'111' = b'101'
		) THEN 
			SET _statusCode = 200;
	ELSE
			SET _statusCode = 1002;
	END IF;
END$$
DELIMITER ;
