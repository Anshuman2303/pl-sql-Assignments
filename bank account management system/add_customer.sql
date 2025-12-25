-- CREATE OR REPLACE PROCEDURE add_customer(
--     p_name IN VARCHAR,
--     p_phone IN NUMBER
    
-- ) IS 
-- BEGIN
--     INSERT INTO BANK_CUSTOMERS(C_ID, C_NAME, PHONE)
--     VALUES(CUSTOMER_SEQ.NEXTVAL,p_name, p_phone);
--     COMMIT;
-- END;
-- /

BEGIN
    ADD_CUSTOMER('&NAME', &NUM);
END;
/

-- SELECT * FROM BANK_CUSTOMERS;
-- SELECT * FROM BANK_ACCOUNTS;