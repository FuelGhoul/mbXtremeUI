local nibMicroMenu = LibStub("AceAddon-3.0"):NewAddon("nibMicroMenu", "AceConsole-3.0", "AceEvent-3.0");
local media = LibStub("LibSharedMedia-3.0");
local db;

local defaults = {
	profile = {
		texts = {
			character = "C",
			spellbook = "S",
			talents = "T",
			achievements = "A",
			questlog = "Q",
			guild = "G",
			pvp = "P",
			dungeonfinder = "D",
			helprequest = "?",
		},
		font = {
			size = 12,
			name = "Friz Quadrata TT",
		},
		position = {
			anchorto = "CENTER",
			anchorfrom = "CENTER",
			parent = "UIParent",
			x = 0,
			y = 0,
			orientation = "Horizontal",
			reversed = false,
		},
		microadjustments = {
			x = 0,
			y = 0,
			width = 0,
			height = 0,
		},
		normal = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {
					r = 0,
					g = 0,
					b = 0,
					a = 1,
				},
				position = {
					x = 1,
					y = -1.
				},
			},
			colors = {
				class = {
					enabled = false,
					shade = 0.70,
				},
				r = 0.70,
				g = 0.70,
				b = 0.70,
			},
			opacity = 1,
		},
		highlight = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {
					r = 0,
					g = 0,
					b = 0,
					a = 1,
				},
				position = {
					x = 1,
					y = -1.
				},
			},
			colors = {
				class = {
					enabled = false,
					shade = 1,
				},
				r = 1,
				g = 1,
				b = 1,
			},
			opacity = 1,
		},
		disabled = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {
					r = 0,
					g = 0,
					b = 0,
					a = 1,
				},
				position = {
					x = 1,
					y = -1.
				},
			},
			colors = {
				class = {
					enabled = false,
					shade = .4,
				},
				r = .4,
				g = .4,
				b = .4,
			},
			opacity = 1,
		},
		combatfader = {
			enabled = false,
			opacity = {
				incombat = 1,
				hurt = .7,
				target = .7,
				outofcombat = .3,
			},
		},
	},
};

local NUM_BUTTONS = 9;

local frameMicroMenu;
local mmbuttons = {
	character = {
		frame = nil,
		highlight = false,
		windowopen = false,
	},
	spellbook = {
		frame = nil,
		highlight = false,
		windowopen = false,
	},
	talents = {
		frame = nil,
		highlight = false,
		windowopen = false,
		disabled = false,
	},
	achievements = {
		frame = nil,
		highlight = false,
		windowopen = false,
		disabled = false,
	},
	questlog = {
		frame = nil,
		highlight = false,
		windowopen = false,
	},
	guild = {
		frame = nil,
		highlight = false,
		windowopen = false,
	},
	pvp = {
		frame = nil,
		highlight = false,
		windowopen = false,
		disabled = false,
	},
	dungeonfinder = {
		frame = nil,
		highlight = false,
		windowopen = false,
		disabled = false,
	},
	helprequest = {
		frame = nil,
		highlight = false,
		windowopen = false,
	},
};

local FadeTime = 0.25;
local status;

-- Power 'Full' check
local power_check = {
	MANA = function()
		return UnitMana("player") < UnitManaMax("player")
	end,
	RAGE = function()
		return UnitMana("player") > 0
	end,
	ENERGY = function()
		return UnitMana("player") < UnitManaMax("player")
	end,
	RUNICPOWER = function()
		return UnitMana("player") > 0
	end,
};

-- Fade frame
local function FadeIt(self, NewOpacity)
	local CurrentOpacity = self:GetAlpha();
	if NewOpacity > CurrentOpacity then
		UIFrameFadeIn(self, FadeTime, CurrentOpacity, NewOpacity);
	elseif NewOpacity < CurrentOpacity then
		UIFrameFadeOut(self, FadeTime, CurrentOpacity, NewOpacity);
	end
end

-- Determine new opacity values for frames
function nibMicroMenu:FadeFrames()
	local NewOpacity;

	-- Retrieve opacity/visibility for current status
	NewOpacity = 1;
	if status == "DISABLED" then
		NewOpacity = 1;
	elseif status == "INCOMBAT" then
		NewOpacity = db.combatfader.opacity.incombat;
	elseif status == "TARGET" then
		NewOpacity = db.combatfader.opacity.target;
	elseif status == "HURT" then
		NewOpacity = db.combatfader.opacity.hurt;
	elseif status == "OUTOFCOMBAT" then
		NewOpacity = db.combatfader.opacity.outofcombat;
	end

	-- Fade Frames
	FadeIt(frameMicroMenu, NewOpacity);
