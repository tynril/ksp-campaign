// #include "./lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION find_part_one {
    DECLARE PARAMETER tag.
    DECLARE PARAMETER vessel IS SHIP.

    DECLARE LOCAL foundParts TO vessel:PARTSDUBBED(tag).
    IF foundParts:LENGTH = 0 {
        PRINT "Found no part with tag '" + tag + "' on vessel '" + vessel:name + "'.".
        RETURN.
    }.

    IF foundParts:LENGTH > 1 {
        PRINT "Found " + foundParts:LENGTH + " parts with tag '" + tag + "' on vessel '" + vessel:name + "', expected just one.".
        RETURN.
    }

    RETURN foundParts[0].
}

DECLARE GLOBAL FUNCTION find_part_module_try_action {
    DECLARE PARAMETER moduleName.
    DECLARE PARAMETER actionName.
    DECLARE PARAMETER actionParameter IS true.
    DECLARE PARAMETER vessel IS SHIP.
    DECLARE PARAMETER warnMissing IS false.

    DECLARE LOCAL allParts TO vessel:parts.
    FOR part IN allParts {
        IF part:HASMODULE(moduleName) {
            DECLARE LOCAL foundModule TO part:GETMODULE(moduleName).
            IF foundModule:HASACTION(actionName) {
                foundModule:DOACTION(actionName, actionParameter).
                RETURN true.
            }
        }
    }

    IF warnMissing {
        PRINT "Unable to find a part module with action '" + actionName + "'.".
    }

    RETURN false.
}
