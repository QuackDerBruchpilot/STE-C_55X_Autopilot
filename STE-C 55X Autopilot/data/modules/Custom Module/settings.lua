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

addSearchPath(moduleDirectory.."/Custom Module/")												-- loading settings
include("config")																				--


btn_save_color  = {0.153, 0.204, 0.255}										-- standard save button color
btn_licenses_color = {0.153, 0.204, 0.255}									-- standard licences button color
btn_changelog_color = {0.153, 0.204, 0.255}									-- standard licences button color

addSearchResourcesPath(moduleDirectory.."/images/")												-- add resources directory
gantari = sasl.gl.loadFont("Gantari-SemiBold.ttf")												-- define font





function onMouseDown(window, x, y, button, parentX, parentY)							-- mouse click event handler
	if button == MB_LEFT then
		if 3 <= x and x <= 23 and 143 <= y and y <= 163 then								-- checkbox 1
			AP_wnd_on_startup = not AP_wnd_on_startup											-- switch state for AP window on satrtup
		
			return 1
		end
		
		if 323 <= x and x <= 383 and 124 <= y and y <= 144 then								-- save button
		
			btn_save_color = {0.204, 0.229, 0.255}
			
			local settings = io.open(moduleDirectory.."/Custom Module/config.lua", "w+")		-- load config file
			io.output(settings)																	--
			io.write("first_launch = false\n")													--
			
			io.write("AP_wnd_on_startup = "..tostring(AP_wnd_on_startup).."\n")					-- save stuff
			io.close(settings)																	-- close file
			
			return 1
		end
		
		if 50 <= x and x <= 130 and 20 <= y and y <= 50 then								-- see licenses button
			
			btn_licenses_color = {0.204, 0.229, 0.255}
			show_license()
			return 1
		end
		
		if 270 <= x and x <= 350 and 20 <= y and y <= 50 then								-- see changelog button
			
			btn_changelog_color = {0.204, 0.229, 0.255}
			include("changelog")
			return 1
		end
	end
end





function wnd_changelog_close()
	sasl.logInfo("Changelog window closed")
end

function show_license()																	-- licenses text box
	sasl.messageWindow	(
		500, 500, 500, 500, "STE-C 55X Autopilot License",
		"STE-C 55X Autopilot Plugin, a plugin to bring the 'S-TEC FIFTY FIVE X' into your XPlane Flight Sim. \n \n Copyright (C) 2022 Luka Emanuel Nöckel \n \n This program is free software: You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or	(at your option) any later version. This program is distributed in the hope that it will be useful, but without any warranty; without even the implied warranty of merchantability or fitness for a particular purpose. See the GNU General Public License for more details. \n You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>. \n \n You can contact me via E-MAIL: quackderbruchpilot05@gmail.com, via GitHub (QuackDerBruchpilot) or the X-Plane.org forum (@QuackDerBruchpilot05) \n \n \n \n ANY USE OF THIS CODE CONSTITUTES ACCEPTANCE OF THE TERMS OF THE COPYRIGHT NOTICE. \n The current software uses the SASL library. Redistribution in source and binary forms, with or without modification, are not permitted.	Copyright (c) 2020, 1-sim.aero	All rights reserved. SASL copyright holders are not responsible in any event for malfunction, unavailability, incompatibility or other problems that might occur while using the end product which uses	SASL in conjunction with any other software. SASL copyright holders are not liable for any properties for any end product which uses SASL.",
		1,"Close", wnd_license_close
	)
end

function wnd_license_close()
	sasl.logInfo("License Window closed")
end





function onMouseUp(window, x, y, button, parentX, parentY)								-- mouse release event handler
	if button == MB_LEFT then
		if 323 <= x and x <= 383 and 124 <= y and y <= 144 then							
			btn_save_color = {0.153, 0.204, 0.255}											-- change color of save button back to standard
			return 1
		end
		
		if 50 <= x and x <= 130 and 20 <= y and y <= 50 then								-- change color of license button back to standard
			btn_licenses_color = {0.153, 0.204, 0.255}
			return 1
		end
		
		if 270 <= x and x <= 350 and 20 <= y and y <= 50 then								-- change color of changelog button back to standard
			btn_changelog_color = {0.153, 0.204, 0.255}
			return 1
		end
	end
end





function update()																		-- things we have to do every cycle

	if AP_wnd_on_startup then 																-- Decide if Checkbox should be checked or not
		chk_AP_wnd_on_startup = sasl.gl.loadImage("icons8-checked-checkbox-20.png")
	else
		chk_AP_wnd_on_startup = sasl.gl.loadImage("icons8-unchecked-checkbox-20.png")
	end
end





local function text(x, y, txt)
	sasl.gl.drawText(gantari, x, y, txt, 12, false, false, TEXT_ALIGN_LEFT, {1.0, 1.0, 1.0})
end

local function text_warning(x, y, txt)
	sasl.gl.drawText(gantari, x, y, txt, 12, true, false, TEXT_ALIGN_LEFT, {1.0, 0.0, 0.0})
end





function draw()																			-- draw things into the settings window

	text(4, 285, "STE-C 55X Autopilot Plugin - Copyright (C) 2022 Luka Emanuel Nöckel")			-- copyright owner
	sasl.gl.drawLine(0, 277, 400, 277, {210, 210, 210})											-- spacer
	
	text(3, 263, "This program comes with ABSOLUTELY NO WARRANTY. This is free")				--
	text(3, 250, "software, and you are welcome to redistribute it under certain")				-- copyright notice
	text(3, 237, "conditions. For details open the License file in the plugin's directory.")	--
	
	text_warning(45, 215, "NO GUARENTEED REAL BEHAVIOR! FOR FLIGHT")							-- legal advice
	text_warning(100, 200, "SIMULATION PURPOSE ONLY!")											-- please take seriously
	sasl.gl.drawLine(0, 185, 400, 185, {210, 210, 210})											-- spacer
	
	text(3, 170, "Settings:")														-- settings section
	
		sasl.gl.drawTexture(chk_AP_wnd_on_startup, 3, 143, 20, 20)								-- draw checkbox
		text(35, 150, "open autopilot window on startup")										-- text for checkbox
		
	sasl.gl.drawRectangle(323, 124, 60, 20, btn_save_color)										-- Save button
	text(340, 130, "Save")																		--
	
	sasl.gl.drawRectangle(50, 20, 80, 30, btn_licenses_color)									-- licences button
	text(56, 32, "see licences")																--
	
	sasl.gl.drawRectangle(270, 20, 80, 30, btn_changelog_color)									-- changelog button
	text(280, 32, "changelog")																	--
end






sasl.logInfo("settings window loaded")








