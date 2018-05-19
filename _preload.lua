--
-- Name:        finseccodelite/_preload.lua
-- Purpose:     Define the CodeLite action.
-- Author:      Ryan Pusztai
-- Modified by: Andrea Zanellato
--              Andrew Gough
--              Manu Evans
-- Created:     2013/05/06
-- Copyright:   (c) 2008-2015 Jason Perkins and the Premake project
--

	local p = premake

	newaction
	{
		-- Metadata for the command line and help system

		trigger         = "finseccodelite",
		shortname       = "FinSecCodeLite",
		description     = "Generate CodeLite project files",
		toolset         = "clang",

		-- The capabilities of this action

		valid_kinds     = { "ConsoleApp", "WindowedApp", "Makefile", "SharedLib", "StaticLib", "Utility" },
		valid_languages = { "C", "C++" },
		valid_tools     = {
			cc = { "gcc", "clang", "msc" }
		},

		-- Workspace and project generation logic

		onWorkspace = function(wks)
			p.modules.finseccodelite.generateWorkspace(wks)
		end,
		onProject = function(prj)
			p.modules.finseccodelite.generateProject(prj)
		end,

		onCleanWorkspace = function(wks)
			p.modules.finseccodelite.cleanWorkspace(wks)
		end,
		onCleanProject = function(prj)
			p.modules.finseccodelite.cleanProject(prj)
		end,
		onCleanTarget = function(prj)
			p.modules.finseccodelite.cleanTarget(prj)
		end,
	}


--
-- Decide when the full module should be loaded.
--

	return function(cfg)
		print("s")
		return (_ACTION == "finseccodelite")
	end
