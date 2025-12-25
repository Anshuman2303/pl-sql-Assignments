CREATE TABLE bank_customers(
    c_id NUMBER PRIMARY KEY, 
    c_name VARCHAR(100),
    phone NUMBER,
    created_at DATE DEFAULT SYSDATE

);
-- DROP TABLE bank_customers;
CREATE TABLE bank_accounts(
    acc_id NUMBER PRIMARY KEY,
    c_id NUMBER NOT NULL,
    acc_num NUMBER(12),
    balance NUMBER(12) CHECK (balance >=0),
    created_at DATE DEFAULT SYSDATE
);

CREATE TABLE bank_transactions(
    transaction_id NUMBER PRIMARY KEY,
    acc_id NUMBER,
    trans_type VARCHAR(10) CHECK(trans_type IN ('DEPOSIT','WITHDRAW')),
    amount NUMBER(12,2) CHECK(amount >0),
    rem_bal NUMBER(12,2),
    trans_date DATE DEFAULT SYSDATE 
);