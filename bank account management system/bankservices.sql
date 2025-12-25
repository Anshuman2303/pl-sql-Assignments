-- for adding customer and creating a bank account
BEGIN
    ADD_CUSTOMER('&name', &NUM);
END;
/
SELECT * FROM BANK_CUSTOMERS;
SELECT * FROM BANK_ACCOUNTS;

-- for doing transactions
BEGIN
    PER_TRANSACTIONS(&acc, '&Ttype',&amt );
END;
/

SELECT * FROM BANK_TRANSACTIONS;

-- FOR GETTING BALANCE
DECLARE
   v_bal NUMBER;
BEGIN
   v_bal := getbalance(&b_acc);
   DBMS_OUTPUT.PUT_LINE('Balance = ' || v_bal);
END;
/

UPDATE BANK_ACCOUNTS
SET BALANCE = 1000
WHERE ACC_ID = 141; 
