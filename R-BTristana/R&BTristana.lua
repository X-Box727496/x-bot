--[[
---//==================================================\\---
--|| > About Script										||--
---\===================================================//---
	Script:			Tristana - The God Gunner
	Version:		1.02
	Script Date:	2015-02-03
	Author:			Devn
---//==================================================\\---
--|| > Changelog										||--
---\===================================================//---
	Version 1.00:
		- Initial script release.

	Version 1.01:
		- Added anti-gapcloser.

	Version 1.02:
		- Added auto-interrupter.
--]]

---//==================================================\\---
--|| > User Variables									||--
---\===================================================//---

_G.TristanaGod_AutoUpdate			= true
_G.TristanaGod_EnableDebugMode		= false

---//==================================================\\---
--|| > Initialization									||--
---\===================================================//---

-- Champion check.
if (not myHero.charName == "Tristana") then return end

-- Load GodLib.
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
if (not GodLib) then return end

-- Update variables.
GodLib.Update.Host				= "raw.github.com"
GodLib.Update.Path				= "DevnBoL/Scripts/master/Tristana"
GodLib.Update.Version			= "Current.version"
GodLib.Update.Script			= "Tristana - The God Gunner.lua"

-- Script variables.
GodLib.Script.Variables			= "TristanaGod"
GodLib.Script.Name 				= "Tristana - The God Gunner"
GodLib.Script.Version			= "1.00"
GodLib.Script.Date				= "2015-02-03"

-- Required libraries.
GodLib.RequiredLibraries		= {
	["SxOrbWalk"]				= "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua",
}

---//==================================================\\---
--|| > Callback Handlers								||--
---\===================================================//---

Callbacks:Bind("Initialize", function()

	SetupVariables()
	SetupDebugger()
	SetupConfig()

	PrintLocal(Format("Script v{1} loaded successfully!", ScriptVersion))

	ScriptManager:GetAsyncWebResult(GodLib.Update.Host, Format("/{1}/{2}", GodLib.Update.Path, "Message.txt"), function(message)
		PrintLocal(message)
	end)

end)

Callbacks:Bind("Draw", function()

	if (not myHero.dead) then
		OnDrawRanges(Config.Drawing)
	end

end)

Callbacks:Bind("GapcloserSpell", function(unit, data)

	if (ValidTarget(unit) and Config.AntiGapcloser.UseR and Spells[_R]:IsReady()) then
		Spells[_R]:Cast(unit)
	end

end)

Callbacks:Bind("InterruptableSpell", function(unit, data)

	if (ValidTarget(unit) and Spells[_R]:IsReady() and Config.Interrupter.UseR and Spells[_R]:InRange(unit) and (data.DangerLevel >= Config.Interrupter.MinDangerLevelR)) then
		Spells[_R]:Cast()
	end

end)

---//==================================================\\---
--|| > Script Setup										||--
---\===================================================//---

function SetupVariables()

	Spells			= {
		[_Q]		= SpellData(_Q, nil, "Rapid Fire"),
		[_E]		= SpellData(_E, function() return myHero.range end, "Explosive Charge"),
		[_R]		= SpellData(_R, function() return myHero.range end, "Buster Shot"),
	}

	CurrentTarget	= nil

	Config			= MenuConfig("TristanaGod", ScriptName)
	Selector		= SimpleTS(STS_LESS_CAST)
	AntiGapcloser	= AntiGapcloser()
	Interrupter		= Interrupter()

	TickManager:Add("Combo", "Combo Mode", 500, function() OnComboMode(Config.Combo) end)
	TickManager:Add("Harass", "Harass Mode", 500, function() OnHarassMode(Config.Harass) end)
	TickManager:Add("Killsteal", "Killsteal", 500, function() OnKillsteal(Config.Killstealing) end)
	TickManager:Add("UpdateTarget", "Update Current Target", 100, OnUpdateTarget)

end

function SetupDebugger()

	if (not EnableDebugMode) then
		return
	end

	Debugger = VisualDebugger()

	Debugger:Group("Spells", "Hero Spells")
	Debugger:Variable("Spells", Format("{1} (Q)", Spells[_Q].Name), function() return Spells[_Q]:IsReady() end)
	Debugger:Variable("Spells", Format("{1} (E)", Spells[_E].Name), function() return Spells[_E]:IsReady() end)
	Debugger:Variable("Spells", Format("{1} (R)", Spells[_R].Name), function() return Spells[_R]:IsReady() end)

	Debugger:Group("Misc", "Misc Variables")
	Debugger:Variable("Misc", "Current Target", function() return (CurrentTarget and CurrentTarget.charName or "No target") end)

end

