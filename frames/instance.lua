local AddonName, Addon = ...;

if (Addon.Frames == nil) then
	Addon.Frames = {};
end

local INSTANCE_FRAMES = {};
local INSTANCE_MAX_WIDTH = 256 * (90 / 128);
local ROWS = 1;


local function CreateInstanceFrame(parent)
	local i = #INSTANCE_FRAMES + 1;

	local Frame = CreateFrame('Frame', nil, parent, 'InsetFrameTemplate');

	Frame:SetSize(INSTANCE_MAX_WIDTH, 90);

	if (i == 1) then
		Frame:SetPoint('TOP', -((INSTANCE_MAX_WIDTH / 2)+20), -100);
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
	FrameBg:SetTexture();

	local Title = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableLarge');
	Frame.Title = Title;
	Title:SetPoint('BOTTOM', Frame, 'TOP', 0, 5);
	Title:SetText(name);


	Frame.SetBackground = function(self, texture)
		self.Bg:SetTexture(texture);
	end

	Frame.SetTitle = function(self, title)
		self.Title:SetText(title);
	end

	-- TODO: Main frame dynamische Höhe
	table.insert(INSTANCE_FRAMES, Frame);

	return Frame;
end

Addon.CreateInstanceFrame = CreateInstanceFrame;