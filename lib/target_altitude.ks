// #include "./lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION target_altitude {
    DECLARE PARAMETER targetAlt.
    DECLARE PARAMETER vessel IS SHIP.
    DECLARE PARAMETER range_safety IS true.

    PRINT "Waiting to reach target altitude of " + targetAlt + "...".
    WAIT UNTIL vessel:altitude >= targetAlt OR vessel:verticalspeed <= 0.
    IF vessel:altitude >= targetAlt {
        PRINT "Reached target altitude of " + targetAlt + "!".
    }
    ELSE {
        PRINT "Failed to reach target altitude of " + targetAlt + " (achieved " + vessel:altitude + ").".

        IF range_safety {
            IF find_part_module_try_action("ModuleRangeSafety", "range safety") {
                PRINT "Mission aborted; range safety triggered.".
                SHUTDOWN.
            }
            ELSE {
                PRINT "Unable to abort mission - no range safety device found.".
            }
        }
    }
}
