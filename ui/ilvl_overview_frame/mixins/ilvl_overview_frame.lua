local AddonName, KeystoneLoot = ...;

local L = KeystoneLoot.L;

KeystoneLootIlvlOverviewFrameMixin = {};

-- Layout constants
local SECTION_SPACING = 16;
local ROW_HEIGHT = 18;
local HEADER_HEIGHT = 20;
local SECTION_HEADER_HEIGHT = 22;
local TABLE_TOP_PADDING = 4;
local LEFT_MARGIN = 12;
local TABLE_WIDTH = 460;

-- Colors
local HEADER_COLOR = { r = 1, g = 0.82, b = 0 };
local LABEL_COLOR = { r = 0.8, g = 0.8, b = 0.8 };
local NOTE_COLOR = "ff4040";
local ROW_BG_EVEN = { 1, 1, 1, 0.04 };
local ROW_BG_ODD = { 1, 1, 1, 0.08 };
local GRID_LINE_COLOR = { 0.35, 0.35, 0.35, 0.5 };
local HEADER_BG_COLOR = { 1, 0.82, 0, 0.10 };

function KeystoneLootIlvlOverviewFrameMixin:OnLoad()
    self.Inset.Bg:SetAlpha(0.75);
    self.Inset.Bg:SetAtlas("UI-Frame-Dragonflight-BackgroundTile");

    self.elements = {};
end

function KeystoneLootIlvlOverviewFrameMixin:Init()
    self:Refresh();
end

function KeystoneLootIlvlOverviewFrameMixin:Refresh()
    for _, el in ipairs(self.elements) do
        el:Hide();
        el:SetParent(nil);
    end
    wipe(self.elements);

    local data = KeystoneLoot.IlvlOverview;
    if (not data) then
        return;
    end

    local scrollChild = self.ScrollFrame:GetScrollChild();
    local yOffset = -8;

    yOffset = self:RenderUpgradeTracks(scrollChild, yOffset, data.upgradeTracks);
    yOffset = yOffset - SECTION_SPACING;

    yOffset = self:RenderCraftedTable(scrollChild, yOffset, data.crafted);
    yOffset = yOffset - SECTION_SPACING;

    yOffset = self:RenderDungeonTable(scrollChild, yOffset, data.dungeons);
    yOffset = yOffset - SECTION_SPACING;

    yOffset = self:RenderRaidTable(scrollChild, yOffset, data.raids);
    yOffset = yOffset - SECTION_SPACING;

    yOffset = self:RenderDelveTable(scrollChild, yOffset, data.delves);

    local totalHeight = math.abs(yOffset) + 16;
    scrollChild:SetHeight(totalHeight);
end

-- ============================================================
-- Helper: Track element for cleanup
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:Track(element)
    table.insert(self.elements, element);
    return element;
end

-- ============================================================
-- Helper: Create FontString
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:CreateText(parent, text, font, x, y, justifyH, color, width, height)
    local fs = parent:CreateFontString(nil, "OVERLAY", font or "GameFontNormalSmall");
    fs:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y);
    fs:SetJustifyH(justifyH or "LEFT");
    fs:SetJustifyV("MIDDLE");
    fs:SetText(text);

    if (width) then
        fs:SetWidth(width);
    end

    if (height) then
        fs:SetHeight(height);
    end

    if (color) then
        if (type(color) == "string") then
            fs:SetText("|cff" .. color .. text .. "|r");
        elseif (type(color) == "table") then
            fs:SetTextColor(color.r, color.g, color.b);
        end
    end

    return self:Track(fs);
end

-- ============================================================
-- Helper: Create a row background
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:CreateRowBg(parent, y, rowIndex, width, height)
    local tex = parent:CreateTexture(nil, "BACKGROUND");
    tex:SetHeight(height or ROW_HEIGHT);
    tex:SetWidth(width or TABLE_WIDTH);
    tex:SetPoint("TOPLEFT", parent, "TOPLEFT", LEFT_MARGIN, y);

    local c = (rowIndex % 2 == 0) and ROW_BG_EVEN or ROW_BG_ODD;
    tex:SetColorTexture(c[1], c[2], c[3], c[4]);

    return self:Track(tex);
end

