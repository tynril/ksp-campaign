RUNPATH("0:/lib/lib.ks").

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.0.

countdown_std().
PRINT "Liftoff!".
STAGE.

WAIT 1.85.
PRINT "Ejecting first booster stage...".
STAGE.

WAIT 1.85.
PRINT "Ejecting second booster stage...".
STAGE.

WAIT UNTIL STAGE:ready.
PRINT "Ignition of main engine...".
STAGE.

WAIT 2.
SET KUNIVERSE:TIMEWARP:MODE TO "PHYSICS".
SET KUNIVERSE:TIMEWARP:WARP TO 3.

target_altitude(100000).

PRINT "Waiting for descent...".
WAIT UNTIL SHIP:verticalspeed < 0.

PRINT "Separing return module...".
STAGE.

PRINT "Arming parachute...".
chute_arm().

WAIT UNTIL ALT:RADAR <= 100.
SET KUNIVERSE:TIMEWARP:WARP TO 0.

WAIT UNTIL SHIP:verticalspeed >= 0.
PRINT "All done!".
