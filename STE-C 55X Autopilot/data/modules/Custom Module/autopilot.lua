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
---------------------------------------------------------------------------------------- Datarefs and Commands ----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
trimUP = globalProperty("sim/cockpit2/annunciators/autopilot_trim_up")
trimDN = globalProperty("sim/cockpit2/annunciators/autopilot_trim_down")
vertical_speed = globalProperty("sim/cockpit/autopilot/vertical_velocity")
vvi_ind = globalProperty("sim/cockpit2/gauges/indicators/vvi_fpm_pilot")
heading_mode = globalProperty("sim/cockpit2/autopilot/heading_mode")
nav_status = globalProperty("sim/cockpit2/autopilot/nav_status")
approach_status = globalProperty("sim/cockpit2/autopilot/approach_status")
backcourse = globalProperty("sim/cockpit2/autopilot/backcourse_status")
altitude_state = globalProperty("sim/cockpit2/autopilot/altitude_hold_status")
glide_status = globalProperty("sim/cockpit2/autopilot/glideslope_status")
vvi_status = globalProperty("sim/cockpit2/autopilot/vvi_status")
sel_altitude = globalProperty("sim/cockpit/autopilot/altitude")
batt_on = globalProperty("sim/cockpit/electrical/battery_on")
gpss = globalProperty("sim/cockpit2/autopilot/heading_is_gpss")
gpss_status = globalProperty("sim/cockpit2/autopilot/gpss_status")

HDG = sasl.findCommand("sim/autopilot/heading")
NAV = sasl.findCommand("sim/autopilot/NAV")
APR = sasl.findCommand("sim/autopilot/approach")
REV = sasl.findCommand("sim/autopilot/back_course")
ALT = sasl.findCommand("sim/autopilot/altitude_hold")
VS = sasl.findCommand("sim/autopilot/vertical_speed")
VSdn = sasl.findCommand("sim/autopilot/vertical_speed_down")
VSup = sasl.findCommand("sim/autopilot/vertical_speed_up")
ServosOff = sasl.findCommand("sim/autopilot/servos_off_any")
GPSS = sasl.findCommand("sim/autopilot/gpss")
WingLVL = sasl.findCommand("sim/autopilot/wing_leveler")

--------------------------------
----- run the Preprocessor -----
--------------------------------
include("preprocessor.lua")

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------ Code -------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set(globalProperty("sim/cockpit/autopilot/autopilot_mode"), 0)									-- make sure all autopilot modes are off when we start our own autopilot

function onMouseDown(window, x, y, button, parentX, parentY)									-- what should be done if we press the mouse button?
	if get(batt_on) == 1 then																	-- check if battery is on
	
		if button == MB_LEFT then															-- check if we use LEFT mouse button
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if 49 <= x and x <= 101 and 38 <= y and y <= 69 then					--
																					--
				sasl.commandOnce(HDG)												-- activate HEADING mode
				NavCount = 0														--
				return 1															--
			end																		--
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------																		
			if 155 <= x and x <= 205 and 38 <= y and y <= 69 then					--
																					--
				if NavCount == 1 then												--
					sasl.commandOnce(GPSS)											--
					apNAV = true													--
					NavCount = 2													--
				elseif NavCount == 2 then											--
					apNAV = false													--
					sasl.commandOnce(NAV)											-- enable NAV mode or GPSS mode if NAV already is active
					NavCount = 1													--
				elseif NavCount == 0 then											--
					sasl.commandOnce(NAV)											--
					NavCount = 1													--
				end																	--
																					--
				return 1															--
			end																		--
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if 257 <= x and x <= 309 and 38 <= y and y <= 69 then					--
																					--
				sasl.commandOnce(APR)												-- enable APR mode
				NavCount = 0														--
				return 1															--
			end																		--
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if 360 <= x and x <= 412 and 38 <= y and y <= 69 then					--
																					--
				sasl.commandOnce(REV)												-- enable REV mode
				NavCount = 0														--
				return 1															--
			end																		--
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if 461 <= x and x <= 515 and 38 <= y and y <= 69 then					--
																					--
				if rollMode then													-- ALT mode can only be activated if one roll mode is active
					sasl.commandOnce(ALT)											--
					AltSEL = get(sel_altitude)										--
																					--
					Altmin = AltSEL - 360											--
					Altmax = AltSEL + 360											--
				end																	--
																					--
				return 1															--
			end																		--
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if 565 <= x and x <= 617 and 38 <= y and y <= 69 then					--
																					--
				if rollMode then													--
					sasl.commandOnce(VS)											--
																					-- enable VS mode
					VSrate = math.floor(get(vvi_ind))								--
					set(vertical_speed, VSrate)										--
																					--
					VSmin = VSrate - 1600											--
					VSmax = VSrate + 1600											--
				end																	--
																					--
				return 1															--
			end																		--
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if 648 <= x and x <= 670 and 38 <= y and y <= 69 then					--
																					--
				if get(vvi_status) == 2 then										--
																					--
					if VSrate > VSmin then											--
						sasl.commandOnce(VSdn)										-- change VS if active
						VSrate = VSrate - 100										--
					end																--
				end																	--
																					-- or
				if get(altitude_state) > 0 then										--
																					--
					if AltSEL > Altmin then											--
						AltSEL = AltSEL - 20										-- change ALT if active
						set(sel_altitude, AltSEL)									--
					end																-- 
				end																	--
																					-- and the negative way
				return 1															--
			end																		--
																					--
			if 720 <= x and x <= 743 and 38 <= y and y <= 69 then					-- the positive way
																					--
				if get(vvi_status) == 2 then										--
																					--
					if VSrate < VSmax then											--
						sasl.commandOnce(VSup)										--
						VSrate = VSrate + 100										--
					end																--
				end																	--
																					--
				if get(altitude_state) > 0 then										--
																					--
					if AltSEL < Altmax then											--
						AltSEL = AltSEL + 20										--	
						set(sel_altitude, AltSEL)									--
					end																--
				end																	--
																					--
				return 1															--
			end																		--
		end
	end
