// #include "0:/lib/lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION chute_find {
    DECLARE PARAMETER tag IS "chute".
    DECLARE PARAMETER vessel IS SHIP.

    DECLARE LOCAL chutePart TO find_part_one(tag, vessel).
    DECLARE LOCAL chuteMod TO chutePart:GETMODULE("RealChuteModule").
    IF NOT chuteMod:HASACTION("arm parachute") {
        PRINT "Parachute with tag '" + tag + "' on vessel '" + vessel:name + "', has no 'Arm parachute' action.".
        RETURN false.
    }

    RETURN chuteMod.
}

DECLARE GLOBAL FUNCTION chute_arm {
    DECLARE PARAMETER tag IS "chute".
    DECLARE PARAMETER vessel IS SHIP.

    DECLARE LOCAL chuteMod TO chute_find(tag, vessel).
    chuteMod:DOACTION("arm parachute", true).
}
