RUN "0:/lib/lib".

WAIT UNTIL SHIP:UNPACKED.
CLEARSCREEN.

PRINT "###############################".
PRINT "#     LaeTyn Aerospace OS     #".
PRINT "###############################".
PRINT "".

// Attempt to find a mission script matching this vessel.
DECLARE LOCAL coreTag TO CORE:TAG.
IF EXISTS("./missions/" + coreTag + ".ks") {
    DECLARE LOCAL gui TO GUI(500).
    SET gui:y TO 100.

    DECLARE LOCAL label TO gui:ADDLABEL("Mission '" + coreTag + "' - Control").
    SET label:STYLE:ALIGN TO "CENTER".
    SET label:STYLE:HSTRETCH TO true.

    DECLARE LOCAL runButton TO gui:ADDBUTTON("Start Mission").
    DECLARE LOCAL hasStartedMission TO false.
    DECLARE LOCAL FUNCTION onStartMission {
        SET hasStartedMission TO true.
    }
    SET runButton:ONCLICK to onStartMission@.

    DECLARE LOCAL cancelButton TO gui:ADDBUTTON("Cancel").
    DECLARE LOCAL hasCancelled TO false.
    DECLARE LOCAL FUNCTION onCancel {
        SET hasCancelled TO true.
    }
    SET cancelButton:ONCLICK to onCancel@.

    gui:SHOW().
    WAIT UNTIL hasStartedMission OR hasCancelled.
    gui:HIDE().

    IF hasStartedMission {
        // Open the kOS terminal by default.
        IF CORE:HASACTION("open terminal") {
            CORE:DOACTION("open terminal", true).
        }

        PRINT "Mission '" + coreTag + "' started!".
        RUNPATH("./missions/" + coreTag + ".ks").
    }

    IF hasCancelled {
        PRINT "Mission cancelled.".
        PRINT "Manually resume by running:".
        PRINT "> RUNPATH('./missions/" + coreTag + ".ks')".
        PRINT "(Use double-quotes.)".
    }
}
ELSE {
    PRINT "Found no mission '" + coreTag + "'. Falling back to manual control.".
}
