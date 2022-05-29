DROP DATABASE IF EXISTS battery;
CREATE DATABASE battery;
USE battery;


CREATE TABLE GEIS_setting(
`Mode` VARCHAR(30),
`Is` FLOAT, 
`unit Is` VARCHAR(30), 
`vs.` VARCHAR(30),
`tIs (h:m:s)` VARCHAR(30), 
`record` INT, 
`dE (mV)` FLOAT, 
`dt (s)` FLOAT, 
`fi` FLOAT, 
`unit fi` VARCHAR(30), 
`ff` FLOAT, 
`unit ff` VARCHAR(30), 
`Nd` INT, 
`Points` VARCHAR(30), 
`spacing` VARCHAR(30), 
`Ia/Va` VARCHAR(30), 
`Ia` FLOAT, 
`unit  Ia` VARCHAR(30), 
`va pourcent` FLOAT, 
`pw` FLOAT, 
`Na` INT,  
`corr` INT, 
`E range min (V)` FLOAT, 
`E range max (V)` FLOAT, 
`I Range`  VARCHAR(30), 
`Bandwidth` FLOAT, 
`nc cycles` INT, 
`goto Ns'` INT, 
`nr cycles` INT, 
`inc. cycle` INT
)CHARSET=utf8mb4;
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\GEIS\\setting.csv' INTO TABLE GEIS_setting FIELDS TERMINATED BY ',' IGNORE 1 LINES;

CREATE TABLE GEIS_loop_data(
`Loop Nr.` INT,
`begin point` INT,
`end point` INT
);
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\GEIS\\loop_data.csv' INTO TABLE GEIS_loop_data FIELDS TERMINATED BY ',';

CREATE TABLE GEIS_labor_data(
`freq/Hz` FLOAT,
`Re(Z)/Ohm` FLOAT,
`-Im(Z)/Ohm` FLOAT,
`|Z|/Ohm` FLOAT,
`Phase(Z)/deg` FLOAT,
`time/s` FLOAT,
`<Ewe>/V` FLOAT,
`<I>/mA` FLOAT,
`Cs/µF` FLOAT,
`Cp/µF` FLOAT,
`cycle number` FLOAT,
`|Ewe|/V` FLOAT,
`|I|/A` FLOAT,
`Ns` FLOAT,
`I Range` FLOAT,
`(Q-Qo)/mA.h` FLOAT,
`<Ece>/V` FLOAT,
`|Ece|/V` FLOAT,
`Phase(Zce)/deg` FLOAT,
`|Zce|/Ohm` FLOAT,
`Re(Zce)/Ohm` FLOAT,
`-Im(Zce)/Ohm` FLOAT,
`Phase(Zwe-ce)/deg` FLOAT,
`|Zwe-ce|/Ohm` FLOAT,
`Re(Zwe-ce)/Ohm` FLOAT,
`-Im(Zwe-ce)/Ohm` FLOAT,
`P/W` FLOAT,
`Re(Y)/Ohm-1` FLOAT,
`Im(Y)/Ohm-1` FLOAT,
`|Y|/Ohm-1` FLOAT,
`Phase(Y)/deg` FLOAT,
`dq/mA.h` FLOAT
);
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\GEIS\\labor_data.csv' INTO TABLE GEIS_labor_data FIELDS TERMINATED BY '	' IGNORE 1 LINES;


CREATE TABLE GCPL6_setting(
`Ns` INT,
`Set I/C` VARCHAR(30),
`Is` FLOAT,
`unit Is` VARCHAR(30),
`vs.` VARCHAR(30),
`N` FLOAT,
`I sign` VARCHAR(30),
`t1 (h:m:s)` VARCHAR(30),
`I Range` VARCHAR(30),
`Bandwidth` FLOAT,
`dE1 (mV)` FLOAT,
`dt1 (s)` FLOAT,
`EM (V)` FLOAT,
`tM (h:m:s)` VARCHAR(30),
`Im` FLOAT,
`unit Im` VARCHAR(30),
`dI/dt` FLOAT,
`dunit dI/dt` VARCHAR(30),
`E range min (V)` FLOAT,
`E range max (V)` FLOAT,
`dq` FLOAT,
`unit dq` VARCHAR(30),
`dtq (s)` FLOAT,
`dQM` FLOAT,
`unit dQM` VARCHAR(30),
`dxM` FLOAT,
`delta SoC (%)` VARCHAR(30),
`tR (h:m:s)` VARCHAR(30),
`dER/dt (mV/h)` FLOAT,
`dER (mV)` FLOAT,
`dtR (s)` FLOAT,
`EL (V)` VARCHAR(30),
`goto Ns'` FLOAT,
`nc cycles` FLOAT
)CHARSET=utf8mb4;
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\GCPL6\\setting.csv' INTO TABLE GCPL6_setting FIELDS TERMINATED BY ',' IGNORE 1 LINES;

CREATE TABLE GCPL6_loop_data(
`Loop Nr.` INT,
`begin point` INT,
`end point` INT
);
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\GCPL6\\loop_data.csv' INTO TABLE GCPL6_loop_data FIELDS TERMINATED BY ',';

CREATE TABLE GCPL6_labor_data(
`mode` INT,
`ox/red` INT,
`error` INT,
`control changes` INT,
`Ns changes` INT,
`counter inc.`	INT,
`Ns` INT,
`time/s` FLOAT,
`dq/mA.h` FLOAT,
`(Q-Qo)/mA.h` FLOAT,
`control/V/mA` FLOAT,
`Ewe/V` FLOAT,
`I Range` FLOAT,
`Q charge/discharge/mA.h` FLOAT,
`half cycle` FLOAT,
`Ece/V` FLOAT,
`P/W` FLOAT,
`Energy charge/W.h` FLOAT,
`Energy discharge/W.h`FLOAT,
`Capacitance charge/µF` FLOAT,
`Capacitance discharge/µF` FLOAT,
`<I>/mA` FLOAT,
`Q discharge/mA.h` FLOAT,
`Q charge/mA.h` FLOAT,
`Capacity/mA.h` FLOAT,
`Efficiency/%` FLOAT,
`control/V` FLOAT,
`control/mA` FLOAT,
`cycle number` FLOAT,
`Ecell/V` FLOAT
);
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\GCPL6\\labor_data.csv' INTO TABLE GCPL6_labor_data FIELDS TERMINATED BY '	' IGNORE 1 LINES;