local AddonName, KeystoneLoot = ...;

SlashCmdList.KEYSTONELOOT = function()
    KeystoneLootFrame:SetShown(not KeystoneLootFrame:IsShown());
end;

SLASH_KEYSTONELOOT1 = "/ksl";
SLASH_KEYSTONELOOT2 = "/keyloot";
SLASH_KEYSTONELOOT3 = "/keystoneloot";


SlashCmdList.KSLRELOAD = ReloadUI;
SLASH_KSLRELOAD1 = "/rl";
SLASH_KSLRELOAD2 = "/reload";
SLASH_KSLRELOAD3 = "/reloadui";