end





function shutdown()																				-- shutdown procedure if we need to turn of the AP
	sasl.commandOnce(ServosOff)													-- turn off all servos (disables AP in XPlane logic)
	include("preprocessor.lua")													-- re-run the "PreProcessor"
	done = true																	-- return that we successfully shut down the AP system
end
	
function update()																				-- things done every frame
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if get(batt_on) == 0 and not done then										-- 
		shutdown()																-- if Batt switch has been turned off then
	elseif get(batt_on) == 1 then												-- shutdown the AP and
		done = false															-- disable all functions
	end																			--
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if altANN and not rollMode then												-- 
		sasl.commandOnce(ALT)													-- if no roll mode is engaged, we have to make sure that
		altANN = false															--
	end																			-- ALT mode
																				-- and
	if vsANN and not rollMode then												-- VS mode
		sasl.commandOnce(VS)													--
		vsANN = false															-- and their respective annunciators are disabled
	end																			--
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if get(approach_status) == 0 then											--
		GS_override = false														-- because of XPlane bug we have to turn off the GS announciator 
	else																		-- manually if we abort the APR
		GS_override = true														--
	end																			--
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if VSrate > 0 and VSrate > get(vvi_ind) then								-- 
																				--
		if not s then															-- for flashing "VS" annunciation if the AP can't hold the selected VS
			s = os.clock()														--
		end																		--
																				--
		if s + 15 < os.clock() then												--
			if not i then														--
				i = math.floor(os.clock())										--
			end																	--
																				--
			if i + 1 == math.floor(os.clock()) then								-- flashing frequency will be 1 sec on, 1 sec off, ...
				VS_override = not VS_override									--			
				i = math.floor(os.clock())										--	
			end																	--
		else 																	--
			VS_override = true													--
		end																		--
																				--
	else																		--
		VS_override = true														--
	end																			-- 
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if sasl.getGPSDestination() == -1 and NavCount == 2 then					--
		anGPSS = true															--
		sasl.commandOnce(WingLVL)												-- for flashin "GPSS" and "NAV" announciation if GPSS is active but the GPS doesn't provide any data
		if not i then															--
			i = math.floor(os.clock())											--
		end																		--
																				--
		if i + 1 == math.floor(os.clock()) then									-- flashing frequency will be 1 sec on, 1 sec off, ...
			GPSS_override = not GPSS_override									--
			i = math.floor(os.clock())											--
		end																		--
	else																		--
		if NavCount == 2 and get(gpss_status) == 0 then							--
			sasl.commandOnce(GPSS)												--
		end																		--
																				--
		GPSS_override = true													--
		anGPSS = false															--
		i = false																--
	end																			--
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if get(trimUP) == 1 then													--
		anUP = true																--
	else																		--
		anUP = false															--
	end																			--
																				-- if AP is trimming we want to know so here we go
	if get(trimDN) == 1 then													--
		anDN = true																--
	else																		--
		anDN = false															--
	end																			--
