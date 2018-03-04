USE sycomm_development;
DROP PROCEDURE IF EXISTS update_users_organizations;

DELIMITER $$

CREATE PROCEDURE update_users_organizations()
BEGIN
  DECLARE done TINYINT DEFAULT FALSE;
  DECLARE v_registration VARCHAR(255);
  DECLARE v_org_id BIGINT(20);
  DECLARE c_orgs CURSOR FOR 
    SELECT us.registration, o.id as org_id
    FROM user_seeds us 
    INNER JOIN users u
      ON us.name = u.name
    INNER JOIN organizations o
      ON us.organization = o.name
    WHERE u.type = 'Customer' limit 1000;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN c_orgs;

  read_loop: LOOP
    FETCH c_orgs INTO v_registration, v_org_id;
    
    UPDATE users
    SET organization_id = v_org_id
    WHERE registration LIKE v_registration;

    IF done THEN
      LEAVE read_loop;
    END IF;
  END LOOP;

  CLOSE c_orgs;
END$$

DELIMITER ;