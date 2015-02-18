--[[
---//==================================================\\---
--|| > About Script										||--
---\===================================================//---
	Script:			Corki - The God Bombardier
	Version:		1.00
	Script Date:	2015-02-02
	Author:			Devn
---//==================================================\\---
--|| > Changelog										||--
---\===================================================//---
	Version 1.00:
		- Initial script release.
--]]

--[[ Temporary Anti-AFK (Please remove before release)
function OnTick()
	if (not _ANTI_AFK or (_ANTI_AFK <= GetGameTimer())) then
		_ANTI_AFK = GetGameTimer() + 40
		local position = myHero + (Vector(mousePos) - myHero):normalized() * 250
		myHero:MoveTo(position.x, position.z)
	end
end
--]]

---//==================================================\\---
--|| > User Variables									||--
---\===================================================//---

_G.CorkiGod_AutoUpdate		= true
_G.CorkiGod_EnableDebugMode	= true

---//==================================================\\---
--|| > Initialization									||--
---\===================================================//---

-- Champion check.
if (myHero.charName ~= "Corki") then return end

-- Load GodLib.
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQcLAAAABgBAAEFAAAAWQAAAQYAAAKUAAADlQAAAJYEAAGXBAACAAYACnUGAAB8AgAADAAAABAkAAABMSUJfUEFUSAAECwAAAEdvZExpYi5sdWEABEsAAABodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vRGV2bkJvTC9TY3JpcHRzL21hc3Rlci9Hb2RMaWIvR29kTGliLmx1YQAEAAAAAwAAAAMAAAABAAUMAAAARgBAAEdAwACAAAAAwYAAAF2AgAGMwMAAAQEBAJ2AgAHMQMEA3UAAAZ8AAAEfAIAABgAAAAQDAAAAaW8ABAUAAABvcGVuAAQCAAAAcgAEBQAAAHJlYWQABAUAAAAqYWxsAAQGAAAAY2xvc2UAAAAAAAEAAAAAABAAAABAb2JmdXNjYXRlZC5sdWEADAAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAY2IAAAAAAAwAAAADAAAAZGIABQAAAAwAAAADAAAAX2MACAAAAAwAAAABAAAABQAAAF9FTlYAAwAAAAQAAAABAAYKAAAAQAAAAIEAAADGQEAAx4DAAQHBAABBAQEA3YCAAVbAgABfAAABHwCAAAUAAAAEBwAAAD9yYW5kPQAEBQAAAG1hdGgABAcAAAByYW5kb20AAwAAAAAAAPA/AwAAAAAAiMNAAAAAAAEAAAAAABAAAABAb2JmdXNjYXRlZC5sdWEACgAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAABAAAAAwAAAGNiAAAAAAAKAAAAAQAAAAUAAABfRU5WAAQAAAAGAAAAAQAFBwAAAEYAQACBQAAAwAAAAAGBAACWAAEBXUAAAR8AgAADAAAABAoAAABQcmludENoYXQABDwAAAA8Zm9udCBjb2xvcj0iI2Y3ODFiZSI+R29kTGliOjwvZm9udD4gPGZvbnQgY29sb3I9IiNiZWY3ODEiPgAECAAAADwvZm9udD4AAAAAAAEAAAAAABAAAABAb2JmdXNjYXRlZC5sdWEABwAAAAUAAAAFAAAABQAAAAYAAAAFAAAABQAAAAYAAAABAAAAAwAAAGNiAAAAAAAHAAAAAQAAAAUAAABfRU5WAAcAAAAMAAAAAAAGHAAAAAYAQABFAIAAHYAAARsAAAAXwAKABkBAAEaAQACFAAABxQCAAJ2AAAHEAAAAAcEAAEUBAABdAIACHYAAAB1AgAAXQAKABQCAAUEAAQAdQAABBkBBAEUAAAKFAIACXYAAAYUAgADlAAAAHUAAAh8AgAAGAAAABAoAAABGaWxlRXhpc3QABAcAAABhc3NlcnQABAUAAABsb2FkAAQCAAAAdAAEHAAAAERvd25sb2FkaW5nLCBwbGVhc2Ugd2FpdC4uLgAEDQAAAERvd25sb2FkRmlsZQABAAAACwAAAAwAAAAAAAIEAAAABQAAAEEAAAAdQAABHwCAAAEAAAAEOwAAAERvd25sb2FkZWQgc3VjY2Vzc2Z1bGx5ISBQbGVhc2UgcmVsb2FkIHNjcmlwdCAoZG91YmxlIEY5KS4AAAAAAAEAAAAAAxAAAABAb2JmdXNjYXRlZC5sdWEABAAAAAwAAAAMAAAADAAAAAwAAAAAAAAAAQAAAAMAAABhYgAGAAAAAAABAAECAQQBAwEBEAAAAEBvYmZ1c2NhdGVkLmx1YQAcAAAACAAAAAgAAAAIAAAACAAAAAgAAAAIAAAACAAAAAgAAAAIAAAACAAAAAkAAAAJAAAACQAAAAgAAAAIAAAACAAAAAkAAAAKAAAACgAAAAoAAAALAAAACwAAAAsAAAALAAAACwAAAAwAAAALAAAADAAAAAAAAAAGAAAABQAAAF9FTlYAAwAAAGJhAAMAAABkYQADAAAAYWIAAwAAAF9iAAMAAABjYQABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAsAAAABAAAAAQAAAAEAAAACAAAAAwAAAAQAAAAGAAAADAAAAAwAAAAMAAAADAAAAAYAAAADAAAAYmEAAwAAAAsAAAADAAAAY2EABAAAAAsAAAADAAAAZGEABQAAAAsAAAADAAAAX2IABgAAAAsAAAADAAAAYWIABwAAAAsAAAADAAAAYmIACAAAAAsAAAABAAAABQAAAF9FTlYA"), nil, "bt", _ENV))()
if (not GodLib) then return end

