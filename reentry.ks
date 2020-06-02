set mysteer to ship:srfretrograde.
set thr to 0.
lock steering to mysteer.
lock throttle to thr.
clearScreen.

print("THIS CODE WILL ACTIVATE EVERY SINGLE STAGE. IF YOUR PARACHUTE IS NOT IN STAGE 0, QUIT NOW.").

when (SHIP:altitude < 10000 and SHIP:verticalspeed < 0 and SHIP:verticalspeed*(-1) < 300) THEN{
        print("Deploying Chute...").
        until (stage:number = 0){
            stage.
        }
        unlock steering.
}
when (SHIP:altitude < 70000 and SHIP:verticalspeed < 0) THEN{
        print("Aligning Retrograde...").
        print("Ditching rocket parts.").
        until (stage:number = 1){
            stage.
        }
        set mysteer to ship:srfretrograde.
}

until(ship:status = "LANDED"){
    wait(0.5).
}