function SetupConfig()

	Config:Menu("Orbwalker", "Settings: Orbwalker")
	Config:Menu("Selector", "Settings: Target Selector")
	Config:Menu("Combo", "Settings: Combo Mode")
	Config:Menu("Harass", "Settings: Harass Mode")
	Config:Menu("Killstealing", "Settings: Killstealing")
	Config:Menu("AntiGapcloser", "Settings: Anti-Gapcloser")
	Config:Menu("Interrupter", "Settings: Auto-Interrupter")
	Config:Menu("Drawing", "Settings: Drawing")
	Config:Menu("TickManager", "Settings: Tick Manager")
	Config:Separator()
	Config:Info("Version", ScriptVersion)
	Config:Info("Build Date", ScriptDate)
	Config:Info("Author", "Devn")

	SxOrb:LoadToMenu(Config.Orbwalker)
	Selector:LoadToMenu(Config.Selector)
	SetupConfig_Combo(Config.Combo)
	SetupConfig_Harass(Config.Harass)
	SetupConfig_Killstealing(Config.Killstealing)
	SetupConfig_AntiGapcloser(Config.AntiGapcloser)
	SetupConfig_Interrupter(Config.Interrupter)
	SetupConfig_Drawing(Config.Drawing)
	TickManager:LoadToMenu(Config.TickManager)

	if (EnableDebugMode) then
		Config:Menu("Debugger", "Settings: Visual Debugger")
		Debugger:LoadToMenu(Config.Debugger)
	end

end

---//==================================================\\---
--|| > Config Setup										||--
---\===================================================//---

function SetupConfig_Combo(config)

	config:KeyBinding("Active", "Combo Mode Active", false, 32)
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Separator()
	config:Toggle("UseE", Format("Use {1} (E)", Spells[_E].Name), true)
	config:Slider("MinManaE", "Minimum Mana Percent", 0, 0, 100)

end

function SetupConfig_Harass(config)

	config:KeyBinding("Active", "Harass Mode Active", false, "T")
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Separator()
	config:Toggle("UseE", Format("Use {1} (E)", Spells[_E].Name), true)
	config:Slider("MinManaE", "Minimum Mana Percent", 35, 0, 100)

end

function SetupConfig_Killstealing(config)

	config:Toggle("Enable", "Enable Killstealing", true)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)

end

function SetupConfig_AntiGapcloser(config)

	AntiGapcloser:LoadToMenu(config)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)

end

function SetupConfig_Interrupter(config)

	Interrupter:LoadToMenu(config)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)
	config:Slider("MinDangerLevelR", "Minimum Danger Level", 4, 1, 5)

end

function SetupConfig_Drawing(config)

	DrawManager:LoadToMenu(config)
	config:Separator()
	config:Toggle("AA", "Draw Auto-Attack Range", true)
	config:DropDown("AAColor", "Range Color", 1, DrawManager.Colors)

end

---//==================================================\\---
--|| > Main Callback Handlers							||--
---\===================================================//---

function OnComboMode(config)

	if (myHero.dead or not config.Active or not IsValid(CurrentTarget, SxOrb:GetMyRange())) then
		return
	end

	if (Spells[_E]:IsReady() and config.UseE and HaveEnoughMana(config.MinManaE)) then
		Spells[_E]:Cast(CurrentTarget)
	end

	if (Spells[_Q]:IsReady() and config.UseQ) then
		Spells[_Q]:Cast()
	end

end

function OnHarassMode(config)

	if (myHero.dead or not config.Active or not IsValid(CurrentTarget, SxOrb:GetMyRange())) then
		return
	end

	if (Spells[_E]:IsReady() and config.UseE and HaveEnoughMana(config.MinManaE)) then
		Spells[_E]:Cast(CurrentTarget)
	end

	if (Spells[_Q]:IsReady() and config.UseQ) then
		Spells[_Q]:Cast()
	end

end

function OnKillsteal(config)

	if (not config.Enable or not config.UseR or not Spells[_R]:IsReady()) then
		return
	end

	for _, enemy in ipairs(GetEnemiesInRange(Spells[_R]:GetRange())) do
		if (IsValid(enemy) and Spells[_R]:WillKill(enemy)) then
			Spells[_R]:Cast(enemy)
		end
	end

end

function OnDrawRanges(config)

	if (config.AA) then
		DrawManager:DrawCircleAt(myHero, SxOrb:GetMyRange(), config.AAColor)
	end

end

---//==================================================\\---
--|| > Misc Callback Handlers							||--
---\===================================================//---

function OnUpdateTarget()

	CurrentTarget = Selector:GetTarget(SxOrb:GetMyRange())

end