-- ============================================================
-- Helper: Create a header row background
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:CreateHeaderBg(parent, y, width, height)
    local tex = parent:CreateTexture(nil, "BACKGROUND");
    tex:SetHeight(height or HEADER_HEIGHT);
    tex:SetWidth(width or TABLE_WIDTH);
    tex:SetPoint("TOPLEFT", parent, "TOPLEFT", LEFT_MARGIN, y);
    tex:SetColorTexture(HEADER_BG_COLOR[1], HEADER_BG_COLOR[2], HEADER_BG_COLOR[3], HEADER_BG_COLOR[4]);

    return self:Track(tex);
end

-- ============================================================
-- Helper: Create a horizontal line
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:CreateHLine(parent, y, width)
    local tex = parent:CreateTexture(nil, "ARTWORK");
    tex:SetHeight(1);
    tex:SetWidth(width or TABLE_WIDTH);
    tex:SetPoint("TOPLEFT", parent, "TOPLEFT", LEFT_MARGIN, y);
    tex:SetColorTexture(GRID_LINE_COLOR[1], GRID_LINE_COLOR[2], GRID_LINE_COLOR[3], GRID_LINE_COLOR[4]);

    return self:Track(tex);
end

-- ============================================================
-- Helper: Create a vertical line
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:CreateVLine(parent, x, y, height)
    local tex = parent:CreateTexture(nil, "ARTWORK");
    tex:SetWidth(1);
    tex:SetHeight(height);
    tex:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y);
    tex:SetColorTexture(GRID_LINE_COLOR[1], GRID_LINE_COLOR[2], GRID_LINE_COLOR[3], GRID_LINE_COLOR[4]);

    return self:Track(tex);
end

-- ============================================================
-- Helper: Section header
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:CreateSectionHeader(parent, text, y)
    self:CreateText(parent, text, "GameFontNormal", LEFT_MARGIN, y, "LEFT", HEADER_COLOR);
    return y - SECTION_HEADER_HEIGHT;
end

-- ============================================================
-- Helper: Render a generic grid table
--   columns = { { x=, width=, justifyH= }, ... }
--   headers = { "Header1", "Header2", ... }
--   rows = function(rowIndex) -> { { text=, color= }, ... } or nil to stop
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:RenderGrid(parent, startY, columns, headers, getRow, numRows)
    local y = startY;

    -- Calculate total table width from columns
    local tableRight = 0;
    for _, col in ipairs(columns) do
        local colRight = col.x + col.width;
        if (colRight > tableRight) then
            tableRight = colRight;
        end
    end
    local gridWidth = tableRight - LEFT_MARGIN;

    -- Header background
    self:CreateHeaderBg(parent, y, gridWidth, HEADER_HEIGHT);

    -- Header text
    for i, col in ipairs(columns) do
        self:CreateText(parent, headers[i], "GameFontNormalSmall", col.x, y, col.justifyH or "CENTER", HEADER_COLOR, col.width, HEADER_HEIGHT);
    end

    -- Horizontal line below header
    y = y - HEADER_HEIGHT;
    self:CreateHLine(parent, y, gridWidth);
    y = y - 1;

    -- Track where the grid body starts for vertical lines
    local gridBodyY = y;

    -- Rows
    for rowIdx = 1, numRows do
        local cells = getRow(rowIdx);
        if (not cells) then
            break;
        end

        -- Row background
        self:CreateRowBg(parent, y, rowIdx, gridWidth, ROW_HEIGHT);

        -- Cell text
        for i, col in ipairs(columns) do
            local cell = cells[i];
            if (cell) then
                self:CreateText(parent, cell.text, "GameFontHighlightSmall", col.x, y, col.justifyH or "CENTER", cell.color, col.width, ROW_HEIGHT);
            end
        end

        y = y - ROW_HEIGHT;

        -- Horizontal line between rows
        if (rowIdx < numRows) then
            self:CreateHLine(parent, y, gridWidth);
        end
    end

    -- Bottom border
    self:CreateHLine(parent, y, gridWidth);

    -- Vertical column separators (full height of grid body)
    local gridHeight = gridBodyY - y;
    for i = 2, #columns do
        self:CreateVLine(parent, columns[i].x, gridBodyY, gridHeight);
    end

    return y;
end

