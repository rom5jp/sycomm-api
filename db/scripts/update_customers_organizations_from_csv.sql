DO $$DECLARE 
  v_registration VARCHAR(255);
  v_public_agency_id INTEGER;
  c_public_agencies CURSOR FOR
    SELECT us.registration, r.id as public_agency_id
    FROM user_seeds us 
    INNER JOIN users u
      ON us.registration = u.registration
    INNER JOIN public_agencies r
      ON us.public_agency = r.name
    WHERE u.type = 'Customer';
BEGIN
  OPEN c_public_agencies;

  LOOP
    FETCH c_public_agencies INTO v_registration, v_public_agency_id;
    EXIT WHEN NOT FOUND;

    -- raise notice 'v_reg: %', v_registratoin;
    -- raise notice 'v_public_agency_id: %', v_public_agency_id;
    -- raise notice '---';
    
    UPDATE users
    SET public_agency_id = v_public_agency_id
    WHERE registration LIKE v_registration;
  END LOOP;

  CLOSE c_public_agencies;
END$$;