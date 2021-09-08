// #include "./lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION chute_find {
    DECLARE PARAMETER tag IS "chute".
    DECLARE PARAMETER vessel IS SHIP.

    DECLARE LOCAL chutePart TO find_part_one(tag, vessel).
    IF NOT chutePart:GETMODULEBYINDEX(0):HASEVENT("arm parachute") {
        PRINT "Parachute with tag '" + tag + "' on vessel '" + vessel:name + "', has no 'Arm Parachute' event.".
        RETURN false.
    }

    RETURN chutePart.
}

DECLARE GLOBAL FUNCTION chute_arm {
    DECLARE PARAMETER tag IS "chute".
    DECLARE PARAMETER vessel IS SHIP.

    DECLARE LOCAL chutePart TO chute_find(tag, vessel).
    chutePart:GETMODULEBYINDEX(0):DOEVENT("arm parachute").
}
