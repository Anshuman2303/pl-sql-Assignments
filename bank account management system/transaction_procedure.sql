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


CREATE OR REPLACE PROCEDURE per_transactions(
    p_acc_id IN NUMBER,
    p_trans_type IN VARCHAR2,
    p_amount  IN NUMBER
) IS
    v_balance NUMBER;
BEGIN
    IF  p_trans_type = 'DEPOSIT' THEN
        UPDATE BANK_ACCOUNTS
        SET BALANCE = BALANCE + p_amount
        WHERE acc_id = p_acc_id;
    
    ELSIF p_trans_type = 'WITHDRAW' THEN 
        SELECT BALANCE INTO v_balance
        FROM BANK_ACCOUNTS
        WHERE acc_id = p_acc_id;

        IF v_balance < p_amount THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance');
        
        ELSE 
            UPDATE BANK_ACCOUNTS
            SET BALANCE = BALANCE - p_amount
            WHERE acc_id = p_acc_id;
        END IF;
    END IF;

    SELECT BALANCE INTO v_balance
    FROM BANK_ACCOUNTS
    WHERE acc_id = p_acc_id;
    
    
    COMMIT;
END;
/

