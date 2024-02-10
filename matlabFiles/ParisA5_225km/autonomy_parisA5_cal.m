%% Autonomy calculation 

d_soc=100-tws_soc_ev.signals.values(end);%% delta soc
delta_dist=max(tws_distance_ev.signals.values); %% delta distance
autonomy = (delta_dist*100/d_soc)/1000;  %% Autonomy
% Display 
display('Autonomy WLTC');
display(autonomy);

%% Results
% Autonomy WLTC
% autonomy =
%  287.5577