-- ============================================================
-- Render: Upgrade Tracks
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:RenderUpgradeTracks(parent, startY, data)
    local y = self:CreateSectionHeader(parent, L["Upgrade Tracks"], startY);
    y = y - TABLE_TOP_PADDING;

    local columns = {
        { x = LEFT_MARGIN,       width = 45,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + 45,  width = 190, justifyH = "CENTER" },
        { x = LEFT_MARGIN + 235, width = 225, justifyH = "CENTER" },
    };

    local headers = { L["ilvl"], L["Upgrade Track"], L["Crest"] };

    local function getRow(idx)
        local entry = data[idx];
        if (not entry) then return nil; end

        local crestText = entry.crest;
        if (entry.note) then
            crestText = entry.crest .. " - (|cff" .. NOTE_COLOR .. entry.note .. "|r)";
        end

        return {
            { text = tostring(entry.ilvl), color = entry.color },
            { text = entry.track, color = nil },
            { text = crestText, color = nil },
        };
    end

    return self:RenderGrid(parent, y, columns, headers, getRow, #data);
end

-- ============================================================
-- Render: Crafted Item Levels
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:RenderCraftedTable(parent, startY, data)
    local y = self:CreateSectionHeader(parent, L["Crafted Item Levels"], startY);
    y = y - TABLE_TOP_PADDING;

    local col1W = 65;
    local colW = 78;
    local columns = {
        { x = LEFT_MARGIN,             width = col1W, justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W,     width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW,     width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW * 2, width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW * 3, width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW * 4, width = colW,  justifyH = "CENTER" },
    };

    local function getRow(idx)
        local row = data.rows[idx];
        if (not row) then return nil; end

        local qualityIcon = "|A:Professions-Icon-Quality-Tier" .. row.quality .. ":14:14|a";
        local cells = { { text = qualityIcon, color = nil } };

        for _, val in ipairs(row.values) do
            table.insert(cells, { text = tostring(val.ilvl), color = val.color });
        end

        return cells;
    end

    return self:RenderGrid(parent, y, columns, data.headers, getRow, #data.rows);
end

-- ============================================================
-- Render: Dungeon Item Levels
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:RenderDungeonTable(parent, startY, data)
    local y = self:CreateSectionHeader(parent, L["Dungeon Item Levels"], startY);
    y = y - TABLE_TOP_PADDING;

    local col1W = 130;
    local colW = 165;
    local columns = {
        { x = LEFT_MARGIN,             width = col1W, justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W,     width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW, width = colW, justifyH = "CENTER" },
    };

    local function getRow(idx)
        local row = data.rows[idx];
        if (not row) then return nil; end

        return {
            { text = row.source, color = nil },
            { text = tostring(row.endOfRun.ilvl), color = row.endOfRun.color },
            { text = tostring(row.vault.ilvl), color = row.vault.color },
        };
    end

    return self:RenderGrid(parent, y, columns, data.headers, getRow, #data.rows);
end

-- ============================================================
-- Render: Raid Item Levels
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:RenderRaidTable(parent, startY, data)
    local y = self:CreateSectionHeader(parent, L["Raid Item Levels"], startY);
    y = y - TABLE_TOP_PADDING;

    local col1W = 140;
    local colW = 80;
    local columns = {
        { x = LEFT_MARGIN,                    width = col1W, justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W,            width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW,     width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW * 2, width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW * 3, width = colW,  justifyH = "CENTER" },
    };

    local function getRow(idx)
        local row = data.rows[idx];
        if (not row) then return nil; end

        local cells = { { text = row.difficulty, color = nil } };
        for _, val in ipairs(row.values) do
            table.insert(cells, { text = tostring(val.ilvl), color = val.color });
        end

        return cells;
    end

    return self:RenderGrid(parent, y, columns, data.headers, getRow, #data.rows);
end

-- ============================================================
-- Render: Delve Item Levels
-- ============================================================
function KeystoneLootIlvlOverviewFrameMixin:RenderDelveTable(parent, startY, data)
    local y = self:CreateSectionHeader(parent, L["Delve Item Levels"], startY);
    y = y - TABLE_TOP_PADDING;

    local col1W = 50;
    local colW = 136;
    local columns = {
        { x = LEFT_MARGIN,                    width = col1W, justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W,            width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW,     width = colW,  justifyH = "CENTER" },
        { x = LEFT_MARGIN + col1W + colW * 2, width = colW,  justifyH = "CENTER" },
    };

    local function getRow(idx)
        local row = data.rows[idx];
        if (not row) then return nil; end

        local mapText = row.mapDrop and tostring(row.mapDrop.ilvl) or "-";
        local mapColor = row.mapDrop and row.mapDrop.color or nil;

        return {
            { text = row.tier, color = nil },
            { text = tostring(row.endReward.ilvl), color = row.endReward.color },
            { text = mapText, color = mapColor },
            { text = tostring(row.vault.ilvl), color = row.vault.color },
        };
    end

    return self:RenderGrid(parent, y, columns, data.headers, getRow, #data.rows);
end