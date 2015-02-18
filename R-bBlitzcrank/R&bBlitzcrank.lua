--[[
---//==================================================\\---
--|| > About Script										||--
---\===================================================//---
	Script:			Blitzcrank - The Great Golem God
	Version:		1.03
	Script Date:	2015-02-16
	Author:			Devn
---//==================================================\\---
--|| > Changelog										||--
---\===================================================//---
	Version 1.00:
		- Initial script release.

	Version 1.01:
		- Fixed Q skillshot for collision.

	Version 1.02:
		- Fixed Q skillshot width.

	Version 1.03:
		- Added auto-leveler.
		- Added support to disable SxOrbWalk completely.
--]]

---//==================================================\\---
--|| > User Variables									||--
---\===================================================//---

_G.BlitzcrankGod_AutoUpdate			= true
_G.BlitzcrankGod_DisableSxOrbWalk	= true
_G.BlitzcrankGod_EnableDebugMode	= false

---//==================================================\\---
--|| > Initialization									||--
---\===================================================//---

-- Champion check.
if (myHero.charName ~= "Blitzcrank") then return end

-- Update variables.
GodLib.Update.Host			= "raw.github.com"
GodLib.Update.Path			= "DevnBoL/Scripts/master/Blitzcrank"
GodLib.Update.Version		= "Current.version"
GodLib.Update.Script		= "Blitzcrank - The Great Golem God.lua"

-- Script variables.
GodLib.Script.Variables		= "BlitzcrankGod"
GodLib.Script.Name 			= "R&B-Blitzcrank"
GodLib.Script.Version		= "1.00"
GodLib.Script.Date			= "2015-02-16"
GodLib.Script.SafeVersion	= "5.3"

-- Required libraries.
GodLib.RequiredLibraries	= {
	["SxOrbWalk"]			= "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua",
}

---//==================================================\\---
--|| > Callback Handlers								||--
---\===================================================//---

Callbacks:Bind("Initialize", function()

	SetupVariables()
	SetupDebugger()
	SetupConfig()

	ScriptManager:GetAsyncWebResult(GodLib.Update.Host, Format("/{1}/{2}", GodLib.Update.Path, "Message.txt"), function(message)
		PrintLocal(message)
	end)

	PrintLocal(Format("Script v{1} loaded successfully!", ScriptVersion))

end)

Callbacks:Bind("Draw", function()

	if (not myHero.dead) then
		OnDrawRanges(Config.Drawing)
	end

end)

Callbacks:Bind("InterruptableSpell", function(unit, data)

	if (ValidTarget(unit)) then
		if (Spells[_E]:IsReady() and Config.Interrupter.UseE and Player:CanAttack() and InRange(unit, Player:GetRange())) then
			Spells[_E]:Cast()
			myHero:Attack(unit)
		elseif (Spells[_Q]:IsReady() and Config.Interrupter.UseQ and Spells[_Q]:InRange(unit) and (data.DangerLevel >= Config.Interrupter.MinDangerLevelQ)) then
			Spells[_Q]:Cast(unit)
		elseif (Spells[_R]:IsReady() and Config.Interrupter.UseR and Spells[_R]:InRange(unit) and (data.DangerLevel >= Config.Interrupter.MinDangerLevelR)) then
			Spells[_R]:Cast()
		end
	end

end)

Callbacks:Bind("AfterAttack", function(target)

	if (ValidTarget(target) and Spells[_E]:IsReady()) then
		local isGrabTarget = (CurrentTarget == target)
		if (Config.Combo.E.Use > 1) then
			if (HaveEnoughMana(Config.Combo.E.MinMana) and ((Config.Combo.E.Use == 3) or isGrabTarget)) then
				Spells[_E]:Cast()
				myHero:Attack(target)
			end
		elseif (Config.Harass.E.Use > 1) then
			if (HaveEnoughMana(Config.Harass.E.MinMana) and ((Config.Harass.E.Use == 3) or isGrabTarget)) then
				Spells[_E]:Cast()
				myHero:Attack(target)
			end
		end
	end

end)

---//==================================================\\---
--|| > Script Setup										||--
---\===================================================//---

