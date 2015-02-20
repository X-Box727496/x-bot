--[[
---//==================================================\\---
--|| > About Script										||--
---\===================================================//---
	Script:			Ezreal - The Prodigal God
	Version:		1.01
	Script Date:	2015-02-04
	Author:			Devn
---//==================================================\\---
--|| > Changelog										||--
---\===================================================//---
	Version 1.00:
		- Initial script release.

	Version 1.01:
		- Added minimum target range for R killstealing.
--]]

---//==================================================\\---
--|| > User Variables									||--
---\===================================================//---

_G.EzrealGod_AutoUpdate			= true
_G.EzrealGod_EnableDebugMode	= true

---//==================================================\\---
--|| > Initialization									||--
---\===================================================//---

-- Champion check.
if (not myHero.charName == "Ezreal") then return end

-- Load GodLib.
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
if (not GodLib) then return end

-- Update variables.
GodLib.Update.Host				= "raw.github.com"
GodLib.Update.Path				= "DevnBoL/Scripts/master/Ezreal"
GodLib.Update.Version			= "Current.version"
GodLib.Update.Script			= "Ezreal - The Prodigal God.lua"

-- Script variables.
GodLib.Script.Variables			= "EzrealGod"
GodLib.Script.Name 				= "Ezreal - The Prodigal God"
GodLib.Script.Version			= "1.01"
GodLib.Script.Date				= "2015-02-04"

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

	if (ValidTarget(unit) and Config.AntiGapcloser.UseE and Spells[_E]:IsReady()) then
		local position = myHero + (Vector(mousePos) - myHero):normalized() * Spells[_E].Range
		Spells[_E]:CastAt(position)
	end

end)

---//==================================================\\---
--|| > Script Setup										||--
---\===================================================//---

function SetupVariables()

	Spells			= {
		[_Q]		= SpellData(_Q, 1150, "Mystic Shot"),
		[_W]		= SpellData(_W, 1000, "Essence Flux"),
		[_E]		= SpellData(_E, 475, "Arcane Shift"),
		[_R]		= SpellData(_R, math.huge, "Trueshot Barrage"),
	}

	CurrentTarget	= nil

	Config			= MenuConfig("EzrealGod", ScriptName)
	Selector		= SimpleTS(STS_LESS_CAST)
	AntiGapcloser	= AntiGapcloser()

	Spells[_Q]:SetSkillshot(SKILLSHOT_LINEAR, 60, 0.25, 2000, true)
	Spells[_W]:SetSkillshot(SKILLSHOT_LINEAR, 80, 0.25, 1600, true):SetAOE(true)
	Spells[_R]:SetSkillshot(SKILLSHOT_LINEAR, 160, 1, 2000, true):SetAOE(true)

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
	Debugger:Variable("Spells", Format("{1} (W)", Spells[_E].Name), function() return Spells[_W]:IsReady() end)
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
	config:Slider("MinManaQ", "Minimum Mana Percent", 0, 0, 100)
	config:Separator()
	config:Toggle("UseW", Format("Use {1} (W)", Spells[_W].Name), true)
	config:Slider("MinManaW", "Minimum Mana Percent", 0, 0, 100)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)
	config:Slider("MinEnemiesR", "Minimum Enemies to Hit", 2, 1, 5)

end

function SetupConfig_Harass(config)

	config:KeyBinding("Active", "Harass Mode Active", false, "T")
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Slider("MinManaQ", "Minimum Mana Percent", 35, 0, 100)
	config:Separator()
	config:Toggle("UseW", Format("Use {1} (W)", Spells[_W].Name), true)
	config:Slider("MinManaW", "Minimum Mana Percent", 75, 0, 100)

end

function SetupConfig_Killstealing(config)

	config:Toggle("Enable", "Enable Killstealing", true)
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Toggle("UseW", Format("Use {1} (W)", Spells[_W].Name), true)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)
	config:Slider("MinRangeR", "Minimum Range to Cast", 500, 0, 2000)
	config:Slider("MaxRangeR", "Maximum Range to Cast", 1500, 0, 2000)

end

function SetupConfig_AntiGapcloser(config)

	AntiGapcloser:LoadToMenu(config)
	config:Separator()
	config:Toggle("UseE", Format("Use {1} (E)", Spells[_E].Name), true)

