CREATE OR REPLACE PACKAGE pkg_num_base
IS
   FUNCTION to_base (p_dec IN NUMBER, p_base IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION to_dec (p_str IN VARCHAR2, p_from_base IN NUMBER DEFAULT 16)
      RETURN NUMBER;

   FUNCTION to_hex (p_dec IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION to_bin (p_dec IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION to_oct (p_dec IN NUMBER)
      RETURN VARCHAR2;
END;

CREATE OR REPLACE PACKAGE BODY pkg_num_base
IS
   FUNCTION to_base (p_dec IN NUMBER, p_base IN NUMBER)
      RETURN VARCHAR2
   IS
      v_str   VARCHAR2 (4096) DEFAULT NULL;
      v_num   NUMBER DEFAULT p_dec;
      v_hex   VARCHAR2 (16) DEFAULT '0123456789ABCDEF';
   BEGIN
      IF (p_dec IS NULL OR p_base IS NULL)
      THEN
         RETURN NULL;
      END IF;

      IF (TRUNC (p_dec) <> p_dec OR p_dec < 0)
      THEN
         RAISE PROGRAM_ERROR;
      END IF;

      LOOP
         v_str := SUBSTR (v_hex, MOD (v_num, p_base) + 1, 1) || v_str;
         v_num := TRUNC (v_num / p_base);
         EXIT WHEN (v_num = 0);
      END LOOP;

      RETURN v_str;
   END to_base;

   FUNCTION to_dec (p_str IN VARCHAR2, p_from_base IN NUMBER DEFAULT 16)
      RETURN NUMBER
   IS
      v_num   NUMBER DEFAULT 0;
      v_hex   VARCHAR2 (16) DEFAULT '0123456789ABCDEF';
   BEGIN
      IF (p_str IS NULL OR p_from_base IS NULL)
      THEN
         RETURN NULL;
      END IF;

      FOR i IN 1 .. LENGTH (p_str)
      LOOP
         v_num :=
              v_num * p_from_base
            + INSTR (v_hex, UPPER (SUBSTR (p_str, i, 1)))
            - 1;
      END LOOP;

      RETURN v_num;
   END to_dec;

   FUNCTION to_hex (p_dec IN NUMBER)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN to_base (p_dec, 16);
   END to_hex;

   FUNCTION to_bin (p_dec IN NUMBER)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN to_base (p_dec, 2);
   END to_bin;

   FUNCTION to_oct (p_dec IN NUMBER)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN to_base (p_dec, 8);
   END to_oct;
END;
/
