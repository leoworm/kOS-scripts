wait 1.

function visviva{
    parameter targetBody, vesselAlt, aP, pE.
    set vel to SQRT(targetBody:mu*(2/(vesselAlt+targetBody:radius)-1/((aP+Pe+2*targetBody:radius)/2))).
    return vel.
}

function rocketEq{
    parameter dV.
    parameter engine.
    set massRemaining to (ship:wetmass*constant:e^(dV/engine:ispAt(0))).

    set burnTime to (massRemaining/(engine:maxThrustAt(0)/engine:ispAt(0))).
    return burnTime.
}

print(visviva(kerbin, 100000, 100000, 100000)).

list engines in myEngines.

for eng in myEngines{
    if(eng:maxThrust > 0){
        print(rocketEq(500, eng)).
    }
}