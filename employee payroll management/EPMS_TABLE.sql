CREATE TABLE EMPLOYEES (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    dept_id NUMBER,
    basic_salary NUMBER,
    hra NUMBER,
    bonus NUMBER,
    hire_date DATE DEFAULT SYSDATE
    
);

CREATE TABLE EMP_DEPARTMENTS (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50)
);

CREATE TABLE EMP_SALARY (
    emp_id NUMBER,
    month_year VARCHAR2(10),
    gross_salary NUMBER,
    tax NUMBER,
    net_salary NUMBER,
    
);
  
CREATE TABLE salary_audit (
    emp_id NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    change_date DATE
);





