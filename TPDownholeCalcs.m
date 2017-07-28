%Power Requirements for downhole pressure logger
Vcc = 1.8; %Use 1.8v for minimal power

%MCU
% %ATTINY85, 128KHz
% I_MCU_Active = 80e-6; %80uA for ATTINY85 with internal 128 KHz osc
% I_MCU_Idle = 55e-6; %55uA for ATTINY85 with internal 128 KHz osc

%ATTINY441
I_MCU_Active = 22e-6; %22uA for ATTINY441 with internal 128 KHz osc
I_MCU_Idle = 5e-6; %5uA for ATTINY441 with internal 128 KHz osc

%PRESSURE SENSOR
%MS5803-05BA (same current comsumption for 89BSD)
I_Pressure_Active = 0.9e-6; %Minimum oversample ratio
I_Pressure_Idle = 0.02e-6;

%EEPROM
%24AA512
% I_EEPROM_Active = 400e-6; %Current values for 24AA512 EEPROM
% I_EEPROM_Idle = 100e-9;

%Get Active Values for AT24C512C!

%AT24C512C
I_EEPROM_Active = 400e-6; %Get Active Values for AT24C512C!
I_EEPROM_Idle = 1.5e-6;

%RTC
%DS1337
I_RTC_Active = 20e-6;
I_RTC_Idle = 1.5e-6;

%POWER
%TPS62120
I_Converter_Q = 1.2e-6; %~15uA of quiessent current for the TPS62120
ConverterEff = 0.6; 

TimeOn = 1; %On for one second to take measurment 
TimeOff = 900*4; %Off for 15 minutes (900 seconds) between measurments 

%BATTERY
BatteryCapacity = 48/1000; %48mAh at 3v for CR1225
%BatteryCapacity = 60/1000; %60mAh at 3v for 2xCR1025
%BatteryCapacity = 30/1000; %30mAh at 3v for CR1025
BatteryVoltage = 3; %3v Lithium 

PowerOn = Vcc*(I_MCU_Active + I_Pressure_Active + I_EEPROM_Active + I_RTC_Active)/ConverterEff + BatteryVoltage*I_Converter_Q;

PowerIdle = Vcc*(I_MCU_Idle + I_Pressure_Idle + I_EEPROM_Idle + I_RTC_Idle)/ConverterEff + BatteryVoltage*I_Converter_Q;

PowerAvg = (PowerOn*TimeOn + PowerIdle*TimeOff)/(TimeOn + TimeOff);

RunTime = 1/(PowerAvg/(BatteryCapacity*BatteryVoltage));

PowerText = ['Average Power = ', num2str(PowerAvg), ' Watts'];
TimeText = ['Run Time = ', num2str(RunTime), ' Hours'];
% disp('Average Power = ');
% disp(PowerAvg); 
% disp(' Watts');
% disp('Watts');
disp(PowerText);
disp(TimeText);
