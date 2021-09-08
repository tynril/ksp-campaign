// #include "./lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION countdown_std {
    DECLARE PARAMETER duration IS 5.
    DECLARE PARAMETER stageWhenDone IS true.

    PRINT "Initialization sequence started; T minus " + duration + " seconds...".
    FROM {
        LOCAL countdown IS duration.
    } UNTIL countdown = 0 STEP {
        SET countdown TO countdown - 1.
    } DO {
        PRINT "... " + countdown.
        WAIT 1.
    }

    IF stageWhenDone {
        PRINT "Liftoff!".
        STAGE.
    }
}
