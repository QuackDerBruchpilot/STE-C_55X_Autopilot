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

sasl.messageWindow	(
	500, 500, 500, 500, "STE-C 55X Autopilot Changelog",
		
	"v0.5.0-beta (current) \n ----------------------------------------------------------- \n -	added settings tab \n 		-	you can now select whether you want to start with or without the AP           showing up \n \n		-	added legal advice \n \n -	added license tab to see license in Sim \n -	added changelog tab to see changelog \n \n \n v0.4.0-beta \n ----------------------------------------------------------- \n -	initial public beta release \n \n \n v0.3.0-alpha \n ----------------------------------------------------------- \n -	initial alpha release for private alpha test",
		
	1,"Close", wnd_changelog_close
)
