local AddonName, Addon = ...;


local MainFrame = Addon.Frames.Main;
local NoSeason = Addon.Frames.NoSeason;

local INSTANCE_FRAMES = {};
local ROWS = 1;


local function CreateInstanceFrame(i)
	local Frame = CreateFrame('Frame', nil, MainFrame, 'InsetFrameTemplate');
	Frame.ItemFrames = {};
	Frame:SetSize(180, 90);

	if (i == 1) then
		Frame:SetPoint('TOP', -110, -100);
	elseif (mod(i, 2) == 1) then
		Frame:SetPoint('TOP', INSTANCE_FRAMES[i - 2], 'BOTTOM', 0, -40);

		ROWS = ROWS + 1;
	else
		Frame:SetPoint('LEFT', INSTANCE_FRAMES[i - 1], 'RIGHT', 40, 0);
	end

	local FrameBg = Frame.Bg;
	FrameBg:SetHorizTile(false);
	FrameBg:SetVertTile(false);
	FrameBg:SetTexCoord(5/256, 169/256, 5/128, 91/128);

	local Title = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableLarge');
	Frame.Title = Title;
	Title:SetPoint('BOTTOM', Frame, 'TOP', 0, 5);


	table.insert(INSTANCE_FRAMES, Frame);

	return Frame;
end

local function GetInstanceFrame(i)
	return INSTANCE_FRAMES[i] or CreateInstanceFrame(i);
end
Addon.GetInstanceFrame = GetInstanceFrame;

local function GetInstanceFrames()
	return INSTANCE_FRAMES;
end
Addon.GetInstanceFrames = GetInstanceFrames;

local function CreateInstanceFrames()
	local mythicTierID = Addon.API.GetMythicTierID();
	if (not mythicTierID) then
		NoSeason:Show();
		return;
	end

	EJ_SelectTier(mythicTierID);
	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);

	local instanceIndex = 1;
	local instanceID, name, _, _, buttonImage = EJ_GetInstanceByIndex(instanceIndex, false);

	while (instanceID) do
		local InstanceFrame = GetInstanceFrame(instanceIndex);
		InstanceFrame.instanceID = instanceID;

		InstanceFrame.Title:SetText(name);
		InstanceFrame.Bg:SetTexture(buttonImage);

		instanceIndex = instanceIndex+1;
		instanceID, name, _, _, buttonImage = EJ_GetInstanceByIndex(instanceIndex, false);
	end

	MainFrame:SetHeight(100 + (ROWS * 130));
end
Addon.CreateInstanceFrames = CreateInstanceFrames;