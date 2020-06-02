//TODO Make more verbose
set mysteer to heading(90, 90).
set thr to 0.6.
lock steering to mysteer.
lock throttle to thr.
set done to false.

stage.
WAIT 1.

//Handler for parachute event
when (SHIP:altitude < 10000 and SHIP:verticalspeed < 0 and SHIP:verticalspeed*(-1) < 300) THEN{
        print("Deploying Chute...").
        until (stage:number = 0){
            stage.
        }
        unlock steering.
}
when (SHIP:altitude < 60000 and SHIP:verticalspeed < 0) THEN{
        print("Reentry detected. Staging...").
        until (stage:number = 1){
            stage.
        }
        print("Aligning Retrograde...").
        set mysteer to ship:srfretrograde.
}

wait until ship:velocity:surface:mag > 100.

on ship:maxthrustat(0){
    print("STAGING").
    stage.
    return true.
}

until (SHIP:altitude > 70000 or ship:apoapsis >= 100000) {
    clearScreen.
    print(SHIP:altitude).
    print(ship:airspeed).
    print(ship:velocity:surface:mag).
    set shipspeed to ship:airspeed.
    //TODO Add altitude specifics
    //TODO Make throttle gentler so that aP is correct
    wait until ship:altitude >= 15000.
    if(ship:velocity:surface:mag >= 300 and ship:velocity:surface:mag < 500){
        set mysteer to heading(90, 75).
    }
    if(ship:velocity:surface:mag >= 500 and ship:velocity:surface:mag < 700){
        set mysteer to heading(90, 45).
    }
    if(shipspeed >= 700){
        set mysteer to heading(90, 25).
    }
}

set thr to 0.

function visviva{
    parameter targetBody, vesselAlt, aP, pE.
    set vel to SQRT(targetBody:mu*(2/(vesselAlt+targetBody:radius)-1/((aP+Pe+2*targetBody:radius)/2))).
    return vel.
}

function rocketEq{
    parameter dV.
    parameter engine.
    set massRemaining to (ship:mass*constant:e^(dV/engine:ispAt(0))).

    set burnTime to (massRemaining/((engine:maxThrustAt(0)*1000)/engine:ispAt(0))).
    return burnTime.
}



wait until ship:altitude > 70000.

set dV to (visviva(kerbin, ship:apoapsis, ship:apoapsis, ship:apoapsis)-visviva(kerbin, ship:apoapsis, ship:apoapsis, ship:periapsis)).

set circularisation to node(time:seconds+eta:apoapsis, 0, 0, dV).
add circularisation.

lock mysteer to circularisation:deltav.
set burnTime to 0.

list engines in myEngines.

for eng in myEngines{
    if(eng:maxThrust > 0){
        set burnTime to rocketEq(dV, eng).
    }
}
//TODO Fix burn only starting at T-0s
print("ETA TO BURN").
print(circularisation:eta-(burnTime/2)).
print(circularisation:eta).
print(burnTime/2).
wait until (circularisation:eta <= (burntime/2)).
set thr to 1.

//TODO Make throttle control more exact
//TODO Make engine shutoff after node is finished. When nd initial is opposite to nd final?
until done{
    if(circularisation:deltav:mag <= 0.1){
        set thr to 0.
        set done to true.
    }
    wait 0.1.
}