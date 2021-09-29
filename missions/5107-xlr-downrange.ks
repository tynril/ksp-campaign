RUNPATH("0:/lib/lib.ks").

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90, -90).

DECLARE LOCAL rangePosition TO SHIP:geoposition.
PRINT "Starting downrange distance: " + rangePosition:distance.

countdown_std().
PRINT "Main engine ignition.".
STAGE.

WAIT 2.5.
PRINT "Liftoff!".
STAGE.

WAIT UNTIL SHIP:verticalspeed >= 60.
PRINT "Starting gravity turn...".

DECLARE LOCAL FUNCTION getActiveEngine {
    DECLARE LOCAL activeEngine TO 0.
    LIST ENGINES IN allEngines.
    FOR engine IN allEngines {
        IF engine:thrust > 0 {
            SET activeEngine TO engine.
            BREAK.
        }
    }
    RETURN activeEngine.
}

DECLARE LOCAL FUNCTION getPitch {
    DECLARE LOCAL startPitch TO 72.
    DECLARE LOCAL targetPitch TO 42.5.
    DECLARE LOCAL targetPitchAltitude TO 55000.
    DECLARE LOCAL pitch TO MAX(targetPitch, startPitch - ((SHIP:altitude / targetPitchAltitude) * (startPitch - targetPitch))).
    RETURN pitch.
}
LOCK STEERING TO HEADING (90, getPitch(), -90).

DECLARE LOCAL firstStageEngine TO getActiveEngine().
WAIT UNTIL ALT:RADAR >= 55000 AND firstStageEngine:thrust <= 0.
PRINT "Second stage separation...".
UNLOCK STEERING.
STAGE.

WAIT UNTIL STAGE:ready.
PRINT "Spin motors...".
STAGE.

WAIT UNTIL STAGE:ready.
PRINT "Second stage ignition...".
STAGE.

WAIT 1.0.
DECLARE LOCAL secondStageEngine TO getActiveEngine().
WAIT UNTIL secondStageEngine:thrust <= 0.
WAIT 1.0.

PRINT "Warping...".
SET KUNIVERSE:TIMEWARP:MODE TO "RAILS".
SET KUNIVERSE:TIMEWARP:WARP TO 1.

WAIT UNTIL rangePosition:distance >= 3000000.
PRINT "Downrange distance achieved!".

WAIT UNTIL SHIP:altitude <= 150000.
PRINT "Approaching atmosphere, stopping warp.".
SET KUNIVERSE:TIMEWARP:WARP TO 0.