end

function nibMicroMenu:UpdateCFStatus()
	local OldStatus = status;
	if not db.combatfader.enabled then
		status = "DISABLED";
	elseif UnitAffectingCombat("player") then
		status = "INCOMBAT";
	elseif UnitExists("target") then
		status = "TARGET";
	elseif UnitHealth("player") < UnitHealthMax("player") then
		status = "HURT";
	else
		local _, power_token = UnitPowerType("player");
		local func = power_check[power_token];
		if func and func() then
			status = "HURT";
		else
			status = "OUTOFCOMBAT";
		end
	end
	if status ~= OldStatus then nibMicroMenu:FadeFrames(); end
end

function nibMicroMenu:UpdateCombatFader()
	status = nil;
	nibMicroMenu:UpdateCFStatus();
end

function nibMicroMenu:UpdateCombatFaderEnabled()
	if db.combatfader.enabled then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCFStatus");
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateCFStatus");
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "UpdateCFStatus");
		self:RegisterEvent("UNIT_HEALTH", "UpdateCFStatus");
		self:RegisterEvent("UNIT_MANA", "UpdateCFStatus");
		self:RegisterEvent("UNIT_RAGE", "UpdateCFStatus");
		self:RegisterEvent("UNIT_ENERGY", "UpdateCFStatus");
		self:RegisterEvent("UNIT_RUNIC_POWER", "UpdateCFStatus");
		self:RegisterEvent("UNIT_DISPLAYPOWER", "UpdateCFStatus");
		
		nibMicroMenu:UpdateCombatFader();
		nibMicroMenu:FadeFrames();
	else
		self:UnregisterEvent("PLAYER_TARGET_CHANGED");
		self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		self:UnregisterEvent("PLAYER_REGEN_DISABLED");
		self:UnregisterEvent("UNIT_HEALTH");
		self:UnregisterEvent("UNIT_MANA");
		self:UnregisterEvent("UNIT_RAGE");
		self:UnregisterEvent("UNIT_ENERGY");
		self:UnregisterEvent("UNIT_RUNIC_POWER");
		self:UnregisterEvent("UNIT_DISPLAYPOWER");
		
		nibMicroMenu:UpdateCombatFader();
		nibMicroMenu:FadeFrames();
	end
end

-- Update Disabled/Pushed state of MM Buttons
local function UpdateButtonState()
	local playerLevel = UnitLevel("player");
	-- Character
	if CharacterFrame:IsShown() then
		mmbuttons.character.windowopen = true;
	else
		mmbuttons.character.windowopen = false;
	end
	
	-- SpellBook
	if SpellBookFrame:IsShown() then
		mmbuttons.spellbook.windowopen = true;
	else
		mmbuttons.spellbook.windowopen = false;
	end

	-- Talents
	if PlayerTalentFrame and PlayerTalentFrame:IsShown() then
		mmbuttons.talents.windowopen = true;
	else
		if playerLevel < TalentMicroButton.minLevel then
			mmbuttons.talents.disabled = true;
		else
			mmbuttons.talents.disabled = false;
			mmbuttons.talents.windowopen = false;
		end
	end
	
	-- Achievements
	if AchievementFrame and AchievementFrame:IsShown() then
		mmbuttons.achievements.windowopen = true;
	else
		if HasCompletedAnyAchievement() and CanShowAchievementUI() then
			mmbuttons.achievements.disabled = false;
			mmbuttons.achievements.windowopen = false;			
		else
			mmbuttons.achievements.disabled = true;
		end
	end

	-- QuestLog
	if QuestLogFrame:IsShown() then
		mmbuttons.questlog.windowopen = true;
	else
		mmbuttons.questlog.windowopen = false;
	end
	
	-- PvP
	if (PVPParentFrame:IsShown() and (not PVPFrame_IsJustBG())) then
		mmbuttons.pvp.windowopen = true;
	else
		if ( playerLevel < PVPMicroButton.minLevel ) then
			mmbuttons.pvp.disabled = true;
		else
			mmbuttons.pvp.disabled = false;
			mmbuttons.pvp.windowopen = false;
		end
	end
	
	-- Social
	if FriendsFrame:IsShown() then
		mmbuttons.guild.windowopen = true;
	else
		mmbuttons.guild.windowopen = false;
	end

	-- LFD
	if LFDParentFrame:IsShown() then
		mmbuttons.dungeonfinder.windowopen = true;
	else
		if playerLevel < LFDMicroButton.minLevel then
			mmbuttons.dungeonfinder.disabled = true;
		else
			mmbuttons.dungeonfinder.disabled = false;
			mmbuttons.dungeonfinder.windowopen = false;
		end
	end

	-- Help Request
	if HelpFrame:IsShown() then
		mmbuttons.helprequest.windowopen = true;
	else
		mmbuttons.helprequest.windowopen = false;
	end
	
	-- Update Buttons with new information
	nibMicroMenu:UpdateButtons();