-- Update variables.
GodLib.Update.Host				= "raw.github.com"
GodLib.Update.Path				= "DevnBoL/Scripts/master/Corki"
GodLib.Update.Version			= "Current.version"
GodLib.Update.Script			= "Corki - The God Bombardier.lua"

-- Script variables.
GodLib.Script.Variables			= "CorkiGod"
GodLib.Script.Name 				= "Corki - The God Bombardier"
GodLib.Script.Version			= "1.00"
GodLib.Script.Date				= "2015-02-02"

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

Callbacks:Bind("GainBuff", function(unit, buff)

	if (unit and unit.isMe and buff and buff.name:Equals("mbcheck2")) then
		IsBigMissile = true
	end

end)

Callbacks:Bind("LoseBuff", function(unit, buff)

	if (unit and unit.isMe and buff and buff.name:Equals("mbcheck2")) then
		IsBigMissile = false
	end

end)

---//==================================================\\---
--|| > Script Setup										||--
---\===================================================//---

function SetupVariables()

	Spells			= {
		[_Q]		= SpellData(_Q, 825, "Phosphorus Bomb"),
		[_E]		= SpellData(_E, 650, "Gatling Gun"),
		[_R]		= SpellData(_R, 1225, "Missile Barrage"),
		["R2"]		= SpellData(_R, 1225),
	}

	CurrentTarget	= nil
	IsBigMissile	= false

	Config			= MenuConfig("CorkiGod", ScriptName)
	Selector		= SimpleTS(STS_LESS_CAST)

	Spells[_Q]:SetSkillshot(SKILLSHOT_CIRCULAR, 250, 0.35, 1500, false):SetAOE(true)
	Spells[_R]:SetSkillshot(SKILLSHOT_LINEAR, 40, 0.165, 2000, true):SetAOE(true)
	Spells["R2"]:SetSkillshot(SKILLSHOT_LINEAR, 60, 0.165, 2000, true):SetAOE(true)

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
	Debugger:Variable("Misc", "Is Big Missile", function() return IsBigMissile end)
	Debugger:Variable("Misc", "Is Attacking", function() return Player.IsAttacking end)
	Debugger:Variable("Misc", "Is Evading", function() return IsEvading() end)

end

function SetupConfig()

	Config:Menu("Orbwalker", "Settings: Orbwalker")
	Config:Menu("Selector", "Settings: Target Selector")
	Config:Menu("Combo", "Settings: Combo Mode")
	Config:Menu("Harass", "Settings: Harass Mode")
	Config:Menu("Killstealing", "Settings: Killstealing")
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
	config:Toggle("UseE", Format("Use {1} (E)", Spells[_E].Name), true)
	config:Slider("MinManaE", "Minimum Mana Percent", 0, 0, 100)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)
	config:Slider("MinManaR", "Minimum Mana Percent", 0, 0, 100)