function SetupVariables()

	Spells			= {
		[_Q]		= SpellData(_Q, 900, "Rocket Grab"),
		[_W]		= SpellData(_W, nil, "Overdrive"),
		[_E]		= SpellData(_E, nil, "Power Fist"),
		[_R]		= SpellData(_R, 600, "Static Field"),
	}

	CurrentTarget	= nil

	Config			= MenuConfig(VariableName, ScriptName)
	Selector		= SimpleTS(STS_LESS_CAST_PHYSICAL)
	Interrupter		= Interrupter()
	AutoLeveler		= AutoLevelManager()

	Spells[_Q]:SetSkillshot(SKILLSHOT_LINEAR, 80, 0.25, 1800, true)

	AutoLeveler:AddStartSequence("Q > E > W", { _Q, _E, _W }, true)

	AutoLeveler:AddEndSequence("Q > E > W", { _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W }, true)
	AutoLeveler:AddEndSequence("Q > W > E", { _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E })
	AutoLeveler:AddEndSequence("E > Q > W", { _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W })

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
	Debugger:Variable("Spells", Format("{1} (W)", Spells[_W].Name), function() return Spells[_W]:IsReady() end)
	Debugger:Variable("Spells", Format("{1} (E)", Spells[_E].Name), function() return Spells[_E]:IsReady() end)
	Debugger:Variable("Spells", Format("{1} (R)", Spells[_R].Name), function() return Spells[_R]:IsReady() end)

	Debugger:Group("Misc", "Misc Variables")
	Debugger:Variable("Misc", "Current Target", function() return (CurrentTarget and CurrentTarget.charName or "No target") end)
	Debugger:Variable("Misc", "Is Attacking", function() return Player.IsAttacking end)
	Debugger:Variable("Misc", "Is Evading", function() return IsEvading() end)
	Debugger:Variable("Misc", "Is Recalling", function() return Player.IsRecalling end)

end

function SetupConfig()

	if (SxOrb) then
		Config:Menu("OrbWalker", "Settings: Orb-Walker")
		SxOrb:LoadToMenu(Config.OrbWalker)
	end

	Config:Menu("Selector", "Settings: Target Selector")
	Config:Menu("Combo", "Settings: Combo Mode")
	Config:Menu("Harass", "Settings: Harass Mode")
	Config:Menu("Killstealing", "Settings: Killstealing")
	Config:Menu("AutoLevel", "Settings: Skill Level Manager")
	Config:Menu("Interrupter", "Settings: Auto-Interrupter")
	Config:Menu("AntiGapcloser", "Settings: Anti-Gapcloser")
	Config:Menu("Drawing", "Settings: Drawing")
	Config:Menu("TickManager", "Settings: Tick Manager")
	Config:Separator()
	Config:Info("Version", ScriptVersion)
	Config:Info("Build Date", ScriptDate)
	Config:Info("Tested With", Format("LoL {1}", SafeVersion))
	Config:Info("Author", "Devn")

	Selector:LoadToMenu(Config.Selector)
	SetupConfig_Combo(Config.Combo)
	SetupConfig_Harass(Config.Harass)
	SetupConfig_Killstealing(Config.Killstealing)
	AutoLeveler:LoadToMenu(Config.AutoLevel)
	SetupConfig_Interrupter(Config.Interrupter)
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

	config:Menu("Q", Format("Spell: {1} (Q)", Spells[_Q].Name))
	config:Menu("W", Format("Spell: {1} (W)", Spells[_W].Name))
	config:Menu("E", Format("Spell: {1} (E)", Spells[_E].Name))
	config:Menu("R", Format("Spell: {1} (R)", Spells[_R].Name))

	config.Q:Toggle("Use", "Use Spell", true)
	config.Q:Separator()
	config.Q:Slider("MinMana", "Minimum Mana", 0, 0, 100)
	config.Q:Separator()
	config.Q:Slider("MinRange", "Minimum Distance to Grab", 250, 0, Spells[_Q].Range)
	config.Q:Slider("MaxRange", "Maximum Distance to Grab", Spells[_Q].Range, 0, Spells[_Q].Range)
	config.Q:Separator()
	for _, enemy in ipairs(GetEnemyHeroes()) do
		config.Q:Toggle(Format("Ignore{1}", enemy.charName), Format("Don't Grab {1}", enemy.charName), (PriorityManager:GetRecommendedPriority(enemy) < 3))
	end
	config.Q:Separator()
	config.Q:Slider("IgnoreRange", "Range to Check for Grabable", 1500, 0, 2000)
	config.Q:Toggle("IgnoreToggle", "Grab All if no Grabable Target", true)

	config.W:Toggle("Use", "Use Spell", true)
	config.W:Separator()
	config.W:Slider("MinMana", "Minimum Mana", 20, 0, 100)
	config.W:Separator()
	config.W:Slider("MinRange", "Minimum Range of Target", 0, 0, 1000)
	config.W:Slider("MaxRange", "Maximum Range of Target", 1000, Spells[_Q].Range, 2000)

	config.E:DropDown("Use", "Use Spell", 2, { "Disabled", "On Grab Target", "Always" })
	config.E:Separator()
	config.E:Slider("MinMana", "Minimum Mana", 0, 0, 100)

	config.R:Toggle("Use", "Use Spell", true)
	config.R:Separator()
	config.R:Slider("MinMana", "Minimum Mana", 0, 0, 100)
	config.R:Separator()
	config.R:Slider("MinEnemies", "Minimum Enemies to Hit", 2, 1, 5)

	config:Separator()
	config:KeyBinding("Active", "Combo Mode Active", false, 32)

