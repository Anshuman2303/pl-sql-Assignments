CREATE OR REPLACE PROCEDURE RANK_GENERATOR IS
    CURSOR C_RANK IS 
    SELECT STU_ID
    FROM OERPS_RESULTS
    ORDER BY PERCENT DESC;

    st_rank NUMBER :=1;

BEGIN
    FOR I IN C_RANK 
        LOOP
            UPDATE OERPS_RESULTS
            SET STU_RANK = st_rank
            WHERE STU_ID = I.STU_ID;

            st_rank := st_rank+1;
        
        END LOOP;
    
END;
/