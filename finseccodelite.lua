--
-- Name:        finseccodelite/finseccodelite.lua
-- Purpose:     Define the CodeLite action(s).
-- Author:      Ryan Pusztai
-- Modified by: Andrea Zanellato
--              Andrew Gough
--              Manu Evans
-- Created:     2013/05/06
-- Copyright:   (c) 2008-2015 Jason Perkins and the Premake project
--

	local p = premake

	p.modules.finseccodelite = {}
	p.modules.finseccodelite._VERSION = p._VERSION

	local finseccodelite = p.modules.finseccodelite
	local project = p.project


	function finseccodelite.cfgname(cfg)
		local cfgname = cfg.buildcfg
		if finseccodelite.workspace.multiplePlatforms then
			cfgname = string.format("%s|%s", cfg.platform, cfg.buildcfg)
		end
		return cfgname
	end

	function finseccodelite.esc(value)
		local result = value:gsub('"', '\\&quot;')
		result = result:gsub('<', '&lt;')
		result = result:gsub('>', '&gt;')
	    result = result:gsub('&', '&amp;')
		return result
	end

	function finseccodelite.generateWorkspace(wks)
		p.eol("\r\n")
		p.indent("  ")
		p.escaper(finseccodelite.esc)

		p.generate(wks, ".workspace", finseccodelite.workspace.generate)
	end

	function finseccodelite.generateProject(prj)
		p.eol("\r\n")
		p.indent("  ")
		p.escaper(finseccodelite.esc)

		if project.isc(prj) or project.iscpp(prj) then
			p.generate(prj, ".project", finseccodelite.project.generate)
		end
	end

	function finseccodelite.cleanWorkspace(wks)
		p.clean.file(wks, wks.name .. ".workspace")
		p.clean.file(wks, wks.name .. "_wsp.mk")
		p.clean.file(wks, wks.name .. ".tags")
		p.clean.file(wks, ".clang")
	end

	function finseccodelite.cleanProject(prj)
		p.clean.file(prj, prj.name .. ".project")
		p.clean.file(prj, prj.name .. ".mk")
		p.clean.file(prj, prj.name .. ".list")
		p.clean.file(prj, prj.name .. ".out")
	end

	function finseccodelite.cleanTarget(prj)
		-- TODO..
	end

	include("_preload.lua")
	include("finseccodelite_workspace.lua")
	include("finseccodelite_project.lua")
	
	print("FinSec Premake5 Codelite Module Loaded...")

	return finseccodelite
