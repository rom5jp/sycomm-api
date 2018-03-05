DO $$DECLARE
  v_registration VARCHAR(255);
  v_role_id INTEGER;
  c_roles CURSOR FOR 
    SELECT us.registration, r.id as role_id
    FROM user_seeds us 
    INNER JOIN users u
      ON us.registration = u.registration
    INNER JOIN roles r
      ON us.role = r.name
    WHERE u.type = 'Customer';
BEGIN
  OPEN c_roles;

  LOOP
    FETCH c_roles INTO v_registration, v_role_id;
    EXIT WHEN NOT FOUND;

    -- raise notice 'v_reg: %', v_registratoin;
    -- raise notice 'v_role_id: %', v_role_id;
    -- raise notice '---';
    
    UPDATE users
    SET role_id = v_role_id
    WHERE registration LIKE v_registration;
  END LOOP;

  CLOSE c_roles;
END$$;