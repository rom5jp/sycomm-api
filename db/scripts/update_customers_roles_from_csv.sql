DO $$DECLARE
  v_registration VARCHAR(255);
  v_public_office_id INTEGER;
  c_public_offices CURSOR FOR
    SELECT us.registration, r.id as public_office_id
    FROM user_seeds us 
    INNER JOIN users u
      ON us.registration = u.registration
    INNER JOIN public_offices r
      ON us.public_office = r.name
    WHERE u.type = 'Customer';
BEGIN
  OPEN c_public_offices;

  LOOP
    FETCH c_public_offices INTO v_registration, v_public_office_id;
    EXIT WHEN NOT FOUND;

    -- raise notice 'v_reg: %', v_registratoin;
    -- raise notice 'v_public_office_id: %', v_public_office_id;
    -- raise notice '---';
    
    UPDATE users
    SET public_office_id = v_public_office_id
    WHERE registration LIKE v_registration;
  END LOOP;

  CLOSE c_public_offices;
END$$;