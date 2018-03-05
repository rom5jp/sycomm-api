DO $$DECLARE 
  v_registration VARCHAR(255);
  v_organization_id INTEGER;
  c_organizations CURSOR FOR 
    SELECT us.registration, r.id as organization_id
    FROM user_seeds us 
    INNER JOIN users u
      ON us.registration = u.registration
    INNER JOIN organizations r
      ON us.organization = r.name
    WHERE u.type = 'Customer';
BEGIN
  OPEN c_organizations;

  LOOP
    FETCH c_organizations INTO v_registration, v_organization_id;
    EXIT WHEN NOT FOUND;

    -- raise notice 'v_reg: %', v_registratoin;
    -- raise notice 'v_organization_id: %', v_organization_id;
    -- raise notice '---';
    
    UPDATE users
    SET organization_id = v_organization_id
    WHERE registration LIKE v_registration;
  END LOOP;

  CLOSE c_organizations;
END$$;