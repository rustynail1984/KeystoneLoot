local AddonName, KeystoneLoot = ...;

local L = KeystoneLoot.L;

-- Quality color codes matching the WoW item quality colors
local QUALITY_COLORS = {
    poor        = "9d9d9d", -- Gray
    Adventurer  = "1eff00", -- Green
    Veteran     = "0070dd", -- Blue
    Champion    = "a335ee", -- Purple
    Hero        = "ff8000", -- Orange
    Myth        = "F5E027", -- Gold
};

KeystoneLoot.IlvlOverview = {
    -- ============================================================
    -- Upgrade Tracks (Aufwertungspfade)
    -- ============================================================
    upgradeTracks = {
        { ilvl = 220, track = L["Adventurer"] .. " 1",                                             crest = L["Adventurer"],  color = QUALITY_COLORS.Adventurer },
        { ilvl = 224, track = L["Adventurer"] .. " 2",                                             crest = L["Adventurer"],  color = QUALITY_COLORS.Adventurer },
        { ilvl = 227, track = L["Adventurer"] .. " 3",                                             crest = L["Adventurer"],  color = QUALITY_COLORS.Adventurer },
        { ilvl = 230, track = L["Adventurer"] .. " 4",                                             crest = L["Adventurer"],  color = QUALITY_COLORS.Adventurer },
        { ilvl = 233, track = L["Adventurer"] .. " 5 / " .. L["Veteran"] .. " 1",                  crest = L["Adventurer"],  color = QUALITY_COLORS.Adventurer },
        { ilvl = 237, track = L["Adventurer"] .. " 6 / " .. L["Veteran"] .. " 2",                  crest = L["Adventurer"],  color = QUALITY_COLORS.Adventurer},
        { ilvl = 240, track = L["Veteran"] .. " 3",                                                crest = L["Veteran"],     color = QUALITY_COLORS.Veteran },
        { ilvl = 243, track = L["Veteran"] .. " 4",                                                crest = L["Veteran"],     color = QUALITY_COLORS.Veteran },
        { ilvl = 246, track = L["Veteran"] .. " 5 / " .. L["Champion"] .. " 1",                    crest = L["Veteran"],     color = QUALITY_COLORS.Veteran },
        { ilvl = 250, track = L["Veteran"] .. " 6 / " .. L["Champion"] .. " 2",                    crest = L["Veteran"],     color = QUALITY_COLORS.Veteran },
        { ilvl = 253, track = L["Champion"] .. " 3",                                               crest = L["Champion"],    color = QUALITY_COLORS.Champion },
        { ilvl = 256, track = L["Champion"] .. " 4",                                               crest = L["Champion"],    color = QUALITY_COLORS.Champion },
        { ilvl = 259, track = L["Champion"] .. " 5 / " .. L["Hero"] .. " 1",                       crest = L["Champion"],    color = QUALITY_COLORS.Champion },
        { ilvl = 263, track = L["Champion"] .. " 6 / " .. L["Hero"] .. " 2",                       crest = L["Champion"],    color = QUALITY_COLORS.Champion },
        { ilvl = 266, track = L["Hero"] .. " 3",                                                   crest = L["Hero"],        color = QUALITY_COLORS.Hero },
        { ilvl = 269, track = L["Hero"] .. " 4",                                                   crest = L["Hero"],        color = QUALITY_COLORS.Hero },
        { ilvl = 272, track = L["Hero"] .. " 5 / " .. L["Mythic"] .. " 1",                         crest = L["Hero"],        color = QUALITY_COLORS.Hero },
        { ilvl = 276, track = L["Hero"] .. " 6 / " .. L["Mythic"] .. " 2",                         crest = L["Hero"],        color = QUALITY_COLORS.Hero },
        { ilvl = 279, track = L["Mythic"] .. " 3",                                                 crest = L["Mythic"],      color = QUALITY_COLORS.Myth },
        { ilvl = 282, track = L["Mythic"] .. " 4",                                                 crest = L["Mythic"],      color = QUALITY_COLORS.Myth },
        { ilvl = 285, track = L["Mythic"] .. " 5",                                                 crest = L["Mythic"],      color = QUALITY_COLORS.Myth },
        { ilvl = 289, track = L["Mythic"] .. " 6",                                                 crest = L["Mythic"],      color = QUALITY_COLORS.Myth },
    },

    -- ============================================================
    -- Crafted Item Levels (Hergestellte Gegenstandsstufen)
    -- ============================================================
    crafted = {
        headers = { L["Quality"], L["Adventurer"], L["Veteran"], L["Champion"], L["Hero"], L["Mythic"] },
        rows = {
            { quality = 1, values = {
                { ilvl = 220, color = QUALITY_COLORS.Adventurer },
                { ilvl = 233, color = QUALITY_COLORS.Veteran },
                { ilvl = 246, color = QUALITY_COLORS.Champion },
                { ilvl = 259, color = QUALITY_COLORS.Hero },
                { ilvl = 272, color = QUALITY_COLORS.Myth },
            }},
            { quality = 2, values = {
                { ilvl = 224, color = QUALITY_COLORS.Adventurer },
                { ilvl = 237, color = QUALITY_COLORS.Veteran },
                { ilvl = 250, color = QUALITY_COLORS.Champion },
                { ilvl = 263, color = QUALITY_COLORS.Hero },
                { ilvl = 276, color = QUALITY_COLORS.Myth },
            }},
            { quality = 3, values = {
                { ilvl = 227, color = QUALITY_COLORS.Adventurer },
                { ilvl = 240, color = QUALITY_COLORS.Veteran },
                { ilvl = 253, color = QUALITY_COLORS.Champion },
                { ilvl = 266, color = QUALITY_COLORS.Hero },
                { ilvl = 279, color = QUALITY_COLORS.Myth },
            }},
            { quality = 4, values = {
                { ilvl = 230, color = QUALITY_COLORS.Adventurer },
                { ilvl = 243, color = QUALITY_COLORS.Veteran },
                { ilvl = 256, color = QUALITY_COLORS.Champion },
                { ilvl = 269, color = QUALITY_COLORS.Hero },
                { ilvl = 282, color = QUALITY_COLORS.Myth },
            }},
            { quality = 5, values = {
                { ilvl = 233, color = QUALITY_COLORS.Adventurer },
                { ilvl = 246, color = QUALITY_COLORS.Veteran },
                { ilvl = 259, color = QUALITY_COLORS.Champion },
                { ilvl = 272, color = QUALITY_COLORS.Hero },
                { ilvl = 285, color = QUALITY_COLORS.Myth },
            }},
        },
    },

    -- ============================================================
    -- Dungeon Item Levels (Dungeon-Gegenstandsstufen)
    -- ============================================================
    dungeons = {
        headers = { L["Source"], L["End of Dungeon"], L["Great Vault"] },
        rows = {
						{ source = "Pre-Season " .. L["Mythic"],   endOfRun = { ilvl = 240, color = QUALITY_COLORS.Veteran }, vault = { ilvl = "-", color = QUALITY_COLORS.poor } },
            { source = L["Mythic"],   endOfRun = { ilvl = 246, color = QUALITY_COLORS.Champion }, vault = { ilvl = 256, color = QUALITY_COLORS.Champion } },
            { source = "M2",          endOfRun = { ilvl = 250, color = QUALITY_COLORS.Champion }, vault = { ilvl = 259, color = QUALITY_COLORS.Hero } },
            { source = "M3",          endOfRun = { ilvl = 250, color = QUALITY_COLORS.Champion }, vault = { ilvl = 259, color = QUALITY_COLORS.Hero } },
            { source = "M4",          endOfRun = { ilvl = 253, color = QUALITY_COLORS.Champion }, vault = { ilvl = 263, color = QUALITY_COLORS.Hero } },
            { source = "M5",          endOfRun = { ilvl = 256, color = QUALITY_COLORS.Champion }, vault = { ilvl = 263, color = QUALITY_COLORS.Hero } },
            { source = "M6",          endOfRun = { ilvl = 259, color = QUALITY_COLORS.Hero },    vault = { ilvl = 266, color = QUALITY_COLORS.Hero } },
            { source = "M7",          endOfRun = { ilvl = 259, color = QUALITY_COLORS.Hero },    vault = { ilvl = 269, color = QUALITY_COLORS.Hero } },
            { source = "M8",          endOfRun = { ilvl = 263, color = QUALITY_COLORS.Hero },    vault = { ilvl = 269, color = QUALITY_COLORS.Hero } },
            { source = "M9",          endOfRun = { ilvl = 263, color = QUALITY_COLORS.Hero },    vault = { ilvl = 269, color = QUALITY_COLORS.Hero } },
            { source = "M10",         endOfRun = { ilvl = 266, color = QUALITY_COLORS.Hero },    vault = { ilvl = 272, color = QUALITY_COLORS.Myth } },
            { source = "M11",         endOfRun = { ilvl = 266, color = QUALITY_COLORS.Hero },    vault = { ilvl = 272, color = QUALITY_COLORS.Myth } },
            { source = "M12",         endOfRun = { ilvl = 266, color = QUALITY_COLORS.Hero },    vault = { ilvl = 272, color = QUALITY_COLORS.Myth } },
        },
    },

    -- ============================================================
    -- Raid Item Levels (Schlachtzug-Gegenstandsstufen)
    -- ============================================================
    raids = {
        headers = { L["Difficulty"], L["Early"], L["Mid"], L["Late"], L["End"] },
        rows = {
            { difficulty = L["Raid Finder"], values = {
                { ilvl = 233, color = QUALITY_COLORS.Veteran },
                { ilvl = 237, color = QUALITY_COLORS.Veteran },
                { ilvl = 240, color = QUALITY_COLORS.Veteran },
                { ilvl = 243, color = QUALITY_COLORS.Veteran },
            }},
            { difficulty = L["Normal"], values = {
                { ilvl = 246, color = QUALITY_COLORS.Champion },
                { ilvl = 250, color = QUALITY_COLORS.Champion },
                { ilvl = 253, color = QUALITY_COLORS.Champion },
                { ilvl = 256, color = QUALITY_COLORS.Champion },
            }},
            { difficulty = L["Heroic"], values = {
                { ilvl = 259, color = QUALITY_COLORS.Hero },
                { ilvl = 263, color = QUALITY_COLORS.Hero },
                { ilvl = 266, color = QUALITY_COLORS.Hero },
                { ilvl = 269, color = QUALITY_COLORS.Hero },
            }},
            { difficulty = L["Mythic"], values = {
                { ilvl = 272, color = QUALITY_COLORS.Myth },
                { ilvl = 276, color = QUALITY_COLORS.Myth },
                { ilvl = 279, color = QUALITY_COLORS.Myth },
                { ilvl = 282, color = QUALITY_COLORS.Myth },
            }},
        },
    },

    -- ============================================================
    -- Delve Item Levels (Tiefen-Gegenstandsstufen)
    -- ============================================================
    delves = {
        headers = { L["Tier"], L["End of Delve"], L["Map Drop"], L["Great Vault"] },
        rows = {
            { tier = "T1",  endReward = { ilvl = 220, color = QUALITY_COLORS.Adventurer },        mapDrop = nil,                                                    vault = { ilvl = 233, color = QUALITY_COLORS.Veteran } },
            { tier = "T2",  endReward = { ilvl = 224, color = QUALITY_COLORS.Adventurer },        mapDrop = nil,                                                    vault = { ilvl = 237, color = QUALITY_COLORS.Veteran } },
            { tier = "T3",  endReward = { ilvl = 227, color = QUALITY_COLORS.Adventurer },        mapDrop = nil,                                                    vault = { ilvl = 240, color = QUALITY_COLORS.Veteran } },
            { tier = "T4",  endReward = { ilvl = 230, color = QUALITY_COLORS.Adventurer },        mapDrop = { ilvl = 237, color = QUALITY_COLORS.Veteran },            vault = { ilvl = 243, color = QUALITY_COLORS.Veteran } },
            { tier = "T5",  endReward = { ilvl = 233, color = QUALITY_COLORS.Veteran },        mapDrop = { ilvl = 243, color = QUALITY_COLORS.Veteran },      vault = { ilvl = 246, color = QUALITY_COLORS.Champion } },
            { tier = "T6",  endReward = { ilvl = 237, color = QUALITY_COLORS.Veteran },        mapDrop = { ilvl = 250, color = QUALITY_COLORS.Champion },      vault = { ilvl = 250, color = QUALITY_COLORS.Champion } },
            { tier = "T7",  endReward = { ilvl = 250, color = QUALITY_COLORS.Champion },  mapDrop = { ilvl = 256, color = QUALITY_COLORS.Champion },      vault = { ilvl = 256, color = QUALITY_COLORS.Champion } },
            { tier = "T8",  endReward = { ilvl = 250, color = QUALITY_COLORS.Champion },  mapDrop = { ilvl = 259, color = QUALITY_COLORS.Veteran },         vault = { ilvl = 259, color = QUALITY_COLORS.Hero } },
            { tier = "T9",  endReward = { ilvl = 250, color = QUALITY_COLORS.Champion },  mapDrop = { ilvl = 259, color = QUALITY_COLORS.Veteran },         vault = { ilvl = 259, color = QUALITY_COLORS.Hero } },
            { tier = "T10", endReward = { ilvl = 250, color = QUALITY_COLORS.Champion },  mapDrop = { ilvl = 259, color = QUALITY_COLORS.Veteran },         vault = { ilvl = 259, color = QUALITY_COLORS.Hero } },
            { tier = "T11", endReward = { ilvl = 250, color = QUALITY_COLORS.Champion },  mapDrop = { ilvl = 259, color = QUALITY_COLORS.Veteran },         vault = { ilvl = 259, color = QUALITY_COLORS.Hero } },
        },
    },
};