RUNPATH("0:/lib/lib.ks").

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.0.
LOCK STEERING TO HEADING(-90, 90, 90).

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
    DECLARE LOCAL startPitch TO 85.
    DECLARE LOCAL targetPitchAltitude TO 100000.
    // Mission 1: 77.5deg (target: 100km alt / 200km downrange).
    // Mission 2: 55deg   (target: 150km alt / 400km downrange).
    // Mission 3: 30deg   (target: 200km alt / 600km downrange).
    DECLARE LOCAL targetPitch TO 30.
    DECLARE LOCAL pitch TO MAX(targetPitch, startPitch - ((SHIP:altitude / targetPitchAltitude) * (startPitch - targetPitch))).
    RETURN pitch.
}
LOCK STEERING TO HEADING (-90, getPitch(), 90).

PRINT "Waiting for end of burn...".
DECLARE LOCAL firstStageEngine TO getActiveEngine().
WAIT UNTIL firstStageEngine:thrust <= 0.

WAIT 5.

PRINT "Separing return module...".
STAGE.

// Mission 1: 100km
// Mission 2: 150km
// Mission 3: 200km
target_altitude(200000).

PRINT "Waiting for descent...".
WAIT UNTIL SHIP:verticalspeed < 0.

PRINT "Arming parachute...".
chute_arm().

WAIT UNTIL SHIP:verticalspeed >= 0.
PRINT "All done!".
