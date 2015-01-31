#!/bin/bash

battery_low=8200

charge=`system_profiler SPPowerDataType | grep "Charge Remaining" | awk '{print $4}'`
over=`system_profiler SPPowerDataType | grep "Full Charge" | awk '{print $5}'`
echo 'charge is '$charge ' over ' $over

if (( $charge < battery_low )); then
    echo 'shit no batteries left, should probably issue a warning'
fi