end

function SetupConfig_Harass(config)

	config:Menu("Q", Format("Spell: {1} (Q)", Spells[_Q].Name))
	config:Menu("E", Format("Spell: {1} (E)", Spells[_E].Name))

	config.Q:Toggle("Use", "Use Spell", true)
	config.Q:Separator()
	config.Q:Slider("MinMana", "Minimum Mana", 0, 0, 100)
	config.Q:Separator()
	config.Q:Slider("MinRange", "Minimum Distance to Grab", 250, 0, Spells[_Q].Range)
	config.Q:Slider("MaxRange", "Maximum Distance to Grab", Spells[_Q].Range, 0, Spells[_Q].Range)
	config.Q:Separator()
	for _, enemy in ipairs(GetEnemyHeroes()) do
		config.Q:Toggle(Format("Ignore{1}", enemy.charName), Format("Don't Grab {1}", enemy.charName), (PriorityManager:GetRecommendedPriority(enemy) < 4))
	end
	config.Q:Separator()
	config.Q:Slider("IgnoreRange", "Range to Grab All Targets", 1500, 0, 2000)
	config.Q:Note("Only if no grab target within range.")

	config.E:DropDown("Use", "Use Spell", 2, { "Disabled", "On Grab Target", "Always" })
	config.E:Separator()
	config.E:Slider("MinMana", "Minimum Mana", 0, 0, 100)

	config:Separator()
	config:KeyBinding("Active", "Harass Mode Active", false, "T")

end

function SetupConfig_Killstealing(config)

	config:Toggle("Enable", "Enable Killstealing", true)
	config:Separator()
	config:Toggle("NoAllies", "Only if no Allies in Range", true)
	config:Slider("AllyRange", "Range to Search for Allies", 1000, 0, 2000)
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)

end

function SetupConfig_Interrupter(config)

	Interrupter:LoadToMenu(config)
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Slider("MinDangerLevelQ", "Minimum Danger Level", 1, 1, 5)
	config:Separator()
	config:Toggle("UseE", Format("Use {1} (E)", Spells[_E].Name), true)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)
	config:Slider("MinDangerLevelR", "Minimum Danger Level", 3, 1, 5)

end

function SetupConfig_Drawing(config)

	DrawManager:LoadToMenu(config)
	config:Separator()
	config:Toggle("PermaShow", "Show Perma Show Menu", true)
	config:DropDown("PermaShowColor", "Perma Show Color", DrawManager:GetColorIndex("Dark Green"), DrawManager.Colors)
	config:Separator()
	config:Toggle("AA", "Draw Auto-Attack Range", true)
	config:DropDown("AAColor", "Range Color", 1, DrawManager.Colors)
	config:Separator()
	config:Toggle("Q", Format("Draw {1} (Q)", Spells[_Q].Name), true)
	config:DropDown("QColor", "Range Color", 1, DrawManager.Colors)
	config:Separator()
	config:Toggle("R", Format("Draw {1} (R)", Spells[_R].Name), true)
	config:DropDown("RColor", "Range Color", 1, DrawManager.Colors)

end

---//==================================================\\---
--|| > Main Callback Handlers							||--
---\===================================================//---

