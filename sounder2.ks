set mysteer to heading(90, 90).
set thr to 100.
lock steering to mysteer.
lock throttle to thr.
stage.

when (SHIP:altitude < 10000 and SHIP:verticalspeed < 0 and SHIP:verticalspeed*(-1) < 300) THEN{
        print("Deploying Chute...").
        stage.
        unlock steering.
}

WAIT 0.5.

until (SHIP:status = "LANDED") {
    clearScreen.
    print(SHIP:altitude).
    print(ship:verticalspeed).
    if(ship:airspeed > 100){
        set mysteer to heading(90, 75).
    }
}
