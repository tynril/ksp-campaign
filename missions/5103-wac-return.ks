RUNPATH("0:/lib/lib.ks").

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.0.

countdown_std().
PRINT "Liftoff!".
STAGE.

WAIT 1.5.
PRINT "Ejecting first booster stage...".
STAGE.

WAIT 1.5.
PRINT "Ejecting second booster stage...".
STAGE.

WAIT 0.75.
PRINT "Ignition of main engine...".
STAGE.

target_altitude(140000).

PRINT "Waiting for descent...".
WAIT UNTIL SHIP:verticalspeed < 0.

PRINT "Separing return module...".
STAGE.

PRINT "Arming parachute...".
chute_arm().

WAIT UNTIL SHIP:verticalspeed >= 0.
PRINT "All done!".
