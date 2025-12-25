-- FUNCTION FOR CALCULATING TAX
-- CREATE OR REPLACE FUNCTION CALCULATE_TAX(E_SALARY NUMBER)
-- RETURN NUMBER IS
--     s_tax NUMBER;

-- BEGIN
--     IF E_SALARY <= 30000 THEN 
--         s_tax := E_SALARY*0.05;
--     ELSIF E_SALARY <= 60000 THEN
--         s_tax := E_SALARY*0.10;
--     ELSE 
--         s_tax := E_SALARY*0.20;IOJK
--     END IF;

--     RETURN s_tax;
-- END;
-- /
CREATE OR REPLACE PACKAGE payroll_pkg AS
    PROCEDURE cal_salary(p_emp_id NUMBER, p_month VARCHAR2);
    PROCEDURE SALARY_REPORT_DEPT(p_dept_id NUMBER);
END payroll_pkg;
/

CREATE OR REPLACE PACKAGE BODY payroll_pkg AS
    PROCEDURE cal_salary(p_emp_id NUMBER, p_month VARCHAR2) IS
        v_basic EMPLOYEES.BASIC_SALARY%TYPE;
        v_hra EMPLOYEES.HRA%TYPE;
        v_bonus EMPLOYEES.BONUS%TYPE;
        v_tax NUMBER;
        v_net NUMBER;
        v_prob NUMBER;
    BEGIN
        SELECT basic_salary, hra, bonus
        INTO v_basic, v_hra, v_bonus
        FROM EMPLOYEES
        WHERE EMP_ID = p_emp_id;


        v_prob := v_basic+v_hra+v_bonus;
        v_tax := CALCULATE_TAX(v_prob);
        v_net := v_prob - v_tax;
        
        INSERT INTO EMP_SALARY(EMP_ID,MONTH_YEAR, GROSS_SALARY,TAX, NET_SALARY)
        VALUES(p_emp_id, p_month, v_prob, v_tax, v_net);

    END cal_salary;
    
    PROCEDURE SALARY_REPORT_DEPT(P_DEPT_ID NUMBER) IS
        CURSOR C_SALARY IS
            SELECT E.EMP_NAME, S.NET_SALARY
            FROM EMPLOYEES E
            JOIN EMP_SALARY S ON E.EMP_ID = S.EMP_ID
            WHERE E.DEPT_ID = P_DEPT_ID;

        V_NAME EMPLOYEES.EMP_NAME%TYPE;
        V_SALARY EMP_SALARY.NET_SALARY%TYPE;
    
    BEGIN 
        OPEN C_SALARY;
        LOOP 
            FETCH C_SALARY INTO V_NAME, V_SALARY;
            EXIT WHEN C_SALARY%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE(V_NAME ||' '||V_SALARY);
        END LOOP;
        CLOSE C_SALARY;
    END SALARY_REPORT_DEPT;
END payroll_pkg;
/

CREATE OR REPLACE TRIGGER SAL_AUDIT
BEFORE UPDATE OF basic_salary ON EMPLOYEES
FOR EACH ROW 
BEGIN 
    INSERT INTO SALARY_AUDIT(EMP_ID, OLD_SALARY,NEW_SALARY,CHANGE_DATE)
    VALUES(:OLD.EMP_ID, :OLD.basic_salary, :NEW.basic_salary, SYSDATE);

END;
/
