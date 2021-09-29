RUNPATH("0:/lib/lib.ks").

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.0.

countdown_std().
PRINT "Liftoff!".
STAGE.

WAIT 1.5.
PRINT "Ejecting first booster stage...".
STAGE.

WAIT 1.5.
PRINT "Ejecting second booster stage, and main thruster ignition...".
STAGE.

target_altitude(140000).

WAIT UNTIL ALT:RADAR <= 100.
range_safety().