end

function SetupConfig_Drawing(config)

	DrawManager:LoadToMenu(config)
	config:Separator()
	config:Toggle("AA", "Draw Auto-Attack Range", true)
	config:DropDown("AAColor", "Range Color", 1, DrawManager.Colors)
	config:Separator()
	config:Toggle("Q", Format("Draw {1} (Q)", Spells[_Q].Name), true)
	config:DropDown("QColor", "Range Color", 1, DrawManager.Colors)
	config:Separator()
	config:Toggle("W", Format("Draw {1} (W)", Spells[_W].Name), true)
	config:DropDown("WColor", "Range Color", 1, DrawManager.Colors)
	config:Separator()
	config:Toggle("E", Format("Draw {1} (E)", Spells[_E].Name), true)
	config:DropDown("EColor", "Range Color", 1, DrawManager.Colors)

end

---//==================================================\\---
--|| > Main Callback Handlers							||--
---\===================================================//---

function OnComboMode(config)

	if (myHero.dead or IsEvading() or Player.IsAttacking or not config.Active or not IsValid(CurrentTarget)) then
		return
	end

	if (Spells[_Q]:IsReady() and config.UseQ and HaveEnoughMana(config.MinManaQ) and Spells[_Q]:InRange(CurrentTarget)) then
		Spells[_Q]:Cast(CurrentTarget)
	end

	if (Spells[_W]:IsReady() and config.UseW and HaveEnoughMana(config.MinManaW) and Spells[_W]:InRange(CurrentTarget)) then
		Spells[_W]:Cast(CurrentTarget)
	end

	if (Spells[_R]:IsReady() and config.UseR) then
		Spells[_R]:SetAOE(true, nil, config.MinEnemiesR)
		Spells[_R]:Cast(CurrentTarget)
		Spells[_R]:SetAOE(true)
	end

end

function OnHarassMode(config)

	if (myHero.dead or IsEvading() or Player.IsAttacking or not config.Active or not IsValid(CurrentTarget)) then
		return
	end

	if (Spells[_Q]:IsReady() and config.UseQ and HaveEnoughMana(config.MinManaQ) and Spells[_Q]:InRange(CurrentTarget)) then
		Spells[_Q]:Cast(CurrentTarget)
	end

	if (Spells[_W]:IsReady() and config.UseW and HaveEnoughMana(config.MinManaW) and Spells[_W]:InRange(CurrentTarget)) then
		Spells[_W]:Cast(CurrentTarget)
	end

end

function OnKillsteal(config)

	if (not config.Enable) then
		return
	end

	for _, enemy in ipairs(GetEnemyHeroes()) do
		if (IsValid(enemy)) then
			if (Spells[_Q]:IsReady() and config.UseQ and Spells[_Q]:InRange(enemy) and Spells[_Q]:WillKill(enemy)) then
				Spells[_Q]:Cast(enemy)
			elseif (Spells[_W]:IsReady() and config.UseW and Spells[_W]:InRange(enemy) and Spells[_W]:WillKill(enemy)) then
				Spells[_W]:Cast(enemy)
			elseif (Spells[_R]:IsReady() and config.UseR and not InRange(enemy, config.MinRangeR) and InRange(enemy, config.MaxRangeR) and Spells[_R]:WillKill(enemy)) then
				Spells[_R]:Cast(enemy)
			end
		end
	end

end

function OnDrawRanges(config)

	if (config.AA) then
		DrawManager:DrawCircleAt(myHero, SxOrb:GetMyRange(), config.AAColor)
	end

	if (config.Q) then
		DrawManager:DrawCircleAt(myHero, Spells[_Q].Range, config.QColor)
	end

	if (config.W) then
		DrawManager:DrawCircleAt(myHero, Spells[_W].Range, config.WColor)
	end

	if (config.E) then
		DrawManager:DrawCircleAt(myHero, Spells[_E].Range, config.EColor)
	end

end

---//==================================================\\---
--|| > Misc Callback Handlers							||--
---\===================================================//---

function OnUpdateTarget()

	CurrentTarget = Selector:GetTarget(Spells[_Q].Range)

end
