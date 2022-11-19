--[[
STE-C 55X Autopilot Plugin, a plugin to bring the "S-TEC FIFTY FIVE X" into your XPlane Flight Sim.
Copyright (C) 2022 Luka Emanuel Nöckel

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

You can contact me via E-MAIL: quackderbruchpilot05@gmail.com, via GitHub (QuackDerBruchpilot) or the X-Plane.org forum (@flightsimmer1710)

	ANY USE OF THIS CODE CONSTITUTES ACCEPTANCE OF THE TERMS OF THE COPYRIGHT NOTICE.
	The current software uses the SASL library. Redistribution in source and binary forms, with 
	or without modification, are not permitted.
	Copyright (c) 2020, 1-sim.aero
	All rights reserved.
	SASL copyright holders are not responsible in any event for malfunction, unavailability, 
	incompatibility or other problems that might occur while using the end product which uses 
	SASL in conjunction with any other software. SASL copyright holders are not liable for any 
	properties for any end product which uses SASL.
]]--

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------- AP mode variables -------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sasl.logInfo("Preprocessor active, reloading...")

sasl.logInfo("STE-C 55X Autopilot Plugin - Copyright (C) 2022 Luka Emanuel Nöckel")
sasl.logInfo("This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; for details open the License file in the plugin's directory.")

apHDG = false
apNAV = false
apAPR = false
apREV = false
apALT = false
apVS = false

anGS = false
anUP = false
anDN = false
anGPSS = false

vsANN = false
altANN = false
rollMode = false
pitchMode = false
VSrate = 0
s = false
i = false
k = false
t = false
x = false
y = false
z = false

done = true
NavCount = 0
GPSS_override = false

an_FAIL = false																					-- WORK IN PROGRESS
an_CWS = false																					-- WORK IN PROGRESS
an_RDY = false																					-- WORK IN PROGRESS
																					
