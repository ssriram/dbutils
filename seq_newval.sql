 
CREATE OR REPLACE PROCEDURE SEQ_NEWVAL (p_seq_name VARCHAR2, p_new_val NUMBER)
AS
   v_last_num   NUMBER;
   v_inc_val   NUMBER;
BEGIN
   SELECT last_number, increment_by
     INTO v_last_num, v_inc_val
     FROM user_sequences
    WHERE sequence_name = UPPER (p_seq_name);

   EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || p_seq_name || ' INCREMENT BY ' || (p_new_val - v_last_num);

   EXECUTE IMMEDIATE 'SELECT ' || p_seq_name || '.NEXTVAL FROM DUAL' INTO v_last_num;

   EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || p_seq_name || ' INCREMENT BY ' || v_inc_val;
END;