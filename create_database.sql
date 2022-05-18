DROP DATABASE IF EXISTS battery;
CREATE DATABASE battery;
USE battery;

CREATE TABLE labor_data(
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
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\	\\labor_data.csv' INTO TABLE eis FIELDS TERMINATED BY '	' IGNORE 1 LINES;

CREATE TABLE setting(
`Mode` VARCHAR(30),
`Is` FLOAT, 
`unit Is` VARCHAR(30), 
`vs.` VARCHAR(30),
`tIs (h:m:s)` VARCHAR(30), 
`record` INT(5), 
`dE (mV)` FLOAT, 
`dt (s)` FLOAT, 
`fi` FLOAT, 
`unit fi` VARCHAR(30), 
`ff` FLOAT, 
`unit ff` VARCHAR(30), 
`Nd` INT(5), 
`Points` VARCHAR(30), 
`spacing` VARCHAR(30), 
`Ia/Va` VARCHAR(30), 
`Ia` FLOAT, 
`unit  Ia` VARCHAR(30), 
`va pourcent` FLOAT, 
`pw` FLOAT, 
`Na` INT(5),  
`corr` INT(5), 
`E range min (V)` FLOAT, 
`E range max (V)` FLOAT, 
`I Range`  VARCHAR(30), 
`Bandwidth` FLOAT, 
`nc cycles` INT(5), 
`goto Ns'` INT(5), 
`nr cycles` INT(5), 
`inc. cycle` INT(5)
)CHARSET=utf8mb4;
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\setting.csv' INTO TABLE setting FIELDS TERMINATED BY ',' IGNORE 1 LINES;

CREATE TABLE loop_data(
`Loop Nr.` INT,
`begin point` INT,
`end point` INT
);
LOAD DATA LOCAL INFILE 'D:\\Study\\Studium\\INES\\code\\data\\loop_data.csv' INTO TABLE loop_data FIELDS TERMINATED BY ',';