## Dataset exploration

The idea of this project is to generate a dataset of electric vehicle driving using a Matlab/simulink simulation model. The dataset will be published in many plateformes as kaggle and github to be accessible by others sudents / data scientist / analyst. <br><br>

**Columns description**

* I_bat_ev : The HV battery current [A]
* Power_AC_ev : The AC power, transferred from the inverter to the motor [W]
* Power_DC_ev : The DC power, transferred from the battery to the inverter [W]
* Power_meca_ev : The mechanical power, the output of the motor [W]
* Power_wheel_ev : The mechanical power, in the output of the motor reductor [W]
* Ubat_ev : The battery DC voltage [V]
* acceleration_break : The acceleration/break command, range [-1,1], [-1,0] : break, [0,1] : acceleration
* acceleration_ev : The acceleration the EV [m/s2]
* distance_ev : The distance of the EV [m]
* kmph_meas : The speed of the EV [km/h]
* kmph_ref : The speed reference of the EV [km/h]
* loss_INV_ev : The power loss of the inverter [W]
* loss_batt_ev : The power loss of the battery [W]
* loss_body_ev : The power loss of the vehicle body (drag, rolling, ...) [W]
* loss_motor_ev : The power loss of the motor [W]
* road_grad : The road gradient [°]
* soc_ev : The battery state of charge (soc) [ %]
* time : The time [s]
* torque_motor_ev : The motor torque [N.m]
* rpm : The motor speed [tr/min]
* session : The simulation session, NEDC cyle, WLTC cyle, Highway driving, the step speed driving
* bat_energy_kwh : the battery energy [kWh]
