set mysteer to heading(90, 90).
set thr to 0.6.
lock steering to mysteer.
lock throttle to thr.

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
        print("Aligning Retrograde...").
        set mysteer to ship:srfretrograde.
}

wait until ship:velocity:surface:mag > 100.

on ship:maxthrustat(0){
    print("STAGING").
    stage.
    return true.
}


wait until (ship:altitude > 10000).
set thr to 1.

until (SHIP:altitude > 70000 or ship:apoapsis >= 100000) {
    clearScreen.
    print(SHIP:altitude).
    print(ship:airspeed).
    print(ship:velocity:surface:mag).
    set shipspeed to ship:airspeed.
    //TODO Add altitude specifics
    wait until ship:altitude >= 15000.
    if(ship:velocity:surface:mag >= 300 and ship:velocity:surface:mag < 500){
        set mysteer to heading(90, 75).
    }
    if(ship:velocity:surface:mag >= 500 and ship:velocity:surface:mag < 700){
        set mysteer to heading(90, 45).
    }
    if(shipspeed >= 700){
        set mysteer to heading(90, 30).
    }
}

print("Waiting until Ap > 100,000").
wait until (ship:apoapsis > 100000).
print("Reached. Coasting...").
set thr to 0.
wait until (eta:apoapsis < 15).
set mysteer to ship:prograde.
set thr to 1.
wait until(ship:periapsis > 80000).
set thr to 0.
print("In orbit.").

until(ship:status = "LANDED"){
    clearScreen.
    print(SHIP:altitude).
    print(ship:verticalspeed).
}