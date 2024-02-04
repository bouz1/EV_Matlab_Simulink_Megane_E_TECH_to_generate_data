%% Clear all variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% General variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
torque_max=300; %% N.m %% https://www.autodauphine.fr/uploads/vehicules_neufs/44/1641221181_ddc90a41141d81d0c5f3.pdf
power_max = 160e3; %% W %% https://www.autodauphine.fr/uploads/vehicules_neufs/44/1641221181_ddc90a41141d81d0c5f3.pdf
m = 1600+80*2; %% %% weight of the vehicle + 2 average persones [kg] https://www.renault.fr/vehicules-electriques/megane-e-tech-electrique/comparateur-specifications.html
m0= 1600; %% Vehicle without passangers
g = 9.80665 ; %% %% standard gravitational acceleration for the surface of the Earth [m/s2]
mps_to_kmph= 3.6; %% V[km/h]  = V[m/s] * mps_to_kmph 


%% Drag %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
air_density=1.293 ; %% kg m?3 %% air density 
SCx= 0.674 ; %% [m²] %% https://www.lesnumeriques.com/voiture/renault-megane-e-tech-electric-la-nouvelle-compacte-electrique-aux-faux-airs-de-suv-n167917.html
%%%The above measurement give a SCx of 0.674
%%%But the idea is to tune the SCx to find an WLTC autonomy between 450 and 470km
SCx= 0.5; %% with this value the autonomy is 457km => OK 
k_drag= (1/2)*air_density*SCx; %% N/(m/s)^2 %% drag total coefficient: Drag = k_drag * velocity ^2 https://en.wikipedia.org/wiki/Drag_equation



%% Rolling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% formula Rolling = f · m · g · cos(?) https://x-engineer.org/rolling-resistance/
% f : rolling resistance coefficient = 0.013 https://x-engineer.org/rolling-resistance/
% ? : road with the gradient [rad]
% m: weight of the vehicle [kg] : see above
% k_rolling = f · m · g
k_rolling = 0.013*m*g; %% total rolling coefficient : Rolling = k_rolling· cos(?) see above 




%% Reduction ratio %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kmph_max=160; %% [km/h] %% max speed: https://fr.wikipedia.org/wiki/Renault_Megane_E-Tech_Electric
rpm_max=11688;%% [tr/min]%% max rpm: https://fr.wikipedia.org/wiki/Renault_Megane_E-Tech_Electric
rmp_2_kmph=(kmph_max/rpm_max);%% V[km/h]= rmp_2_kmph* N[tr/min]
tourque_2_thrust = (2*pi*3.6/60)/rmp_2_kmph; %% Thrust [N] = tourque_2_thrust * Torque[N.m]

%% Efficiency
motor_eff=0.91  ; %% https://renault.com.mt/driveelectric/engine-e-tech-electric.html#:~:text=Our%20externally%20excited%20synchronous%20motor,a%20high%20performance%20of%2091%25.
inverter_eff = 0.93 ; %% example of inverter efficiency : https://www.powersystemsdesign.com/articles/efficient-dc-ac-inverter-for-high-voltage-electric-vehicles/95/15405
reduction_eff=0.98;  %% I don't find any value in the web, but a chose this value because reductor will be effcient 


%% Inverter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U_uvp = 330 ; %% V %% the under voltage protaction


%% Battery %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nb_modules= 12; %% https://www.renaultgroup.com/wp-content/uploads/2023/03/renault_deu_20230316.pdf
Nb_cells_by_modules= 24;%% https://www.renaultgroup.com/wp-content/uploads/2023/03/renault_deu_20230316.pdf
Nb_cells= Nb_modules*Nb_cells_by_modules;
Nb_cells_paralles = floor(Nb_cells*4.2/400); % voltage of cell = 4.2V <===> 400v of the batterie 
Nb_serial= Nb_cells/Nb_cells_paralles; % Nb of serial cells
soc = [0, 2, 6, 9, 20, 37, 42, 57, 66, 77, 85, 91, 95, 98, 100]; %% State of charge   : https://www.richtek.com/Design%20Support/Technical%20Document/AN024
U_cell=[3.41, 3.61, 3.78, 3.86, 3.89, 3.90, 3.92, 3.97, 4.00, 4.04, 4.10, 4.16, 4.19, 4.195, 4.20]; %% cell voltage   : https://www.richtek.com/Design%20Support/Technical%20Document/AN024
U_bat= U_cell*Nb_serial; %% the battery voltage
bat_energy_kwh= 60 ; %% kWh %% the battery capacity 60kWh:  https://fr.wikipedia.org/wiki/Renault_Megane_E-Tech_Electric
bat_energy=bat_energy_kwh*1000*3600 ;%% W.s = j %%
R_dc=0.25 ; %% Ohm %% internal batterie resistnace 



%% Speed controlor (PI) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K_p= 0.05;%% 0.03
w_I= 0.01; %% 0.01  0.005
P_coef= K_p;
I_coef = K_p*w_I;


%% WLTC Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% you can find the pdf in this link https://en.wikipedia.org/wiki/Worldwide_Harmonised_Light_Vehicles_Test_Procedure
data= readtable('../../data/processed/dfgps_fin.csv');
time= data.time; 
kmph= data.kmph; 
sim_time=max(time); %%% sim time 
rouad_grad=data.rouad_grad %% Road gradient
Ts= 0.5; %% Simulation step
PWr= power_max/m0; %% = 100 W/kg > 34 ==> class 3 of WLTC ; The power-to-mass ratio (PWr) Pwr = Power[w]/masse[kg]

%% Plot WLTC time/kmph
plot(time,kmph);


%% Initial values
x_initial=0 ; %%m%% initial distance 
Velocity_0= 0; %% Initial vehicle speed



