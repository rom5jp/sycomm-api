-- USE sycomm_development;
-- DROP PROCEDURE IF EXISTS update_users_roles;

DELIMITER $$

CREATE PROCEDURE update_users_roles()
BEGIN
  DECLARE done TINYINT DEFAULT FALSE;
  DECLARE v_registration VARCHAR(255);
  DECLARE v_role_id BIGINT(20);
  DECLARE c_roles CURSOR FOR 
    SELECT us.registration, r.id as role_id
    FROM user_seeds us 
    JOIN users u
    JOIN roles r
    WHERE us.role = r.name
    AND us.name = u.name;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN c_roles;

  read_loop: LOOP
    FETCH c_roles INTO v_registration, v_role_id;
    SELECT v_role_id;
    
    UPDATE users
		SET role_id = v_role_id
    WHERE registration LIKE v_registration;

    IF done THEN
      LEAVE read_loop;
    END IF;
  END LOOP;

  CLOSE c_roles;
END$$

DELIMITER ;