function OnComboMode(config)

	if (myHero.dead or IsEvading() or Player.IsAttacking or not config.Active) then
		return
	end

	if (Spells[_Q]:IsReady() and config.Q.Use and HaveEnoughMana(config.Q.MinMana) and Spells[_Q]:IsValid(CurrentTarget)) then
		if (not InRange(CurrentTarget, config.Q.MinRange) and InRange(CurrentTarget, config.Q.MaxRange)) then
			if (config.Q[Format("Ignore{1}", CurrentTarget.hash)]) then
				if (config.Q.IgnoreToggle) then
					local target = Selector:GetTarget(config.Q.IgnoreRange)
					if (not target or (target == CurrentTarget)) then
						Spells[_Q]:Cast(CurrentTarget)
					end
				end
			else
				Spells[_Q]:Cast(CurrentTarget)
			end
		end
	end

	if (Spells[_E]:IsReady() and (config.E.Use > 1) and HaveEnoughMana(config.E.MinMana)) then
		if (CurrentTarget and UnitHasBuff(CurrentTarget, "RocketGrab")) then
			Spells[_E]:Cast()
			myHero:Attack(CurrentTarget)
		elseif (config.E.Use == 2) then
			local target = Selector:GetTarget(Player:GetRange())
			if (IsValid(target)) then
				Spells[_E]:Cast()
				myHero:Attack(target)
			end
		end
	end

	if (CurrentTarget and Spells[_W]:IsReady() and config.W.Use and HaveEnoughMana(config.W.MinMana) and not InRange(CurrentTarget, config.W.MinRange) and InRange(CurrentTarget, config.W.MaxRange)) then
		Spells[_W]:Cast()
	end

	if (Spells[_R]:IsReady() and config.R.Use and HaveEnoughMana(config.R.MinMana) and (#GetEnemiesInRange(Spells[_R].Range) >= config.R.MinEnemies)) then
		Spells[_R]:Cast()
	end

end

function OnHarassMode(config)

	if (myHero.dead or IsEvading() or Player.IsAttacking or not config.Active) then
		return
	end

	if (Spells[_Q]:IsReady() and config.Q.Use and HaveEnoughMana(config.Q.MinMana) and Spells[_Q]:IsValid(CurrentTarget)) then
		if (not InRange(CurrentTarget, config.Q.MinRange) and InRange(CurrentTarget, config.Q.MaxRange)) then
			if (config.Q[Format("Ignore{1}", CurrentTarget.hash)]) then
				if (config.Q.IgnoreToggle) then
					if (not Selector:GetTarget(config.Q.IgnoreRange)) then
						Spells[_Q]:Cast(CurrentTarget)
					end
				end
			else
				Spells[_Q]:Cast(CurrentTarget)
			end
		end
	end

	if (Spells[_E]:IsReady() and (config.E.Use > 1) and HaveEnoughMana(config.E.MinMana)) then
		if (CurrentTarget and UnitHasBuff(CurrentTarget, "RocketGrab")) then
			Spells[_E]:Cast()
			myHero:Attack(CurrentTarget)
		elseif (config.E.Use == 2) then
			local target = Selector:GetTarget(Player:GetRange())
			if (IsValid(target)) then
				Spells[_E]:Cast()
				myHero:Attack(target)
			end
		end
	end

end

function OnKillsteal(config)

	if (not config.Enable) then
		return
	end

	if (config.NoAllies and (#GetAlliesInRange(config.AllyRange) > 0)) then
		return
	end

	for _, enemy in ipairs(GetEnemyHeroes()) do
		if (IsValid(enemy, Spells[_Q].Range)) then
			if (Spells[_Q]:IsReady() and config.UseQ and Spells[_Q]:InRange(enemy) and Spells[_Q]:WillKill(enemy)) then
				Spells[_Q]:Cast(enemy)
			end
			if (Spells[_R]:IsReady() and config.UseR and Spells[_R]:InRange(enemy) and Spells[_R]:WillKill(enemy)) then
				Spells[_R]:Cast(enemy)
			end
		end
	end

end

---//==================================================\\---
--|| > Draw Callback Handlers							||--
---\===================================================//---

function OnDrawRanges(config)

	if (config.AA) then
		DrawManager:DrawCircleAt(myHero, Player:GetRange(), config.AAColor)
	end

	if (config.Q) then
		DrawManager:DrawCircleAt(myHero, Spells[_Q].Range, config.QColor)
	end

	if (config.R) then
		DrawManager:DrawCircleAt(myHero, Spells[_R].Range, config.RColor)
	end

end

---//==================================================\\---
--|| > Misc Callback Handlers							||--
---\===================================================//---

function OnUpdateTarget()

	CurrentTarget = Selector:GetTarget(Spells[_Q].Range)

	if (SxOrb) then
		SxOrb:ForceTarget(CurrentTarget)
	end

end
