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

sasl.options.setAircraftPanelRendering(false) 
sasl.options.set3DRendering(false)
sasl.options.setRenderingMode2D(SASL_RENDER_2D_DEFAULT)
sasl.options.setInteractivity(true)


components = {
	autopilot {},
	settings {},
}

--------------------------------------------------------------------------------------------------- apWindow

apWindow = contextWindow {				-- create new window

	name = "STE-C 55X Autopilot";				-- title of window
	position = {0, 0, 783, 202};				-- spawning position and size of window
	visible = false;							-- visible on load
	gravity = {0, 1, 0, 1};						-- no changes when XPWindow changes
	noResize = true;							-- no Resizing allowed
	noDecore = true;							-- no Decore
	
	components = {								
		autopilot {								-- content of window 
			position = {0, 0, 783, 202};
		};
	};
}

function show_hide_ap()					-- handle to set/unset window visible whenever we want
	apWindow:setIsVisible(not apWindow:isVisible())
end

--------------------------------------------------------------------------------------------------- settings window

settings_Window = contextWindow {		-- create new window

	name = "STE-C 55X Autopilot - Settings";	-- title of window
	position = {100, 150, 400, 300};			-- spawning position and size of window
	visible = false;							-- visible on load
	gravity = {0, 1, 0, 1};						-- no changes when XPWindow changes
	noResize = true;							-- no resizing allowed
	noDecore = false;							-- window has decore
	
	components = {
		settings {								-- content of window
			position = {0, 0, 400, 300};
		};
	};
}


function show_hide_set()				-- handle to set/unset window visible whenever we want
	settings_Window:setIsVisible(not settings_Window:isVisible())
end

--------------------------------------------------------------------------------------------------------------------------------- configuring menu

menu_master	= sasl.appendMenuItem (				--
	PLUGINS_MENU_ID, "STE-C 55X Autopilot"		-- add new Item to plugin menu list
)												--

menu_main	= sasl.createMenu (					--
	"", PLUGINS_MENU_ID, menu_master			-- add menu to our entry in plugin menu list
)												--

menu_ap	= sasl.appendMenuItem (					--
	menu_main, "show/hide", show_hide_ap		-- add option to our plugin menu Item (show/hide AP device)
)												--

menu_settings = sasl.appendMenuItem (			--
	menu_main, "settings", show_hide_set		-- add option to our plugin menu Item (show settings)
)												--

--------------------------------------------------------------------------------------------------------------------------------- include settings from config

addSearchPath(moduleDirectory.."/Custom Module/")				--
include("config")												--
																-- load config file and apply them
if AP_wnd_on_startup then										--
	apWindow:setIsVisible(true)									--
end																--

if first_launch then											--
	settings_Window:setIsVisible(true)							-- open settings Window on first launch
end																--