end





-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------- drawing stuff --------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

addSearchResourcesPath(moduleDirectory.."/images/")												-- add resources directory

function text(x, y, txt, size)																	--
	sasl.gl.drawText(sasl.gl.loadFont("Gantari-SemiBold.ttf"), x, y, txt, size,					--
	false, false, TEXT_ALIGN_LEFT, {0.0, 0.0, 0.0}												--
	)																							--
end																								-- shrinking drawText functions to make things easier
																								--
function text_2(x, y, txt, ALG)																	--
	sasl.gl.drawText(sasl.gl.loadFont("DSEG7ClassicMini-Bold.ttf"), x, y, txt, 30,				--
	false, false, ALG, {0.0, 0.0, 0.0}															--
	)																							--
end																								--

function draw()																					-- draw stuff

	sasl.gl.drawTexture(sasl.gl.loadImage("S-TEC.png"), 0, 0, 783, 202)					-- AP main stack everytime

	if get(batt_on) == 1 then
	
		rollMode = false
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if apHDG or get(heading_mode) == 1 then												--
			text(50, 130, "HDG", 25)														-- HDG announciator
																							--
			rollMode = true																	--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if an_RDY then																		--														--
			text(113, 148, "R", 12)															--														-- WORK
			text(118, 134, "D", 12)															-- RDY announciator										-- IN
			text(123, 120, "Y", 12)															--														-- PROGRESS
		end																					--														--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if GPSS_override then																--
			if apNAV or get(nav_status) > 0 then											--
				text(140, 130, "NAV", 25)													-- NAV announciator
																							--
				rollMode = true																--
			end																				--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if an_CWS then																		--														--
			text(203, 148, "C", 12)															--														-- WORK
			text(208, 134, "W", 12)															-- CWS announciator										-- IN
			text(218, 121, "S", 13)															--														-- PROGRESS
		end																					--														--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if apAPR or get(approach_status) > 0 then											--
			text(235, 130, "APR", 25)														-- APR announciator
																							--
			rollMode = true																	--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if an_FAIL then																		--														--
			text(295, 148, "F", 12)															--														-- WORK
			text(303, 139, "A", 12)															-- FAIL													-- IN
			text(315, 130, "I", 12)															-- announciator											-- PROGRESS
			text(323, 121, "L", 12)															--														--
		end																					--														--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if GPSS_override then																--
			if anGPSS or get(gpss_status) == 2 then											--
				text(319, 148, "G", 12)														--
				text(329, 139, "P", 12)														-- GPSS
				text(337, 130, "S", 13)														-- announciator
				text(345, 121, "S", 13)														--
			end																				--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if apREV or get(backcourse) > 0 then												--
			text(362, 130, "REV", 25)														-- REV announciator
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if anUP or anDN then																--
			text(415, 130, "TRIM", 25)														-- TRIM announciator
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if anUP then																		--
			sasl.gl.drawTriangle(															--
				484, 142,						-- x1, y1									--
				509, 142,						-- x2, y2									-- UP
				496.5, 154.5,					-- x3, y3									-- triangle
				{0.0, 0.0, 0.0}					-- color									--
			)																				--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if anDN then																		--
			sasl.gl.drawTriangle(															--
				484, 135,						-- x1, y1									--
				509, 135,						-- x2, y2									-- DOWN
				496.5, 122.5,					-- x3, y3									-- triangle
				{0.0, 0.0, 0.0}					-- color									--
			)																				--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if apALT or get(altitude_state) > 0 then											--
			text(515, 130, "ALT", 25)														-- ALT announciator
																							--
			altANN = true																	--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if GS_override then																	--
																							--
			if anGS or get(glide_status) > 0 then											--
				text(570, 130, "GS", 25)													-- GS announciator
			end																				--
		end																					--
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if VS_override then																	--
																							--
			if apVS or get(vvi_status) == 2 then											--	
				text(615, 130, "VS", 25)													-- VS announciator
																							--
				vsANN = true																--
			end																				--
		end																					--
																							--
		if apVS or get(vvi_status) == 2 then												--	
																							--
			if VSrate < 0 then																--
				text_2(650, 123, "-", TEXT_ALIGN_LEFT)										--														-- "+" annunciation on positive values = WORK IN PROGRESS
			end																				--
																							--
			text_2(725, 124, math.abs(math.floor(VSrate/100)), TEXT_ALIGN_RIGHT)			--
		end																					--
	end
end	
	
	

	
	
	
	