end

-- OnMouseDown
function nibMicroMenu_ButtonClick(button)
	if button == "character" then
		if not mmbuttons.character.disabled then
			ToggleCharacter("PaperDollFrame");
		end
	elseif button == "spellbook" then
		if not mmbuttons.spellbook.disabled then
			ToggleFrame(SpellBookFrame);
		end
	elseif button == "talents" then
		if not mmbuttons.talents.disabled then
			ToggleTalentFrame();
		end
	elseif button == "achievements" then
		if not mmbuttons.achievements.disabled then
			ToggleAchievementFrame();
		end
	elseif button == "questlog" then
		if not mmbuttons.questlog.disabled then
			ToggleFrame(QuestLogFrame);
		end
	elseif button == "guild" then
		if not mmbuttons.guild.disabled then
			if GetGuildInfo("player") ~= nil then
				ToggleFriendsFrame(3);
			else
				ToggleFriendsFrame();
			end
		end
	elseif button == "pvp" then
		if not mmbuttons.pvp.disabled then
			TogglePVPFrame();
		end
	elseif button == "dungeonfinder" then
		if not mmbuttons.dungeonfinder.disabled then
			ToggleLFDParentFrame();
		end
	elseif button == "helprequest" then
		if not mmbuttons.helprequest.disabled then
			ToggleHelpFrame();
		end
	end	
end

-- OnLeave
function nibMicroMenu_ButtonOnLeave(button)
	if button == "character" then
		mmbuttons.character.highlight = false;
	elseif button == "spellbook" then
		mmbuttons.spellbook.highlight = false;
	elseif button == "talents" then
		mmbuttons.talents.highlight = false;
	elseif button == "achievements" then
		mmbuttons.achievements.highlight = false;
	elseif button == "questlog" then
		mmbuttons.questlog.highlight = false;
	elseif button == "guild" then
		mmbuttons.guild.highlight = false;
	elseif button == "pvp" then
		mmbuttons.pvp.highlight = false;
	elseif button == "dungeonfinder" then
		mmbuttons.dungeonfinder.highlight = false;
	elseif button == "helprequest" then
		mmbuttons.helprequest.highlight = false;
	end	
	nibMicroMenu:UpdateButtons();
end

-- OnEnter
function nibMicroMenu_ButtonOnEnter(button)
	if button == "character" then
		mmbuttons.character.highlight = true;
	elseif button == "spellbook" then
		mmbuttons.spellbook.highlight = true;
	elseif button == "talents" then
		mmbuttons.talents.highlight = true;
	elseif button == "achievements" then
		mmbuttons.achievements.highlight = true;
	elseif button == "questlog" then
		mmbuttons.questlog.highlight = true;
	elseif button == "guild" then
		mmbuttons.guild.highlight = true;
	elseif button == "pvp" then
		mmbuttons.pvp.highlight = true;
	elseif button == "dungeonfinder" then
		mmbuttons.dungeonfinder.highlight = true;
	elseif button == "helprequest" then
		mmbuttons.helprequest.highlight = true;
	end	
	nibMicroMenu:UpdateButtons();
end

local function RetrieveFont(font)
	font = media:Fetch("font", font);
	if font == nil then font = GameFontNormalSmall:GetFont(); end
	return font
end

