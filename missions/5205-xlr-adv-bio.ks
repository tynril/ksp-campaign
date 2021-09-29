RUNPATH("0:/lib/lib.ks").

// Mission 1: 2000m/s
// Mission 2: 3000m/s
// Mission 3: 4000m/s
DECLARE LOCAL targetOrbitalVelocity TO 4000.
DECLARE LOCAL targetVelocityMargin TO 100.

// Useful for downrange sounding payload re-use.
DECLARE LOCAL dropSoundingPayloadEarly TO false.

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90, -90).

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

DECLARE LOCAL FUNCTION getRemainingFuelPct {
    DECLARE PARAMETER engine.

    DECLARE LOCAL fuels TO engine:consumedResources:values.
    DECLARE LOCAL result TO 1.
    FOR fuel IN fuels {
        DECLARE LOCAL remainingRatio TO fuel:amount / fuel:capacity.
        IF remainingRatio < result {
            SET result TO remainingRatio.
        }
    }

    RETURN result.
}

DECLARE LOCAL firstStageEngine TO getActiveEngine().
DECLARE LOCAL startFuel TO getRemainingFuelPct(firstStageEngine).

DECLARE LOCAL FUNCTION getPitch {
    DECLARE LOCAL startPitch TO 75.
    DECLARE LOCAL targetPitch TO 35.
    DECLARE LOCAL fuelSave TO 0.2.

    DECLARE LOCAL fuelFraction TO MAX(0, (getRemainingFuelPct(firstStageEngine) - fuelSave) / (startFuel - fuelSave)).
    DECLARE LOCAL currentPitchFraction TO pow(1 - fuelFraction, 3).
    DECLARE LOCAL pitch TO startPitch - ((startPitch - targetPitch) * currentPitchFraction).

    //PRINT "Fuel = " + ROUND(fuelFraction, 2) + " / Pitch f = " + ROUND(currentPitchFraction, 2) + " / Pitch = " + ROUND(pitch, 2).

    RETURN pitch.
}
LOCK STEERING TO HEADING (90, getPitch(), -90).

PRINT "Waiting for end of burn...".
WAIT UNTIL firstStageEngine:thrust <= 0.

PRINT "Second stage separation...".
UNLOCK STEERING.
STAGE.

WAIT UNTIL STAGE:ready.
PRINT "Spin motors...".
STAGE.

WAIT UNTIL STAGE:ready.
PRINT "Second stage ignition...".
STAGE.

WAIT 1.
PRINT "Waiting for end of burn...".
DECLARE LOCAL secondStageEngine TO getActiveEngine().
WAIT UNTIL secondStageEngine:thrust <= 0 OR ((SHIP:VELOCITY:ORBIT:MAG > targetOrbitalVelocity + targetVelocityMargin) AND (SHIP:apoapsis >= 150000)).

DECLARE LOCAL hasAchievedTargetVelocity TO false.
IF secondStageEngine:thrust > 0 {
    PRINT "Target velocity of " + targetOrbitalVelocity + "m/s achieved (with margin), ending burn.".
    SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
    SET hasAchievedTargetVelocity TO true.
    WAIT 1.
}
ELSE {
    PRINT "Target velocity of " + targetOrbitalVelocity + "m/s not yet achieved with margin...".
}

IF SHIP:altitude < 140000 {
    PRINT "Waiting for target altitude...".
    WAIT UNTIL SHIP:altitude >= 140000.
}

if dropSoundingPayloadEarly {
    PRINT "Detaching lower payload...".
    WAIT UNTIL STAGE:ready.
    STAGE.
}

IF NOT hasAchievedTargetVelocity {
    WHEN SHIP:VELOCITY:ORBIT:MAG >= targetOrbitalVelocity THEN {
        PRINT "Target velocity of " + targetOrbitalVelocity + "m/s achieved on the way down!".
    }
}

PRINT "Waiting for descent...".
WAIT UNTIL SHIP:verticalspeed < 0.

PRINT "Waiting for atmospheric proximity (150km)...".
WAIT UNTIL SHIP:altitude <= 150000.

if NOT dropSoundingPayloadEarly {
    PRINT "Detaching lower payload...".
    WAIT UNTIL STAGE:ready.
    STAGE.
}

PRINT "Detaching upper payload...".
WAIT UNTIL STAGE:ready.
STAGE.

PRINT "Arming parachute...".
chute_arm("chute")..

WAIT UNTIL SHIP:verticalspeed >= 0.
PRINT "Recovery complete!".
