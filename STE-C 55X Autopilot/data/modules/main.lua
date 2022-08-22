-- STE-C 55X Autopilot Simulation (C)2022 Luka Emanuel Nöckel
-- main.lua defines all sub-scripts required for the current project

sasl.options.setAircraftPanelRendering(false)
sasl.options.set3DRendering(false)
sasl.options.setRenderingMode2D(SASL_RENDER_2D_DEFAULT)
sasl.options.setInteractivity(true)


components = {
	autopilot {},
}


apWindow = contextWindow {				-- create new Window

	name = "STE-C 55X Autopilot";				-- title of window
	position = {0, 0, 783, 202};				-- spawning position and size of window
	visible = true;							-- visible on load
	gravity = {0, 1, 0, 1};						-- no changes when XPWindow changes
	noResize = true;							-- no Resizing allowed
	noDecore = true;							-- no Decore
	
	components = {								
		autopilot {								-- content of window 
			position = {0, 0, 783, 202};
		};
	};
}

function show_hide()					-- handle to set/unset window visible whenever we want
	apWindow:setIsVisible(not apWindow:isVisible())
end

menu_master	= sasl.appendMenuItem (				--
	PLUGINS_MENU_ID, "STE-C 55X Autopilot"		-- add new Item to plugin menu list
)												--

menu_main	= sasl.createMenu (					--
	"", PLUGINS_MENU_ID, menu_master			-- add menu to our entry in plugin menu list
)												--

menu_option	= sasl.appendMenuItem(				--
	menu_main, "show/hide", show_hide			-- add option to our plugin menu Item (show/hide AP device)
)												--