-- Update Buttons - Font/Colors(Normal, Highlight, Disabled)
function nibMicroMenu:UpdateButtons()
	local cr, cg, cb;
	local styles = {normal = 1, highlight = 2, disabled = 3,};
	local stylecolors = {
		normal = {r = 0, g = 0, b = 0,},
		highlight = {r = 0, g = 0, b = 0,},
		disabled = {r = 0, g = 0, b = 0,},
	};
	local shadow = {
		colors = {
			normal = {r = 0, g = 0, b = 0, a = 1,},
			highlight = {r = 0, g = 0, b = 0, a = 1,},
			disabled = {r = 0, g = 0, b = 0, a = 1,},
		},
		position = {
			normal = {x = 0, y = 0,},
			highlight = {x = 0, y = 0,},
			disabled = {x = 0, y = 0,},
		},
	};
	
	-- Get Button colors
	local class = select(2, UnitClass("player"));
	local classColors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	cr, cg, cb = classColors.r, classColors.g, classColors.b
	
	for k,v in pairs(styles) do
		-- Text Color
		if db[k].colors.class.enabled then
			local shade = db[k].colors.class.shade;
			stylecolors[k].r = cr * shade; stylecolors[k].g = cg * shade; stylecolors[k].b = cb * shade;
		else
			stylecolors[k].r = db[k].colors.r; stylecolors[k].g = db[k].colors.g; stylecolors[k].b = db[k].colors.b;
		end
		
		-- Shadow Color
		if db[k].shadow.useshadow then
			shadow.colors[k].r, shadow.colors[k].g, shadow.colors[k].b, shadow.colors[k].a = db[k].shadow.color.r, db[k].shadow.color.g, db[k].shadow.color.b, db[k].shadow.color.a; 
			shadow.position[k].x, shadow.position[k].y = db[k].shadow.position.x, db[k].shadow.position.y;
		else
			shadow.colors[k].r, shadow.colors[k].g, shadow.colors[k].b, shadow.colors[k].a = 0, 0, 0, 0;
			shadow.position[k].x, shadow.position[k].y = 0, 0;
		end
	end

	local font = RetrieveFont(db.font.name);	
	for k,v in pairs(mmbuttons) do
		local newstyle, newcolors, newshadowcolors, newshadowposition
		if not mmbuttons[k].disabled then
			if mmbuttons[k].highlight or mmbuttons[k].windowopen then
				-- Highlight
				newstyle = db.highlight;
				newcolors = stylecolors.highlight;
				newshadowcolors = shadow.colors.highlight;
				newshadowposition = shadow.position.highlight;
			else
				-- Normal
				newstyle = db.normal;
				newcolors = stylecolors.normal;
				newshadowcolors = shadow.colors.normal;
				newshadowposition = shadow.position.normal;
			end
		else	-- Disable
			newstyle = db.disabled;
			newcolors = stylecolors.disabled;
			newshadowcolors = shadow.colors.disabled;
			newshadowposition = shadow.position.disabled;
		end
		if mmbuttons[k].frame ~= nil then
			mmbuttons[k].frame.text:SetFont(font, db.font.size, newstyle.outline);
			mmbuttons[k].frame.text:SetTextColor(newcolors.r, newcolors.g, newcolors.b, newstyle.opacity);
			mmbuttons[k].frame.text:SetShadowColor(newshadowcolors.r, newshadowcolors.g, newshadowcolors.b, newshadowcolors.a);
			mmbuttons[k].frame.text:SetShadowOffset(newshadowposition.x, newshadowposition.y);
		end
	end
end

-- Set Size
function nibMicroMenu:UpdateSize()
	-- Calculate standard Button height/width based on font
	local fontheight = mmbuttons.character.frame.text:GetHeight();
	local buttonwidth = fontheight + db.microadjustments.width;
	local buttonheight = fontheight + db.microadjustments.height;
	
	-- Set MicroMenu height/width
	local framewidth, frameheight;
	if db.position.orientation == "Horizontal" then
		framewidth = buttonwidth * NUM_BUTTONS;
		frameheight = buttonheight;
	else
		framewidth = buttonwidth;
		frameheight = buttonheight * NUM_BUTTONS;
	end
	frameMicroMenu:SetWidth(framewidth);
	frameMicroMenu:SetHeight(frameheight);
	
	-- Set Button height/width and text position
	for k,v in pairs(mmbuttons) do
		mmbuttons[k].frame:SetWidth(buttonwidth);
		mmbuttons[k].frame:SetHeight(buttonheight);
		mmbuttons[k].frame.text:SetPoint("CENTER", mmbuttons[k].frame, "CENTER", db.microadjustments.x, db.microadjustments.y);
	end
	
	-- Set all Button positions
	local function SetButtonPoint(button, order)
		button:ClearAllPoints();
		if db.position.orientation == "Horizontal" then
			if db.position.reversed then
				button:SetPoint("CENTER", frameMicroMenu, "RIGHT", (buttonwidth / 2) - (buttonwidth * (order + 1)), 0);
			else
				button:SetPoint("CENTER", frameMicroMenu, "LEFT", (buttonwidth / 2) + (buttonwidth * order), 0);
			end
		else
			if db.position.reversed then
				button:SetPoint("CENTER", frameMicroMenu, "TOP", 0, (buttonheight / 2) - (buttonheight * (order + 1)));
			else
				button:SetPoint("CENTER", frameMicroMenu, "BOTTOM", 0, (buttonheight / 2) + (buttonheight * order));
			end
		end
	end
	SetButtonPoint(mmbuttons.character.frame, 0);
	SetButtonPoint(mmbuttons.spellbook.frame, 1);
	SetButtonPoint(mmbuttons.talents.frame, 2);
	SetButtonPoint(mmbuttons.achievements.frame, 3);
	SetButtonPoint(mmbuttons.questlog.frame, 4);
	SetButtonPoint(mmbuttons.guild.frame, 5);
	SetButtonPoint(mmbuttons.pvp.frame, 6);
	SetButtonPoint(mmbuttons.dungeonfinder.frame, 7);
	SetButtonPoint(mmbuttons.helprequest.frame, 8);
