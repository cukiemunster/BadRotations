local rotationName = "JR"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.mindFlay },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.mindFlay },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.mindFlay },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.shadowMend}
    };
    CreateButton("Rotation",1,0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.mindBlast },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.mindBlast },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.mindBlast }
    };
   	CreateButton("Cooldown",2,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.dispersion },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.dispersion }
    };
    CreateButton("Defensive",3,0)
    -- Void Form Button
    VoidFormModes = {
        [1] = { mode = "On", value = 1 , overlay = "Void Form Enabled", tip = "Bot will shift to Void Form.", highlight = 1, icon = br.player.spell.voidEruption },
        [2] = { mode = "Off", value = 2 , overlay = "Void Form Disabled", tip = "Bot will NOT shift to Void Form.", highlight = 0, icon = br.player.spell.voidEruption }
    };
    CreateButton("VoidForm",4,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
        -- General Options
        section = br.ui:createSection(br.ui.window.profile, "General")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
            -- Body and Soul
            br.ui:createCheckbox(section,"PWS: Body and Soul")
            -- Mouseover Dotting
            br.ui:createCheckbox(section,"Mouseover Dotting")
            -- Shadow Crash
            br.ui:createCheckbox(section,"Shadow Crash")
            -- SWP Max Targets
            br.ui:createSpinnerWithout(section, "SWP Max Targets",  3,  1,  10,  1, "|cffFFFFFFUnit Count Limit that SWP will be cast on.")
            -- VT Max Targets
            br.ui:createSpinnerWithout(section, "VT Max Targets",  3,  1,  10,  1, "|cffFFFFFFUnit Count Limit that VT will be cast on.")
            br.ui:createSpinnerWithout(section, "VT Dot HP Limit", 5, 0, 10, 1, "|cffFFFFFFHP Limit that VT will be cast/refreshed on.")
        br.ui:checkSectionState(section)
        -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
            -- Int Pot
            br.ui:createCheckbox(section,"Int Pot")
            -- Flask / Crystal
            br.ui:createCheckbox(section,"Flask / Crystal")
            -- Trinkets
            br.ui:createCheckbox(section,"Trinkets", "|cffFFFFFFUse trinkets on Cooldown. Overrides individual trinket usage below.")
            if hasEquiped(128318) then
                br.ui:createCheckbox(section,"Touch of the Void")
            end
            if hasEquiped(144259) then
                br.ui:createCheckbox(section,"KJ Burning Wish")
            end
            if hasEquiped(147017) then
                br.ui:createCheckbox(section,"Tarnished Sentinel Medallion")
            end
            if hasEquiped(139326) then
                br.ui:createCheckbox(section,"Wriggling Sinew")
            end
            if hasEquiped(140800) then
                br.ui:createCheckbox(section,"Pharameres Forbidden Grimoire")
            end
            if hasEquiped(142160) then
                br.ui:createCheckbox(section,"Mrrgias Favor")
            end
            if hasEquiped(137541) then
                br.ui:createCheckbox(section,"Moonlit Prism")
            	br.ui:createSpinnerWithout(section, "  Prism Stacks", 35, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            if hasEquiped(147019) then
                br.ui:createCheckbox(section,"Tome of Unravelling Sanity")
            	br.ui:createSpinnerWithout(section, "  Tome Stacks", 31, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            if hasEquiped(147002) then
                br.ui:createCheckbox(section,"Charm of the Rising Tide")
            	br.ui:createSpinnerWithout(section, "  Charm Stacks", 35, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            if hasEquiped(137433) then
                br.ui:createCheckbox(section,"Obelisk of the Void")
            	br.ui:createSpinnerWithout(section, "  Obelisk Stacks", 40, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            if hasEquiped(133642) then
                br.ui:createCheckbox(section,"Horn of Valor")
            	br.ui:createSpinnerWithout(section, "  Horn Stacks", 35, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            if hasEquiped(150522) then
                br.ui:createCheckbox(section,"Skull of Guldan")
            	br.ui:createSpinnerWithout(section, "  Skull Stacks", 35, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            if hasEquiped(137329) then
                br.ui:createCheckbox(section,"Figurehead of the Naglfar")
            	br.ui:createSpinnerWithout(section, "  Figurehead Stacks", 40, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            end
            -- Shadowfiend
            br.ui:createCheckbox(section,"Shadowfiend / Mindbender")
            br.ui:createSpinnerWithout(section, "  Shadowfiend Stacks", 0, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at. Set to 0 for auto.")
            -- Surrender To Madness
            br.ui:createCheckbox(section,"Surrender To Madness")
            -- Dispersion
            br.ui:createCheckbox(section, "Dispersion S2M")
            br.ui:createSpinnerWithout(section, "  Dispersion Stacks", 10, 5, 100, 5, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            -- Power Infusion
            br.ui:createCheckbox(section,"Power Infusion")
            br.ui:createSpinnerWithout(section, "  Power Infusion Stacks", 0, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at. Set to 0 for auto.")
            -- Void Torrent
            br.ui:createCheckbox(section,"Void Torrent")
            br.ui:createSpinnerWithout(section, "  Void Torrent Stacks", 0, 0, 100, 1, "|cffFFFFFFSet to desired Void Form stacks to use at.")
        br.ui:checkSectionState(section)
        -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            -- Healthstone
            br.ui:createSpinner(section, "Healthstone",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "Gift of the Naaru",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            end
            if br.player.race == "Dwarf" then
                br.ui:createSpinner(section, "Stoneform",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            end
            -- Dispel Magic
            br.ui:createCheckbox(section,"Dispel Magic")
            -- Dispersion
            br.ui:createSpinner(section, "Dispersion",  20,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Fade
            br.ui:createCheckbox(section, "Fade")
            -- Power Word: Shield
            br.ui:createSpinner(section, "Power Word: Shield",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Shadow Mend
            br.ui:createSpinner(section, "Shadow Mend",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Psychic Scream / Mind Bomb
            br.ui:createSpinner(section, "Psychic Scream / Mind Bomb",  40,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
        br.ui:checkSectionState(section)
        -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
            -- Silence
            br.ui:createCheckbox(section, "Silence")
            -- Psychic Scream / Mind Bomb
            br.ui:createCheckbox(section, "Psychic Scream / Mind Bomb - Int")
        br.ui:checkSectionState(section)
        -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
            -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
            -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
            -- Void Form
            br.ui:createDropdown(section, "Void Form Mode", br.dropOptions.Toggle,  6)
            -- Pause Toggle
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

----------------
--- ROTATION ---
----------------
local function runRotation()
    if br.timer:useTimer("debugShadow", 0.1) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("VoidEruption",0.25)
        UpdateToggle("VoidForm",0.25)
        br.player.mode.voidForm = br.data.settings[br.selectedSpec].toggles["VoidForm"]
--------------
--- Locals ---
--------------
        local addsExist                                     = false
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
        local castable                                      = br.player.cast.debug
        local castTable                                     = castTable or {}
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local enemiesWithDots                               = enemiesWithDots or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local gcdMax                                        = max(0.75, 1.5 / (1 + UnitSpellHaste("player") / 100))
        local hasMouse                                      = GetObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastCast                                      = lastCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local moveIn                                        = 999
        local moving                                        = (isMoving("player") and not br.player.buff.norgannonsForesight.exists() and not br.player.buff.surrenderToMadness.exists())
        -- local multidot                                      = (useCleave() or br.player.mode.rotation ~= 3)
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.insanity.amount, br.player.power.insanity.max, br.player.power.regen, br.player.power.insanity.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = #br.friend < 2
        local spell                                         = br.player.spell
        local t18_2pc                                       = TierScan("T18")>=2
        local t19_2pc                                       = TierScan("T19")>=2
        local t19_4pc                                       = TierScan("T19")>=4
        local t20_4pc                                       = TierScan("T20")>=4
        local talent                                        = br.player.talent
        local thp                                           = getHP(br.player.units(40))
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        local SWPmaxTargets                                 = getOptionValue("SWP Max Targets")
        local VTmaxTargets                                  = getOptionValue("VT Max Targets")
        local mindFlayChannel                               = 3 / (1 + GetHaste()/100)

        local ZeksExterminatis  = 236546

        local executeHP = 20
        if talent.reaperOfSouls then executeHP = 35 end

        units.dyn5 = br.player.units(5)
        units.dyn8 = br.player.units(8)
        units.dyn40 = br.player.units(40)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards40 = br.player.enemies(40)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end
        -- if HackEnabled("NoKnockback") ~= nil then HackEnabled("NoKnockback", false) end
        if t19_2pc then t19pc2 = 1 else t19pc2 = 0 end
        if t20_4pc then t20pc4 = 1 else t20pc4 = 0 end
        if t21_4pc then t21pc4 = 1 else t21pc4 = 0 end
        if hasBloodLust() then lusting = 1 else lusting = 0 end
        if talent.auspiciousSpirits then auspiciousSpirits = 1 else auspiciousSpirits = 0 end
        if talent.fortressOfTheMind then fortressOfTheMind = 1 else fortressOfTheMind = 0 end
        if talent.legacyOfTheVoid then legacyOfTheVoid = 1 else legacyOfTheVoid = 0 end
        if talent.lingeringInsanity then lingeringInsanity = 1 else lingeringInsanity = 0 end
        if talent.mindbender then mindbender = 1 else mindbender = 0 end
        if talent.reaperOfSouls then reaperOfSouls = 1 else reaperOfSouls = 0 end
        if talent.sanlayn then sanlayn = 1 else sanlayn = 0 end
        if artifact.lashOfInsanity then lash = 1 else lash = 0 end
        if artifact.toThePain then toThePain = 1 else toThePain = 0 end
        if artifact.massHysteria then massHysteria = 1 else massHysteria = 0 end
        if isBoss() then vtHPLimit = getOptionValue("VT Dot HP Limit")/10 else vtHPLimit = getOptionValue("VT Dot HP Limit") end
        if hasEquiped(132864) then mangaMad = 1 else mangaMad = 0 end
        if #enemies.yards40 == 1 then singleEnemy = 1 else singleEnemy = 0 end
        local raidMovementWithin15 = 0   -- trying to come up with a clever way to manage this, maybe a toggle or something. For now, just assume we always have to move soon

        local activeEnemies = #enemies.yards40
        if mode.rotation == 3 then
            activeEnemies = 1
            SWPmaxTargets = 1
            VTmaxTargets = 1
        end

        -- Insanity Stacks
        if buff.voidForm.stack() == 0 then drainStacks = 0 end
        if inCombat and buff.voidForm.stack() > 0 and not (buff.dispersion.exists() or buff.voidTorrent.exists()) then
            if br.timer:useTimer("drainStacker", 1) then
                drainStacks = drainStacks + 1
            end
        end

        -- Mind Flay Ticks
        --local mfTick
        if mfTick == nil or not inCombat or not isCastingSpell(spell.mindFlay) then mfTick = 0 end
        if br.timer:useTimer("Mind Flay Ticks", 0.75) and isCastingSpell(spell.mindFlay) then
            mfTick = mfTick + 1
        end

        -- Insanity Drain
        insanityDrain = 6 + (2 / 3 * (drainStacks)) 
        -- insanityDrain = 9 + ((drainStacks - 1) / 2)

        -- variable,name=cd_time,op=set,value=(10+(2-2*talent.mindbender.enabled*set_bonus.tier20_4pc)*set_bonus.tier19_2pc+(3-3*talent.mindbender.enabled*set_bonus.tier20_4pc)*equipped.mangazas_madness+(6+5*talent.mindbender.enabled)*set_bonus.tier20_4pc+2*artifact.lash_of_insanity.rank)
        local cd_time = (10 + (2 - 2 * mindbender * t20pc4) * t19pc2 + (3 - 3 * mindbender * t20pc4) * mangaMad + (6 + 5 * mindbender) * t20pc4 + 2 * lash)
        -- variable,name=dot_swp_dpgcd,op=set,value=38*1.2*(1+0.06*artifact.to_the_pain.rank)*(1+0.2+stat.mastery_rating%16000)*0.75
        local dot_swp_dpgcd = 38 * 1.2 * (1 + 0.06 * artifact.rank.toThePain) * (1 + 0.2 + GetMastery() % 16000) * 0.75
        -- variable,name=dot_vt_dpgcd,op=set,value=71*1.2*(1+0.2*talent.sanlayn.enabled)*(1+0.05*artifact.touch_of_darkness.rank)*(1+0.2+stat.mastery_rating%16000)*0.5
        local dot_vt_dpgcd = 71 * 1.2 * (1 + 0.2 * sanlayn) * (1 + 0.05 * artifact.rank.touchOfDarkness) * (1 + 0.2 + GetMastery() / 16000) * 0.5
        -- variable,name=sear_dpgcd,op=set,value=80*(1+0.05*artifact.void_corruption.rank)
        local sear_dpgcd = 80 * (1 + 0.05 * artifact.rank.voidCorruption)
        -- variable,name=s2msetup_time,op=set,value=(0.8*(83+(20+20*talent.fortress_of_the_mind.enabled)*set_bonus.tier20_4pc-(5*talent.sanlayn.enabled)+(30+42*(desired_targets>1)+10*talent.lingering_insanity.enabled)*set_bonus.tier21_4pc*talent.auspicious_spirits.enabled+((33-13*set_bonus.tier20_4pc)*talent.reaper_of_souls.enabled)+set_bonus.tier19_2pc*4+8*equipped.mangazas_madness+(raw_haste_pct*10*(1+0.7*set_bonus.tier20_4pc))*(2+(0.8*set_bonus.tier19_2pc)+(1*talent.reaper_of_souls.enabled)+(2*artifact.mass_hysteria.rank)-(1*talent.sanlayn.enabled)))),if=talent.surrender_to_madness.enabled
        if activeEnemies > 1 then multipleEnemies = 1 else multipleEnemies = 0 end
        local s2msetup_time = (0.8 * (83 + (20 + 20 * fortressOfTheMind) * t20pc4 - (5 * sanlayn) + (30 + 42 * multipleEnemies + 10 * lingeringInsanity) * t21pc4 * auspiciousSpirits + ((33 - 13 * t20pc4) * reaperOfSouls) + t19pc2 * 4 + 8 * mangaMad + (UnitSpellHaste("player") * 10 * (1 + 0.7 * t20pc4)) * (2 + (0.8 * t19pc2) + (1 * reaperOfSouls) + (2 * massHysteria) - (1 * sanlayn))))


        -- Void Bolt
        -- void_bolt
        if isValidUnit(units.dyn40) and inCombat and buff.voidForm.exists() and (cd.voidBolt == 0 or buff.void.exists()) and not isCastingSpell(spell.voidTorrent) then
            if cast.voidBolt(units.dyn40,"known") then return end
        end

        -- ChatOverlay(tostring(cd.voidBolt))

--------------------
--- Action Lists ---
--------------------
        -- Action list - Extras
        function actionList_Extra()
            -- Dispel Magic
            if isChecked("Dispel Magic") and canDispel("target",spell.dispelMagic) and not isBoss() and GetObjectExists("target") then
                if cast.dispelMagic() then return end
            end
        -- Dummy Test
            if isChecked("DPS Testing") then
                if GetObjectExists("target") then
                    if getCombatTime() >= (tonumber(getOptionValue("DPS Testing"))*60) and isDummy() then
                        StopAttack()
                        ClearTarget()
                        Print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
                        profileStop = true
                    end
                end
            end -- End Dummy Test
        end -- End Action List - Extra
        -- Action List - Defensive
        function actionList_Defensive()
            if useDefensive() and getHP("player")>0 then
                -- Gift of the Naaru
                if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and br.player.race=="Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
                -- Stoneform - Dwarf racial
                if isChecked("Stoneform") and php <= getOptionValue("Stoneform") and php > 0 and br.player.race=="Dwarf" then
                    if castSpell("player",racial,false,false,false) then return end
                end
                -- Dispersion
                if isChecked("Dispersion") and php <= getOptionValue("Dispersion") then
                    if cast.dispersion("player") then return end
                end
                -- Fade
                if isChecked("Fade") then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not solo and hasThreat(thisUnit) then
                            if cast.fade("player") then return end
                        end
                    end
                end
                -- Power Word: Shield
                if isChecked("Power Word: Shield") and php <= getOptionValue("Power Word: Shield") and not buff.powerWordShield.exists() then
                    if cast.powerWordShield("player") then return end
                end
                -- Shadow Mend
                if isChecked("Shadow Mend") and php <= getOptionValue("Shadow Mend") then
                    if cast.shadowMend("player") then return end
                end
                -- Psychic Scream / Mind Bomb
                if isChecked("Psychic Scream / Mind Bomb") and inCombat and php <= getOptionValue("Psychic Scream / Mind Bomb") then
                    if not talent.mindBomb and #enemies.yards8 > 0 then
                        if cast.psychicScream("player") then return end
                    else
                        if cast.mindBomb(units.dyn30) then return end
                    end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
        -- Action List - Interrupts
        function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("Interrupt At")) then
            -- Silence
                        if isChecked("Silence") then
                            if cast.silence(thisUnit) then return end
                        end
            -- Psychic Scream / Mind Bomb
                        if isChecked("Psychic Scream / Mind Bomb - Int") and not talent.mindBomb then
                            if not talent.mindBomb and #enemies.yards8 > 0 then
                                if cast.psychicScream("player") then return end
                            else
                                if cast.mindBomb(thisUnit) then return end
                            end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
        -- Action List - Cooldowns
        function actionList_Cooldowns()
            if useCDs() then
                -- Racials
                -- blood_fury
                -- arcane_torrent
                -- berserking
                if (br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if br.player.castRacial() then return end
                end
                -- Touch of the Void   
                if isChecked("Touch of the Void") and getDistance("target") <= 40 then
                    if hasEquiped(128318) then
                        if GetItemCooldown(128318)==0 then
                            useItem(128318)
                        end
                    end
                end
                -- KJ Burning Wish   
                if isChecked("KJ Burning Wish") and getDistance("target") <= 40 then
                    if hasEquiped(144259) then
                        if GetItemCooldown(144259)==0 then
                            useItem(144259)
                        end
                    end
                end
                -- Tarnished Sentinel Medallion   
                if isChecked("Tarnished Sentinel Medallion") and getDistance("target") <= 40 then
                    if hasEquiped(147017) then
                        if GetItemCooldown(147017)==0 then
                            useItem(147017)
                        end
                    end
                end
                -- Wriggling Sinew   
                if isChecked("Wriggling Sinew") and getDistance("target") <= 40 then
                    if hasEquiped(139326) then
                        if GetItemCooldown(139326)==0 then
                            useItem(139326)
                        end
                    end
                end
                -- Pharameres Forbidden Grimoire   
                if isChecked("Pharameres Forbidden Grimoire") and getDistance("target") <= 40 then
                    if hasEquiped(140800) then
                        if GetItemCooldown(140800)==0 then
                            useItem(140800)
                        end
                    end
                end
                -- Mrrgias Favor   
                if isChecked("Mrrgias Favor") and getDistance("target") <= 40 then
                    if hasEquiped(142160) then
                        if GetItemCooldown(142160)==0 then
                            useItem(142160)
                        end
                    end
                end
                -- Moonlit Prism
                if isChecked("Moonlit Prism")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Prism Stacks") then
                    if hasEquiped(137541) then
                        if GetItemCooldown(137541)==0 then
                            useItem(137541)
                        end
                    end
                end
                -- Tome of Unravelling Sanity
                if isChecked("Tome of Unravelling Sanity")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Tome Stacks") then
                    if hasEquiped(147019) then
                        if GetItemCooldown(147019)==0 then
                            useItem(147019)
                        end
                    end
                end
                -- Charm of the Rising Tide
                if isChecked("Charm of the Rising Tide")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Charm Stacks") then
                    if hasEquiped(147002) then
                        if GetItemCooldown(147002)==0 then
                            useItem(147002)
                        end
                    end
                end
                -- Obelisk of the Void
                if isChecked("Obelisk of the Void")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Obelisk Stacks") then
                    if hasEquiped(137433) then
                        if GetItemCooldown(137433)==0 then
                            useItem(137433)
                        end
                    end
                end
                -- Horn of Valor
                if isChecked("Horn of Valor")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Horn Stacks") then
                    if hasEquiped(133642) then
                        if GetItemCooldown(133642)==0 then
                            useItem(133642)
                        end
                    end
                end
                -- Skull of Guldan
                if isChecked("Skull of Guldan")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Skull Stacks") then
                    if hasEquiped(150522) then
                        if GetItemCooldown(150522)==0 then
                            useItem(150522)
                        end
                    end
                end
                -- Figurehead of the Naglfar
                if isChecked("Figurehead of the Naglfar")  and getDistance("target") <= 40 and buff.voidForm.stack() >= getOptionValue("  Figurehead Stacks") then
                    if hasEquiped(137329) then
                        if GetItemCooldown(137329)==0 then
                            useItem(137329)
                        end
                    end
                end
            -- Trinkets
                if isChecked("Trinkets") then
                    if canUse(11) then
                        useItem(11)
                    end
                    if canUse(12) then
                        useItem(12)
                    end
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
            -- Potion
                -- potion,name=prolonged_power,if=buff.bloodlust.react|target.time_to_die<=80|(target.health.pct<35&cooldown.power_infusion.remains<30)
                -- TODO
            end
        end -- End Action List - Cooldowns
        -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Shadow Form
            -- shadowform,if=!buff.shadowform.up
            if not buff.shadowform.exists() then
                cast.shadowform()
            end
            -- Mind Blast
            if isValidUnit("target") then
                if not moving and br.timer:useTimer("mbRecast", gcd) then
                    if cast.mindBlast("target") then return end
                -- else
                --     if cast.shadowWordPain("target") then return end
                end
            end
            -- Power Word: Shield Body and Soul
            if isChecked("PWS: Body and Soul") and talent.bodyAndSoul and isMoving("player") and not IsMounted() then
                if cast.powerWordShield("player") then return end
            end
        end  -- End Action List - Pre-Combat
        -- Action List - Check
        function actionList_Check()
            -- variable,op=set,name=actors_fight_time_mod,value=0
            actors_fight_time_mod = 0
            -- variable,op=set,name=actors_fight_time_mod,value=-((-(450)+(time+target.time_to_die))%10),if=time+target.time_to_die>450&time+target.time_to_die<600
            if combatTime + ttd(units.dyn40) > 450 and combatTime + ttd(units.dyn40) < 600 then
                actors_fight_time_mod = - (( - (450) + (combatTime + ttd(units.dyn40))) / 10)
            end
            -- variable,op=set,name=actors_fight_time_mod,value=((450-(time+target.time_to_die))%5),if=time+target.time_to_die<=450
            if combatTime + ttd(units.dyn40) <= 450 then
                actors_fight_time_mod = (450 - (combatTime + ttd(units.dyn40))) / 5
            end
            -- TODO - need to consider whether single-target rotation has an effect on s2mcheck time
            -- variable,op=set,name=s2mcheck,value=variable.s2msetup_time-(variable.actors_fight_time_mod*nonexecute_actors_pct)
            s2mcheck = s2msetup_time - (actors_fight_time_mod * getNonExecuteEnemiesPercent(executeHP))
            -- variable,op=min,name=s2mcheck,value=180
            if s2mCheck < 180 then s2mCheck = 180 end
        end

        function recentlyCast(u,s,t)
            local result = false
            if lastCastTrackerUnit == null or lastCastTrackerSpell == null then
                return false
            end
            if lastCastTrackerUnit == u and lastCastTrackerSpell == s and GetTime() - lastCastTrackerTime < t then
                return true                
            end
            return false
        end
        -- Action List - Main
        function actionList_Main()
        --Mouseover Dotting
            -- TODO: add VT mouseover dotting. Change checkbox in options to a dropdown = SW:P, Vamiric Touch, Both, or None
            if isChecked("Mouseover Dotting") and hasMouse and isValidTarget("mouseover") then
                if getDebuffRemain("mouseover",spell.shadowWordPain,"player") <= 1 then
                    if cast.shadowWordPain("mouseover") then return end
                end
            end
        -- Surrender To Madness
            -- surrender_to_madness,if=talent.surrender_to_madness.enabled&target.time_to_die<=variable.s2mcheck
            if isChecked("Surrender To Madness") and useCDs() then
                if talent.surrenderToMadness and ttd(units.dyn40) <= s2mCheck then
                    if cast.surrenderToMadness() then return end
                end
            end
        -- Shadow Word: Pain -- if moving and talent.misery, SW:P on dyn40 + cleaves. refresh if expiring soon
            -- shadow_word_pain,if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd.max,moving=1,cycle_targets=1
            if moving and talent.misery then
                if debuff.shadowWordPain.remain(units.dyn40) < gcdMax and not recentlyCast(units.dyn40, spell.shadowWordPain, 1.5*gcdMax) then
                    if cast.shadowWordPain(units.dyn40,"aoe") then 
                        -- Print("cast SWP on dyn40 with misery")
                        lastCastTrackerSpell = spell.shadowWordPain
                        lastCastTrackerUnit = units.dyn40
                        lastCastTrackerTime = GetTime()
                        return 
                    end
                end
                if not mode.rotation == 3 and debuff.shadowWordPain.remainCount(gcdMax) < SWPmaxTargets then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not UnitIsUnit(thisUnit, units.dyn40) and debuff.shadowWordPain.remain(thisUnit) < gcdMax and not recentlyCast(thisUnit, spell.shadowWordPain, 1.5*gcdMax)
                        then
                            if cast.shadowWordPain(thisUnit,"aoe") then 
                                -- Print("cast SWP on extra with misery")
                                lastCastTrackerSpell = spell.shadowWordPain
                                lastCastTrackerUnit = thisUnit
                                lastCastTrackerTime = GetTime()
                                return 
                            end
                        end
                    end
                end
            end
        -- Vampiric Touch -- if talent.misery, dot dyn40 + cleave targers with VT+SW:P. refresh if expiring soon
            -- vampiric_touch,if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and not moving and not isCastingSpell(spell.vampiricTouch) then
                if debuff.vampiricTouch.remain(units.dyn40) < 3*gcdMax or debuff.shadowWordPain.remain(units.dyn40) < 3*gcdMax and not recentlyCast(units.dyn40, spell.vampiricTouch, 1.5*gcdMax) 
                then
                    if cast.vampiricTouch(units.dyn40,"aoe") then 
                        -- Print("cast VT on dyn40 with misery")
                        lastCastTrackerSpell = spell.vampiricTouch
                        lastCastTrackerUnit = units.dyn40
                        lastCastTrackerTime = GetTime()
                        return 
                    end
                end
                if not mode.rotation == 3 and debuff.vampiricTouch.remainCount(3*gcdMax) < VTmaxTargets or debuff.shadowWordPain.remainCount(3*gcdMax) < SWPmaxTargets then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if ((debuff.vampiricTouch.remain(thisUnit) < 3 * gcdMax or debuff.shadowWordPain.remain(thisUnit) < 3 * gcdMax)) and not recentlyCast(thisUnit, spell.vampiricTouch, 1.5*gcdMax) 
                        then
                            if cast.vampiricTouch(thisUnit,"aoe") then 
                                -- Print("cast VT on extras with misery")
                                lastCastTrackerSpell = spell.vampiricTouch
                                lastCastTrackerUnit = thisUnit
                                lastCastTrackerTime = GetTime()
                                return 
                            end
                        end
                    end
                end
            end
        -- Vampiric Touch -- cast on dyn40 target. refresh if expiring soon
            -- vampiric_touch,if=!talent.misery.enabled&dot.vampiric_touch.remains<(4+(4%3))*gcd
            if not talent.misery and debuff.vampiricTouch.remain(units.dyn40) < (4 + (4 / 3)) * gcdMax and not isCastingSpell(spell.vampiricTouch) and not moving and not recentlyCast(units.dyn40, spell.vampiricTouch, 1.5*gcdMax) then
                if cast.vampiricTouch(units.dyn40) then 
                    -- Print("cast VT on dyn40 not misery")
                    lastCastTrackerSpell = spell.vampiricTouch
                    lastCastTrackerUnit = units.dyn40
                    lastCastTrackerTime = GetTime()
                    return 
                end
            end
        -- Shadow Word: Pain -- cast on dyn40 target. refresh if expiring soon
            -- shadow_word_pain,if=!talent.misery.enabled&dot.shadow_word_pain.remains<(3+(4%3))*gcd
            if not talent.misery and debuff.shadowWordPain.remain(units.dyn40) < (3 + (4 / 3)) * gcdMax and not recentlyCast(units.dyn40, spell.shadowWordPain, 1.5*gcdMax) then
                if cast.shadowWordPain(units.dyn40) then 
                    -- Print("cast SWP on dyn40 not misery")
                    lastCastTrackerSpell = spell.shadowWordPain
                    lastCastTrackerUnit = units.dyn40
                    lastCastTrackerTime = GetTime()
                    return 
                end
            end
        -- Void Eruption
            -- void_eruption
            if mode.voidForm == 1 and not moving then
                if cast.voidEruption("player") then return end
            end
        -- Shadow Crash
            -- shadow_crash,if=talent.shadow_crash.enabled
            if isChecked("Shadow Crash") and talent.shadowCrash and not mode.rotation == 3 then
                if cast.shadowCrash("best",nil,1,8) then return end
            end
        -- Shadow Word: Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2&insanity<=(85-15*talent.reaper_of_souls.enabled)
            if (activeEnemies <= 4 or (talent.reaperOfSouls and (activeEnemies <= 2 or mode.rotation == 3)))
                and charges.shadowWordDeath == 2 and power <= (85 - 15 * reaperOfSouls)
            then
                -- If Zeks Exterminatus (legendary cloak) has procced, SW:D is castable on any target, regardless of HP
                if getHP(units.dyn40) < executeHP then
                    if cast.shadowWordDeath(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    -- Look for any targets in execute HP range
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if getHP(thisUnit) < executeHP then
                            if cast.shadowWordDeath(thisUnit) then return end
                        end
                    end
                end
            end
        -- Mind Blast
            -- mind_blast,if=active_enemies<=4&talent.legacy_of_the_void.enabled&(insanity<=81|(insanity<=75.2&talent.fortress_of_the_mind.enabled))
            if activeEnemies <= 4 and not moving and lastCast ~= spell.mindBlast
                and talent.legacyOfTheVoid and (power <= 81 or (power <= 75.2 and talent.fortressOfTheMind)) and not recentlyCast(units.dyn40, spell.mindBlast, 1.5*gcdMax) 
            then
                if cast.mindBlast(units.dyn40) then 
                    lastCastTrackerSpell = spell.mindBlast
                    lastCastTrackerUnit = units.dyn40
                    lastCastTrackerTime = GetTime()
                    return 
                end
            end
        -- Mind Blast
            -- mind_blast,if=active_enemies<=4&!talent.legacy_of_the_void.enabled|(insanity<=96|(insanity<=95.2&talent.fortress_of_the_mind.enabled))
            if activeEnemies <= 4 and not moving  and lastCast ~= spell.mindBlast
                and not talent.legacyOfTheVoid and (power <= 96 or (power <= 95.2 and talent.fortressOfTheMind)) and not recentlyCast(units.dyn40, spell.mindBlast, 1.5*gcdMax) 
            then
                if cast.mindBlast(units.dyn40) then 
                    lastCastTrackerSpell = spell.mindBlast
                    lastCastTrackerUnit = units.dyn40
                    lastCastTrackerTime = GetTime()
                    return 
                end
            end
        -- Shadow Word: Pain - on extra dot targets (main target is handled above)
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            -- if not talent.misery and activeEnemies < 5 and not mode.rotation == 3
            --     and (talent.auspiciousSpirits or talent.shadowyInsight) and debuff.shadowWordPain.count() < SWPmaxTargets
            -- then
            --     for i = 1, #enemies.yards40 do
            --         local thisUnit = enemies.yards40[i]
            --         -- !ticking&target.time_to_die>10
            --         if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 and not recentlyCast(thisUnit, spell.shadowWordPain, 1.5*gcdMax) then
            --             if cast.shadowWordPain(thisUnit,"aoe") then 
            --                 lastCastTrackerSpell = spell.shadowWordPain
            --                 lastCastTrackerUnit = thisUnit
            --                 lastCastTrackerTime = GetTime()
            --                 return 
            --             end
            --         end
            --     end
            -- end
        -- Vampiric Touch - on extra dot targets (main target is handled above)
            -- vampiric_touch,if=active_enemies>1&!talent.misery.enabled&!ticking&(variable.dot_vt_dpgcd*target.time_to_die%(gcd.max*(156+variable.sear_dpgcd*(active_enemies-1))))>1,cycle_targets=1
            if activeEnemies > 1 and not talent.misery and not mode.rotation == 3 and debuff.vampiricTouch.Count() < VTmaxTargets and not moving then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.vampiricTouch.exists(thisUnit) and (dot_vt_dpgcd * ttd(thisUnit) / (gcdMax * (156 + sear_dpgcd * (activeEnemies - 1)))) > 1 and not recentlyCast(thisUnit, spell.vampiricTouch, 1.5*gcdMax) then
                        if cast.vampiricTouch(thisUnit,"aoe") then 
                            -- Print("cast VT on adds")
                            lastCastTrackerSpell = spell.vampiricTouch
                            lastCastTrackerUnit = thisUnit
                            lastCastTrackerTime = GetTime()
                            return 
                        end
                    end
                end
            end
        -- Shadow Word: Pain  - on extra dot targets (main target is handled above)
            --shadow_word_pain,if=active_enemies>1&!talent.misery.enabled&!ticking&(variable.dot_swp_dpgcd*target.time_to_die%(gcd.max*(118+variable.sear_dpgcd*(active_enemies-1))))>1,cycle_targets=1
            if activeEnemies > 1 and not talent.misery and not mode.rotation == 3 and debuff.shadowWordPain.Count() < SWPmaxTargets then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and (dot_swp_dpgcd * ttd(thisUnit) / (gcdMax * (118 + sear_dpgcd * (activeEnemies - 1)))) > 1 and not recentlyCast(thisUnit, spell.shadowWordPain, 1.5*gcdMax) then
                        if cast.shadowWordPain(thisUnit,"aoe") then 
                            -- Print("cast SWP on adds")
                            lastCastTrackerSpell = spell.shadowWordPain
                            lastCastTrackerUnit = thisUnit
                            lastCastTrackerTime = GetTime()
                            return 
                        end
                    end
                end
            end
        -- Shadow Word: Void
            -- shadow_word_void,if=talent.shadow_word_void.enabled&(insanity<=75-10*talent.legacy_of_the_void.enabled)
            if talent.shadowWordVoid and (power <= 75 - 10 * legacyOfTheVoid) then
                if cast.shadowWordVoid(units.dyn40) then return end
            end
        -- Mind Flay
            -- mind_flay,interrupt=1,chain=1
            if not moving then
                if not isCastingSpell(spell.mindFlay) and (lastCast ~= spell.mindFlay or (lastCast == spell.mindFlay and br.timer:useTimer("mindFlayRecast", mindFlayChannel + gcd))) then
                    if cast.mindFlay(units.dyn40) then return end
                end
            end
        -- Shadow Word: Pain
            -- shadow_word_pain
            if moving then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) then
                        if cast.shadowWordPain(thisUnit,"aoe") then 
                            -- Print("cast SWP last resort")
                            lastCastTrackerSpell = spell.shadowWordPain
                            lastCastTrackerUnit = thisUnit
                            lastCastTrackerTime = GetTime()
                            return 
                        end
                    end
                end
                lastCastTrackerSpell = spell.shadowWordPain
                lastCastTrackerUnit = units.dyn40
                lastCastTrackerTime = GetTime()
            end
        end
        -- Action List - Surrender To Madness
        function actionList_SurrenderToMadness() -- Provided by Cyberking07
        --Silence - to proc Sephuzs
            -- silence,if=equipped.sephuzs_secret&(target.is_add|target.debuff.casting.react)&cooldown.buff_sephuzs_secret.remains<1&!buff.sephuzs_secret.up,cycle_targets=1
            if buff.sephuz1.exists() and not buff.sephuzCooldown.exists() and not buff.sephuz2.exists() then
                if canInterrupt(units.dyn40,100) then
                    if cast.silence(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if canInterrupt(thisUnit,100) then
                            if cast.silence(thisUnit) then return end
                        end
                    end
                end
            end
        --Void Bolt
            -- void_bolt,if=buff.insanity_drain_stacks.stack<6&set_bonus.tier19_4pc
            if drainStacks < 6 and t19_4pc then
                if cast.voidBolt(units.dyn40,"known") then return end
            end
        -- Mind Bomb - to proc Sephuzs
            -- mind_bomb,if=equipped.sephuzs_secret&target.is_add&cooldown.buff_sephuzs_secret.remains<1&!buff.sephuzs_secret.up,cycle_targets=1
            if buff.sephuz1.exists() and buff.sephuzCooldown.remain() < 1 and not buff.sephuz2.exists() then
                if canInterrupt(units.dyn40,100) then
                    if cast.mindBomb(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not isInstanceBoss(thisUnit) and UnitLevel(thisUnit) < UnitLevel("player") + 3 then
                            if cast.mindBomb(thisUnit) then return end
                        end
                    end
                end
            end
        --Shadow Crash
            -- shadow_crash,if=talent.shadow_crash.enabled
            if isChecked("Shadow Crash") and talent.shadowCrash then
                if cast.shadowCrash("best",nil,1,8) then return end
            end
        --Mind Bender
            -- mindbender,if=cooldown.shadow_word_death.charges=0&buff.voidform.stack>(45+25*set_bonus.tier20_4pc)
            if isChecked("Shadowfiend / Mindbender") and useCDs() and talent.mindbender then
                if charges.shadowWordDeath == 0 and buff.voidForm.stack() >= getOptionValue("Shadowfiend Stacks") then
                    if cast.mindbender() then return end
                end
            end
        --Void Torrent
            -- void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&!buff.power_infusion.up|buff.voidform.stack<5
            if isChecked("Void Torrent") and useCDs() then
                if debuff.shadowWordPain.remain(units.dyn40) > 5.5 and debuff.vampiricTouch.remain(units.dyn40) > 5.5
                    and (not buff.powerInfusion.exists() or buff.voidForm.stack() < 5)
                then
                    if cast.voidTorrent() then return end
                end
            end
        --Berserking
            -- berserking,if=buff.voidform.stack>=65
            if br.player.race == "Troll" and getSpellCD(racial) == 0 and buff.voidForm.stack() >= 65 then
                if castSpell("player",racial,false,false,false) then return end
            end
        --Shadow Word Death
            -- shadow_word_death,if=current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+(30+30*talent.reaper_of_souls.enabled)<100)
            if insanityDrain * gcd > power and (power - (insanityDrain * gcd) + (30 + 30 * reaperOfSouls) < 100) then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        --Power Infusion
            -- power_infusion,if=cooldown.shadow_word_death.charges=0&buff.voidform.stack>(45+25*set_bonus.tier20_4pc)|target.time_to_die<=30
            if isChecked("Power Infusion") and useCDs() then
                if charges.shadowWordDeath == 0 and (buff.voidForm.stack() >= getOptionValue("Power Infusion Stacks") or ttd(units.dyn40) <= 30) then
                    if cast.powerInfusion() then return end
                end
            end
        --Void Bolt 
            -- void_bolt
            if cast.voidBolt(units.dyn40,"known") then return end
        --Shadow Word Death 
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+(30+30*talent.reaper_of_souls.enabled))<100
            if (#enemies.yards40 <= 4 or (talent.reaperOfSouls and #enemies <= 2))
                and insanityDrain * gcd > power and (power - (insanityDrain * gcd) + (30 + 30 * reaperOfSouls)) < 100
                
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        --Wait for Void Bolt    
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
            if cd.voidBolt < gcd * 0.28 then
                return true
            end
        --Dispersion
            -- dispersion,if=current_insanity_drain*gcd.max>insanity&!buff.power_infusion.up|(buff.voidform.stack>76&cooldown.shadow_word_death.charges=0&current_insanity_drain*gcd.max>insanity)
            if isChecked("Dispersion S2M") and useCDs() then
                if insanityDrain * gcd > power and (not buff.powerInfusion.exists() 
                    or (buff.voidForm.stack() >= getOptionValue("Dispersion Stacks") and charges.shadowWordDeath == 0 and insanityDrain * gcd > power)) 
                then
                    if cast.dispersion("player") then return end
                end
            end
        --Mind Blast    
            -- mind_blast,if=active_enemies<=5
            if ((mode.rotation == 1 and #enemies.yards40 <= 5) or mode.rotation == 3) then
                if cast.mindBlast() then return end
            end
        --Wait for Mind Blast   
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28&active_enemies<=5
            if ((mode.rotation == 1 and #enemies.yards40 <= 5) or mode.rotation == 3) and cd.mindBlast < gcd * 0.28 then
                return true
            end
        --Shadow Word Death 
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2
            if (enemies.yards40 <= 4 or (talent.reaperOfSouls and enemies.yards40 <= 2)) and charges.shadowWordDeath == 2 then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        --Shadow Fiend  
            -- shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
            if isChecked("Shadowfiend / Mindbender") and useCDs() then
                if not talent.mindbender and buff.voidForm.stack() >= getOptionValue("Shadowfiend Stacks") then
                    if cast.shadowfiend() then return end
                end
            end
        --Shadow Word Void  
            -- shadow_word_void,if=talent.shadow_word_void.enabled&(insanity-(current_insanity_drain*gcd.max)+50)<100
            if talent.shadowWordVoid and (power - (insanityDrain * gcd) + 50) < 100 then
                if cast.shadowWordVoid() then return end
            end
        --Shadow Word Pain  
            -- shadow_word_pain,if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd,moving=1,cycle_targets=1
            if talent.misery and moving and debuff.shadowWordPain.count() < getOptionValue("SWP Max Targets") then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if debuff.shadowWordPain.remain(thisUnit) < gcd then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        --Vampiric Touch    
            -- vampiric_touch,if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and debuff.vampiricTouch.count() < getOptionValue("VT Max Targets") and not isCastingSpell(spell.vampiricTouch) then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and (debuff.vampiricTouch.remain(thisUnit) < 3 * gcd or debuff.shadowWordPain.remain(thisUnit) < 3 * gcd) then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        --Shadow Word Pain  
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
            if not talent.misery and not debuff.shadowWordPain.exists()
                and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3) or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)
                
            then
                if cast.shadowWordPain() then return end
            end
        --Vampiric Touch    
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
            if not talent.misery and not debuff.vampiricTouch.exists() and not isCastingSpell(spell.vampiricTouch)
                and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
            then
                if cast.vampiricTouch() then return end
            end
        --Shadow Word Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and (talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)) and debuff.shadowWordPain.count() < getOptionValue("SWP Max Targets")
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        --Vampiric Touch    
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
                and debuff.vampiricTouch.count() < getOptionValue("VT Max Targets") and not isCastingSpell(spell.vampiricTouch)
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and not debuff.vampiricTouch.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        --Shadow Word Pain  
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and artifact.sphereOfInsanity) and debuff.shadowWordPain.count() < getOptionValue("SWP Max Targets")
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        --Mind Flay 
            -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(action.void_bolt.usable|(current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+60)<100&cooldown.shadow_word_death.charges>=1))
            if mfTick >= 2 and (cd.voidBolt == 0 or (insanityDrain * gcd > power and (power - (insanityDrain * gcd) + 60) < 100 and charges.shadowWordDeath >= 1)) 
                and (lastCast ~= spell.mindFlay or (lastCast == spell.mindFlay and br.timer:useTimer("mindFlayRecast", mindFlayChannel + gcd))) and (lastCast ~= spell.voidEruption or not t19_4pc)
            then
                return true
            elseif not buff.void.exists() then
                if cast.mindFlay() then return end
            end
        end -- End Action List - Surrender To Madness
    -- Action List - VoidForm
        function actionList_VoidForm()
        -- Surrender to Madness
            -- surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&(cooldown.void_bolt.up|cooldown.void_torrent.up|cooldown.shadow_word_death.up|buff.shadowy_insight.up)&target.time_to_die<=variable.s2mcheck-(buff.insanity_drain_stacks.value)
            if isChecked("Surrender To Madness") and useCDs() then
                if talent.surrenderToMadness and power >= 25 and (cd.voidBolt == 0 or cd.voidTorrent == 0 or cd.shadowWordDeath == 0 or buff.shadowyInsight.exists())
                    and ttd(units.dyn40) <= s2mCheck - drainStacks
                then
                    if cast.surrenderToMadness() then return end
                end
            end
        -- Silence - to proc Sephuzs
            -- silence,if=equipped.sephuzs_secret&(target.is_add|target.debuff.casting.react)&cooldown.buff_sephuzs_secret.remains<1&!buff.sephuzs_secret.up&buff.insanity_drain_stacks.value>10,cycle_targets=1
            if buff.sephuz1.exists() and not buff.sephuzCooldown.exists() and not buff.sephuz2.exists() and drainStacks > 10 then
                if canInterrupt(units.dyn40,100) then
                    if cast.silence(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if canInterrupt(thisUnit,100) then
                            if cast.silence(thisUnit) then return end
                        end
                    end
                end
            end
        -- Void Bolt
            -- void_bolt
            --if cd.voidBolt == 0 or buff.void.exists() then
                if cast.voidBolt(units.dyn40,"known") then return end
            --end 
        -- Mind Bomb - to proc Sephuzs
            -- mind_bomb,if=equipped.sephuzs_secret&target.is_add&cooldown.buff_sephuzs_secret.remains<1&!buff.sephuzs_secret.up&buff.insanity_drain_stacks.value>10,cycle_targets=1
            if buff.sephuz1.exists() and buff.sephuzCooldown.remain() < 1 and not buff.sephuz2.exists() and drainStacks > 10 then
                if canInterrupt(units.dyn40,100) then
                    if cast.mindBomb(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not isInstanceBoss(thisUnit) and UnitLevel(thisUnit) < UnitLevel("player") + 3 then
                            if cast.mindBomb(thisUnit) then return end
                        end
                    end
                end
            end
        -- Mouseover Dotting
            if isChecked("Mouseover Dotting") and hasMouse and isValidTarget("mouseover") then
                if getDebuffRemain("mouseover",spell.shadowWordPain,"player") <= 1 then
                    if cast.shadowWordPain("mouseover") then return end
                end
            end
        -- Shadow Crash
            -- shadow_crash,if=talent.shadow_crash.enabled
            if isChecked("Shadow Crash") and talent.shadowCrash then
                if cast.shadowCrash("best",nil,1,8) then return end
            end
        -- Void Torrent
            -- void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60))
            if isChecked("Void Torrent") and artifact.voidTorrent and useCDs()
                and debuff.shadowWordPain.remain(units.dyn40) > 5.5 and debuff.vampiricTouch.remain(units.dyn40) > 5.5
                and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck - drainStacks + 60))
            then
                if cast.voidTorrent() then return end
            end
        -- Mindbender
            if isChecked("Shadowfiend / Mindbender") and talent.mindbender  and useCDs()then
                if getOptionValue("  Shadowfiend Stacks") > 0 then
                -- use configured value
                    if buff.voidForm.stack() >= getOptionValue("  Shadowfiend Stacks") then
                        if cast.mindbender() then return end
                    end
                else
                -- mindbender,if=buff.insanity_drain_stacks.value>=(variable.cd_time-(3*set_bonus.tier20_4pc*(raid_event.movement.in<15)*((active_enemies-(raid_event.adds.count*(raid_event.adds.remains>0)))=1))+(5-3*set_bonus.tier20_4pc)*buff.bloodlust.up+2*talent.fortress_of_the_mind.enabled*set_bonus.tier20_4pc)&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-buff.insanity_drain_stacks.value))
                    if drainStacks >= (cd_time -  (3 * t20pc4 * raidMovementWithin15 * singleEnemy) + (5 - 3*t20pc4)*lusting + 2*fortressOfTheMind*t20pc4)
                        and (not talent.surrenderTomadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck - drainStacks)) 
                    then
                        if cast.mindbender() then return end
                    end
                end
            end
        -- Power Infusion
            -- power_infusion,if=buff.insanity_drain_stacks.value>=(variable.cd_time+5*buff.bloodlust.up*(1+1*set_bonus.tier20_4pc))&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.value)+61))
            if isChecked("Power Infusion") and talent.powerInfusion and useCDs() then
                if getOptionValue("  Power Infusion Stacks") > 0 then
                    if buff.voidForm.stack() >= getOptionValue("  Power Infusion Stacks") then
                        if cast.powerInfusion() then return end
                    end
                else
                    if drainStacks >= (cd_time + 5 * lusting * (1 + 1 * t20pc4)) 
                        and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mcheck + 61 - drainStacks)) 
                    then
                        if cast.powerInfusion() then return end
                    end
                end
            end
        -- Berserking
            -- berserking,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60))
            if br.player.race == "Troll" and getSpellCD(racial) == 0 and buff.voidForm.stack() >= 10 and drainStacks <= 20
                and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck + 60 - drainStacks))
            then
                if castSpell("player",racial,false,false,false) then return end
            end
        -- Shadow Word - Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+(15+15*talent.reaper_of_souls.enabled))<100
            if (activeEnemies <= 4 or (talent.reaperOfSouls and activeEnemies <= 2))
                and insanityDrain * gcdMax > power and (power - (insanityDrain * gcdMax) + (15 + 15 * reaperOfSouls)) < 100
            then
                -- If Zeks Exterminatus (legendary cloak) has procced, SW:D is castable on any target, regardless of HP
                if getHP(units.dyn40) < executeHP then
                    if cast.shadowWordDeath(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    -- Look for any targets in execute HP range
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if getHP(thisUnit) < executeHP then
                            if cast.shadowWordDeath(thisUnit) then return end
                        end
                    end
                end
            end
        -- Wait For Void Bolt
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
            if cd.voidBolt < gcdMax * 0.28 then
                return true
            end
        -- Mind Blast
            -- mind_blast,if=active_enemies<=4
            if activeEnemies <= 4 and not moving then
                if cast.mindBlast() then return end
            end
        -- Wait For Mind Blast
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28&active_enemies<=4
            if activeEnemies <= 4 and cd.mindBlast < gcdMax * 0.28 then
                return true
            end
        -- Shadow Word - Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2
            if (activeEnemies <= 4 or (talent.reaperOfSouls and activeEnemies <= 2)) and charges.shadowWordDeath == 2 then
                -- If Zeks Exterminatus (legendary cloak) has procced, SW:D is castable on any target, regardless of HP
                if getHP(units.dyn40) < executeHP then
                    if cast.shadowWordDeath(units.dyn40) then return end
                end
                if not mode.rotation == 3 then
                    -- Look for any targets in execute HP range
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if getHP(thisUnit) < executeHP then
                            if cast.shadowWordDeath(thisUnit) then return end
                        end
                    end
                end
            end
        -- Shadowfiend
            -- shadowfiend,if=!talent.mindbender.enabled&buff.voidform.stack>15
            if isChecked("Shadowfiend / Mindbender") and not talent.mindbender and useCDs() then
                if getOptionValue("  Shadowfiend Stacks") > 0 then
                    if buff.voidForm.stack() >= getOptionValue("  Shadowfiend Stacks") then
                        if cast.shadowfiend() then return end
                    end
                else
                    if buff.voidForm.stack() > 15 then
                        if cast.shadowfiend() then return end
                    end
                end
            end
        -- Shadow Word - Void
            -- shadow_word_void,if=talent.shadow_word_void.enabled&(insanity-(current_insanity_drain*gcd.max)+25)<100
            if talent.shadowWordVoid and (power - (insanityDrain * gcdMax) + 25) < 100 then
                if cast.shadowWordVoid() then return end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max)&target.time_to_die>5*gcd.max,cycle_targets=1
            if talent.misery and not moving then
                if (debuff.shadowWordPain.remain(units.dyn40) < 3*gcdMax or debuff.vampiricTouch.remain(units.dyn40) < 3*gcdMax) and ttd(units.dyn40) > 5*gcdMax then
                    if cast.vampiricTouch(units.dyn40,"aoe") then return end
                end
                if debuff.vampiricTouch.remainCount(gcdMax) < VTmaxTargets then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if (debuff.vampiricTouch.remain(thisUnit) < 3*gcdMax or debuff.shadowWordPain.remain(thisUnit) < 3*gcdMax) and ttd(thisUnit) > 5*gcdMax then
                            if cast.vampiricTouch(thisUnit,"aoe") then return end
                        end
                    end
                end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd,moving=1,cycle_targets=1
            if moving and talent.misery then
                if debuff.shadowWordPain.remain(units.dyn40) < gcdMax then
                    if cast.shadowWordPain(units.dyn40,"aoe") then return end
                end
                if debuff.shadowWordPain.remainCount(gcdMax) < SWPmaxTargets then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not UnitIsUnit(thisUnit, units.dyn40) and debuff.shadowWordPain.remain(thisUnit) < gcdMax then
                            if cast.shadowWordPain(thisUnit,"aoe") then return end
                        end
                    end
                end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
            if not talent.misery and not debuff.shadowWordPain.exists()
                and (activeEnemies < 5 or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)
            then
                if cast.shadowWordPain() then return end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
            if not talent.misery and not debuff.vampiricTouch.exists() and not isCastingSpell(spell.vampiricTouch) and not moving
                and (activeEnemies < 4 or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))   
            then
                if cast.vampiricTouch() then return end
            end
            -- vampiric_touch,if=active_enemies>1&!talent.misery.enabled&!ticking&((1+0.02*buff.voidform.stack)*variable.dot_vt_dpgcd*target.time_to_die%(gcd.max*(156+variable.sear_dpgcd*(active_enemies-1))))>1,cycle_targets=1
            if activeEnemies > 1 and not talent.misery and not moving then
                if not debuff.vampiricTouch.exists(units.dyn40) and ((1 + 0.02 * buff.voidForm.stack()) * dot_vt_dpgcd * ttd(units.dyn40) / (gcdMax * (156 + sear_dpgcd * (activeEnemies - 1)))) > 1 then
                    if cast.vampiricTouch(units.dyn40) then return end
                end
                if debuff.vampiricTouch.count() < VTmaxTargets and not moving and not isCastingSpell(spell.vampiricTouch) then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.vampiricTouch.exists(thisUnit) and ((1 + 0.02 * buff.voidForm.stack()) * dot_vt_dpgcd * ttd(thisUnit) / (gcdMax * (156 + sear_dpgcd * (activeEnemies - 1)))) > 1 then
                            if cast.vampiricTouch(thisUnit,"aoe") then return end
                        end
                    end
                end 
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=active_enemies>1&!talent.misery.enabled&!ticking&((1+0.02*buff.voidform.stack)*variable.dot_swp_dpgcd*target.time_to_die%(gcd.max*(118+variable.sear_dpgcd*(active_enemies-1))))>1,cycle_targets=1
            if activeEnemies > 1 and not talent.misery then
                if not debuff.shadowWordPain.exists(units.dyn40) and ((1 + 0.02 * buff.voidForm.stack()) * dot_swp_dpgcd * ttd(units.dyn40) / (gcdMax * (118 + sear_dpgcd * (activeEnemies - 1)))) > 1 then
                    if cast.shadowWordPain(units.dyn40) then return end
                end
                if debuff.shadowWordPain.count() < SWPmaxTargets then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not debuff.shadowWordPain.exists(thisUnit) and ((1 + 0.02 * buff.voidForm.stack()) * dot_swp_dpgcd * ttd(thisUnit) / (gcdMax * (118 + sear_dpgcd * (activeEnemies - 1)))) > 1 then
                            if cast.shadowWordPain(thisUnit,"aoe") then return end
                        end
                    end
                end 
            end
        -- Mind Flay
            -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(action.void_bolt.usable|(current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+30)<100&cooldown.shadow_word_death.charges>=1))
            if isCastingSpell(spell.mindFlay) and mfTick >= 2 and (cd.voidBold == 0 or (insanityDrain * gcdMax > power and (power - (insanityDrain * gcdMax) + 30) < 100 and charges.shadowWordDeath >= 1)) then
                return true               
            elseif not moving then
                if cast.mindFlay(units.dyn40) then return end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain
            cast.shadowWordPain()
        end -- End Action List - VoidForm
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or IsMounted() or IsFlying() or (pause(true) and not isCastingSpell(spell.mindFlay)) or mode.rotation==4 or buff.void.exists() then
            return true
        else
