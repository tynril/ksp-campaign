RUN "0:/lib/lib".

LOCK THROTTLE TO 1.0.
LOCK STEERING TO UP.

countdown_std().

WAIT 1.5.
PRINT "Ejecting first booster stage...".
STAGE.

WAIT 1.5.
PRINT "Ejecting second booster stage...".
STAGE.

target_altitude(100000).

PRINT "Waiting for descent...".
WAIT UNTIL SHIP:verticalspeed < 0.

PRINT "Arming parachute...".
chute_arm().

WAIT UNTIL SHIP:verticalspeed >= 0.
PRINT "All done!".
