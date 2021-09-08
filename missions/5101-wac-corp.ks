RUN "0:/lib/lib".

LOCK THROTTLE TO 1.0.
LOCK STEERING TO UP.

countdown_std().

WAIT 1.5.
PRINT "Ejecting booster.".
STAGE.

target_altitude(100000).

PRINT "Flight plan completed.".