end

function SetupConfig_Harass(config)

	config:KeyBinding("Active", "Harass Mode Active", false, "T")
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Slider("MinManaQ", "Minimum Mana Percent", 35, 0, 100)
	config:Separator()
	config:Toggle("UseE", Format("Use {1} (E)", Spells[_E].Name), false)
	config:Slider("MinManaE", "Minimum Mana Percent", 75, 0, 100)
	config:Separator()
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)
	config:Slider("MinManaR", "Minimum Mana Percent", 50, 0, 100)

end

function SetupConfig_Killstealing(config)

	config:Toggle("Enable", "Enable Killstealing", true)
	config:Separator()
	config:Toggle("UseQ", Format("Use {1} (Q)", Spells[_Q].Name), true)
	config:Toggle("UseR", Format("Use {1} (R)", Spells[_R].Name), true)

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
	config:Toggle("E", Format("Draw {1} (E)", Spells[_E].Name), true)
	config:DropDown("EColor", "Range Color", 1, DrawManager.Colors)
	config:Separator()
	config:Toggle("R", Format("Draw {1} (R)", Spells[_R].Name), true)
	config:DropDown("RColor", "Range Color", 1, DrawManager.Colors)

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

	if (Spells[_R]:IsReady() and config.UseR and HaveEnoughMana(config.MinManaR) and Spells[_R]:InRange(CurrentTarget)) then
		if (IsBigMissile) then
			Spells["R2"]:Cast(CurrentTarget)
		else
			Spells[_R]:Cast(CurrentTarget)
		end
	end

	if (Spells[_E]:IsReady() and config.UseE and HaveEnoughMana(config.MinManaE) and Spells[_E]:InRange(CurrentTarget) and IsFacing(myHero, CurrentTarget)) then
		Spells[_E]:CastAt(CurrentTarget)
	end

end

function OnHarassMode(config)

	if (myHero.dead or IsEvading() or Player.IsAttacking or not config.Active or not IsValid(CurrentTarget)) then
		return
	end

	if (Spells[_Q]:IsReady() and config.UseQ and HaveEnoughMana(config.MinManaQ) and Spells[_Q]:InRange(CurrentTarget)) then
		Spells[_Q]:Cast(CurrentTarget)
	end

	if (Spells[_R]:IsReady() and config.UseR and HaveEnoughMana(config.MinManaR) and Spells[_R]:InRange(CurrentTarget)) then
		if (IsBigMissile) then
			Spells["R2"]:Cast(CurrentTarget)
		else
			Spells[_R]:Cast(CurrentTarget)
		end
	end

	if (Spells[_E]:IsReady() and config.UseE and HaveEnoughMana(config.MinManaE) and IsFacing(myHero, CurrentTarget, Spells[_E].Range)) then
		Spells[_E]:Cast()
	end

end

function OnKillsteal(config)

	if (not config.Enable) then
		return
	end

	for _, enemy in ipairs(GetEnemyHeroes()) do
		if (IsValid(enemy, Spells[_R].Range)) then
			if (Spells[_Q]:IsReady() and config.UseQ and Spells[_Q]:InRange(enemy) and Spells[_Q]:WillKill(enemy)) then
				Spells[_Q]:Cast(enemy)
			elseif (Spells[_R]:IsReady() and config.UseR and Spells[_R]:InRange(CurrentTarget) and Spells[_R]:WillKill(enemy)) then
				if (IsBigMissile) then
					Spells["R2"]:Cast(enemy)
				else
					Spells[_R]:Cast(enemy)
				end
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

	if (config.E) then
		DrawManager:DrawCircleAt(myHero, Spells[_E].Range, config.EColor)
	end

	if (config.R) then
		DrawManager:DrawCircleAt(myHero, Spells[_R].Range, config.RColor)
	end

end

---//==================================================\\---
--|| > Misc Callback Handlers							||--
---\===================================================//---

function OnUpdateTarget()

	CurrentTarget = Selector:GetTarget(Spells[_R].Range)

end
