<h1 style="text-align:center;">
RENAULT Megane E-TECH 220Hp 60kWh (EV): Generate a Time Series Dataset with Matlab/Simulink simulation model 
   
</h1>

# Introduction

The idea of this project is to generate a dataset of electric vehicle driving using a Matlab/simulink simulation model. The dataset will be published in many plateformes as kaggle and github to be accessible by others sudents / data scientist / analyst. <br><br>
For this purpose, we will start by preparing the data (NEDC / WLTP and other driving data). In the second time we will discovering the Matlab subsystem by some plot of the elements test results. After that we will calculate the autonomy of each driving mode (WLTC, NEDC, HighWay, constant speed, ...). In the annexes you can see how we convert a matlab route to the right data of time, distance, speed, elevation, road gradient for Matlab simulation and also the Matlab/Simulink hypothesis and parameters

<img src='https://bouz1.github.io/fils/MEGAN_ETECH_220/projectCoverPicture.png'>


## Abbreviation & keywords

**Abbreviation**

Below some abbreviation that well be used in this project

* EV : Electric vehicle
* SOC : State of charge 
* Batt : Battery
* INV : Inverter
* NEDC : New European Driving Cycle
* WLTC : Worldwide harmonized Light vehicles Test procedure Cycle

**Keywords**

EV simulation, Matlab, Simulink, WLTP , NEDC, EV Dataset, Electric vehicle dataset, HV battery, EV Autonomy, electrical motor, Thrust, car drag, wheel rolling, Newton's second law, Highway driving

## Links

* [Github repository of this projet](https://github.com/bouz1/EV_Matlab_Simulink_Megane_E_TECH_to_generate_data)
* [The main file as HTML](https://bouz1.github.io/fils/MEGAN_ETECH_220/EV_Megan_E_TECH_Simulation_V0.html)
* [The main file as notebook](https://github.com/bouz1/EV_Matlab_Simulink_Megane_E_TECH_to_generate_data/blob/main/Notebooks/EV_Megan_E_TECH_Simulation_V0.ipynb)
* [The ouput dataset link in Github](https://github.com/bouz1/EV_Matlab_Simulink_Megane_E_TECH_to_generate_data/tree/main/data/output)
* [The ouput dataset link in Kaggle](https://www.kaggle.com/datasets/bozzabb/ev-matlabsimulink-megane-e-tech-time-series-data/data)

# Table of contents
* [Introduction](#title_1)
	* [Abbreviation & keywords](#title_2)
	* [Links](#title_3)
* [Table of contents](#title_4)
* [NEDC vs WLTC Cycles](#title_5)
	* [Import of the libraries](#title_6)
	* [NEDC vs WLTC ](#title_7)
* [Simulation element tests](#title_8)
	* [Motor](#title_9)
	* [Battery](#title_10)
	* [Body ](#title_11)
	* [PI regulator, speed controller ](#title_12)
* [Driving simulation WLTC / NEDC/ Heighway ...](#title_13)
	* [WLTC Cycle](#title_14)
	* [NEDC Cycle](#title_15)
	* [Paris heigh way A5 225km](#title_16)
	* [The impact of speed on autonomy](#title_17)
	* [Comparaison](#title_18)
	* [Save the data](#title_19)
	* [Download dataset](#title_20)
	* [Dataset exploration](#title_21)
* [Annexes](#title_22)
	* [Convert a route from google maps to GPS coordinates](#title_23)
		* [Get the data ](#title_24)
	* [Post-processing of data](#title_25)
		* [Time row ](#title_26)
		* [The road gradient ](#title_27)
* [Matlab / Simulink](#title_28)
	* [Newton's second law](#title_29)
	* [Simulation hypotheses](#title_30)
	* [Simulink](#title_31)
		* [Initialisation ](#title_32)
		* [Simulation blocks ](#title_33)