-----------------
--- Rotations ---
-----------------
            if actionList_Extra() then return end
            if actionList_Defensive() then return end
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat then --  and GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player")
                if actionList_PreCombat() then return end
            end
-----------------------------
--- In Combat - Rotations ---
-----------------------------
            if inCombat and not IsMounted() and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 and not isCastingSpell(spell.voidTorrent) and not isCastingSpell(spell.mindBlast) then
            -- Action List - Cooldowns
                actionList_Cooldowns()
            -- Action List - Check
                -- call_action_list,name=check,if=talent.surrender_to_madness.enabled&!buff.surrender_to_madness.up
                if talent.surrenderToMadness and not buff.surrenderToMadness then
                    if actionList_Check() then return end
                end
            -- Action List - Surrender To Madness
                -- s2m,if=buff.voidform.up&buff.surrender_to_madness.up
                if buff.voidForm.exists() and buff.surrenderToMadness.exists() then
                    if actionList_SurrenderToMadness() then return end
                end
            -- Action List - Void Form
                -- run_action_list,name=vf,if=buff.voidform.up
                if mode.voidForm == 1 and buff.voidForm.exists() then
                    if actionList_VoidForm() then return end
                end
            -- Action List - Main
                -- run_action_list,name=main
                if not buff.voidForm.exists() or mode.voidForm == 2 then
                    if actionList_Main() then return end
                end
            end -- End Combat Rotation
        end
    end -- End Timer
end -- Run Rotation

local id = 258
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
