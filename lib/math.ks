// #include "0:/lib/lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION pow {
    DECLARE PARAMETER num.
    DECLARE PARAMETER power.

    DECLARE LOCAL result IS num.
    FROM {
        DECLARE LOCAL i IS 1.
    }
    UNTIL i = power STEP {
        SET i TO i + 1.
    } DO {
        SET result TO result * num.
    }

    RETURN result.
}