end

-- Set Position
function nibMicroMenu:UpdatePosition()
	local Parent = _G[db.position.parent];
	if Parent ~= nil then
		frameMicroMenu:SetParent(db.position.parent);
		frameMicroMenu:ClearAllPoints();
		frameMicroMenu:SetPoint(db.position.anchorfrom, db.position.parent, db.position.anchorto, db.position.x, db.position.y);
		frameMicroMenu:SetFrameStrata(Parent:GetFrameStrata());
		frameMicroMenu:SetFrameLevel(Parent:GetFrameLevel() + 1);
		frameMicroMenu:Show();
	else
		frameMicroMenu:Hide();
	end		
end

-- Set Texts
function nibMicroMenu:UpdateTexts()
	for k,v in pairs(mmbuttons) do
		mmbuttons[k].frame.text:SetText(db.texts[k]);
	end
	nibMicroMenu:UpdateButtons();
	nibMicroMenu:UpdateSize();	
end

local function ClassColorsUpdate()
	nibMicroMenu:UpdateButtons();
end

local function HookMMUpdate()
	hooksecurefunc("UpdateMicroButtons", UpdateButtonState);
end

local function GetFrames()
	frameMicroMenu = getglobal("nibMicroMenu_Frame");

	mmbuttons.character.frame = getglobal("nibMicroMenu_Button_Character");
	mmbuttons.spellbook.frame = getglobal("nibMicroMenu_Button_Spellbook");
	mmbuttons.talents.frame = getglobal("nibMicroMenu_Button_Talents");
	mmbuttons.achievements.frame = getglobal("nibMicroMenu_Button_Achievements");
	mmbuttons.questlog.frame = getglobal("nibMicroMenu_Button_QuestLog");
	mmbuttons.guild.frame = getglobal("nibMicroMenu_Button_Guild");
	mmbuttons.pvp.frame = getglobal("nibMicroMenu_Button_PvP");
	mmbuttons.dungeonfinder.frame = getglobal("nibMicroMenu_Button_DungeonFinder");
	mmbuttons.helprequest.frame = getglobal("nibMicroMenu_Button_HelpRequest");
end

function nibMicroMenu:Refresh()
	db = self.db.profile;
	nibMicroMenu:ConfigRefresh();
	
	nibMicroMenu:UpdatePosition();
	nibMicroMenu:UpdateTexts();
	nibMicroMenu:UpdateButtons();
	
	nibMicroMenu:UpdateCombatFaderEnabled();
end

function nibMicroMenu:EventCheck()
	UpdateButtonState();
end

function nibMicroMenu:PLAYER_LOGIN()
	GetFrames();
	HookMMUpdate();
	nibMicroMenu:Refresh();
	
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate);
	end
end

function nibMicroMenu:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("nibMicroMenuDB", defaults, "Default");
		
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh");
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh");
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh");
	
	nibMicroMenu:SetUpOptions();
	
	db = self.db.profile;
	
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "EventCheck");
	self:RegisterEvent("PLAYER_LEVEL_UP", "EventCheck");
	self:RegisterEvent("UNIT_LEVEL", "EventCheck");
	self:RegisterEvent("RECEIVED_ACHIEVEMENT_LIST", "EventCheck");
	self:RegisterEvent("ACHIEVEMENT_EARNED", "EventCheck");
end