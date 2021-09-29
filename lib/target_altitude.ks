// #include "0:/lib/lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION target_altitude {
    DECLARE PARAMETER targetAlt.
    DECLARE PARAMETER vessel IS SHIP.

    PRINT "Waiting to reach target altitude of " + targetAlt + "...".
    WAIT UNTIL vessel:altitude >= targetAlt OR vessel:verticalspeed <= 0.
    IF vessel:altitude >= targetAlt {
        PRINT "Reached target altitude of " + targetAlt + "!".
    }
    ELSE {
        PRINT "Failed to reach target altitude of " + targetAlt + " (achieved " + vessel:altitude + ").".
    }
}
