local nibChatTabs = LibStub("AceAddon-3.0"):NewAddon("nibChatTabs", "AceConsole-3.0", "AceEvent-3.0");
local media = LibStub("LibSharedMedia-3.0");
local db;

local TabTextMoved = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false};

local defaults = {
	profile = {
		font = {
			name = "Friz Quadrata TT",
			size = 12,
		},
		textposition = {
			normal = {x = 0, y = 1.5},
			combatlog = {x = 0, y = 0},
		},
		alphas = {
			chatframe = 0,
			nomousealpha = {
				selected = 0,
				normal = 0,
				flash = 1,
			},
			mouseoveralpha = {
				selected = 1,
				normal = .75,
				flash = 1,
			},
		},
		normal = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {r = 0, g = 0, b = 0, a = 1},
				position = {x = 1, y = -1},
			},
			colors = {
				class = {
					enabled = false,
					shade = 0.50,
				},
				r = 0.50, g = 0.50, b = 0.50,
			},
		},
		selected = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {r = 0, g = 0, b = 0, a = 1},
				position = {x = 1, y = -1},
			},
			colors = {
				class = {
					enabled = false,
					shade = .9,
				},
				r = .9, g = .9, b = .9,
			},
		},
		highlight = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {r = 0, g = 0, b = 0, a = 1},
				position = {x = 1, y = -1},
			},
			colors = {
				class = {
					enabled = false,
					shade = 1,
				},
				r = 1, g = 1, b = 1,
			},
		},
		flash = {
			outline = "NONE",
			shadow = {
				useshadow = true,
				color = {r = 0, g = 0, b = 0, a = 1},
				position = {x = 1, y = -1},
			},
			colors = {
				class = {
					enabled = false,
					shade = 1,
				},
				r = 1, g = 1, b = 0.1,
			},
		},
	},
};

local function RetrieveFont(font)
	font = media:Fetch("font", font);
	if font == nil then font = GameFontNormalSmall:GetFont(); end
	return font
end

local function UpdateTabStyle(self, style)
	-- Retrieve FontString of tab
	if(self.GetFontString) then
		self = self:GetFontString();
	else
		self = self:GetParent():GetFontString();
	end

	local cr, cg, cb;
	local styles = {normal = 1, selected = 2, highlight = 3, flash = 4};
	local stylecolors = {r = 0, g = 0, b = 0};
	local shadow = {
		colors = {r = 0, g = 0, b = 0, a = 1},
		position = {x = 0, y = 0},
	};
	
	-- Get Class colors
	local class = select(2, UnitClass("player"));
	local classColors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	cr, cg, cb = classColors.r, classColors.g, classColors.b

	-- Get Style colors
	local styletable;
	if style == "flash" then
		styletable = db.flash;
	elseif style == "selected" then
		styletable = db.selected;
	elseif style == "highlight" then
		styletable = db.highlight;
	else
		styletable = db.normal;
	end
	
	if styletable.colors.class.enabled then
		local shade = styletable.colors.class.shade;
		stylecolors.r = cr * shade; stylecolors.g = cg * shade; stylecolors.b = cb * shade;
	else
		stylecolors.r = styletable.colors.r; stylecolors.g = styletable.colors.g; stylecolors.b = styletable.colors.b;
	end
	
	-- Shadow Color
	if styletable.shadow.useshadow then
		shadow.colors.r, shadow.colors.g, shadow.colors.b, shadow.colors.a = styletable.shadow.color.r, styletable.shadow.color.g, styletable.shadow.color.b, styletable.shadow.color.a; 
		shadow.position.x, shadow.position.y = styletable.shadow.position.x, styletable.shadow.position.y;
	else
		shadow.colors.r, shadow.colors.g, shadow.colors.b, shadow.colors.a = 0, 0, 0, 0;
		shadow.position.x, shadow.position.y = 0, 0;
	end
	
	-- Set new colors
	local font = RetrieveFont(db.font.name);
	self:SetFont(font, db.font.size, styletable.outline);
	self:SetTextColor(stylecolors.r, stylecolors.g, stylecolors.b);
	self:SetShadowColor(shadow.colors.r, shadow.colors.g, shadow.colors.b, shadow.colors.a);
	self:SetShadowOffset(shadow.position.x, shadow.position.y);
end

local function ChatTab_OnLeave(self)
	nibChatTabs:UpdateTabs(true);
end

local function ChatTab_OnEnter(self)
	UpdateTabStyle(self, "highlight");
end

local function ChatTabFlash_OnHide(self)
	UpdateTabStyle(self, "normal");
end

local function ChatTabFlash_OnShow(self)
	UpdateTabStyle(self, "flash");
	UIFrameFlashStop(self.glow);
end

function nibChatTabs:UpdateTabs(SimpleUpdate)
	for i = 1, 10 do
		local chat = _G["ChatFrame"..i];
		local tab = _G["ChatFrame"..i.."Tab"];
		local flash = _G["ChatFrame"..i.."TabFlash"];
		
		if not SimpleUpdate then
			-- Hide regular Chat Tab BG
			_G["ChatFrame"..i.."TabLeft"]:Hide();
			_G["ChatFrame"..i.."TabMiddle"]:Hide();
			_G["ChatFrame"..i.."TabRight"]:Hide();
			
			_G["ChatFrame"..i.."TabHighlightLeft"]:Hide();
			_G["ChatFrame"..i.."TabHighlightMiddle"]:Hide();
			_G["ChatFrame"..i.."TabHighlightRight"]:Hide();
			
			_G["ChatFrame"..i.."TabSelectedLeft"]:Hide();
			_G["ChatFrame"..i.."TabSelectedMiddle"]:Hide();
			_G["ChatFrame"..i.."TabSelectedRight"]:Hide();
			
			tab.leftSelectedTexture:Hide();
			tab.middleSelectedTexture:Hide();
			tab.rightSelectedTexture:Hide();
		
			-- Adjust Text position
			if not TabTextMoved[i] then
				local fs = tab:GetFontString();
				local point, relativeTo, relativePoint, xOfs, yOfs = fs:GetPoint()
				
				local xAdj, yAdj = 0, 0;
				if IsCombatLog(chat) then
					xAdj = db.textposition.combatlog.x;
					yAdj = db.textposition.combatlog.y;
				else
					xAdj = db.textposition.normal.x;
					yAdj = db.textposition.normal.y;
				end
				fs:SetPoint(point, relativeTo, relativePoint, xOfs + xAdj, yOfs + yAdj);
				
				TabTextMoved[i] = true;
			end

			-- Hook Tab
			tab:SetScript("OnEnter", ChatTab_OnEnter);
			tab:SetScript("OnLeave", ChatTab_OnLeave);
		end

		-- Update Tab Appearance
		if(chat == SELECTED_CHAT_FRAME) then
			UpdateTabStyle(tab, "selected");
		elseif tab.alerting then
			UpdateTabStyle(tab, "flash");
		else
			UpdateTabStyle(tab, "normal");
		end
	end
end

function nibChatTabs:UpdateAlphas()
	-- Set alphas
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = db.alphas.nomousealpha.selected;
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = db.alphas.nomousealpha.normal;
	CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = db.alphas.nomousealpha.flash;
	
	CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = db.alphas.mouseoveralpha.selected;
	CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = db.alphas.mouseoveralpha.normal;
	CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = db.alphas.mouseoveralpha.flash;
	
	for i = 1, 10 do
		local chat = _G["ChatFrame"..i];
		FCFTab_UpdateAlpha(chat);
	end
	
	DEFAULT_CHATFRAME_ALPHA = db.alphas.chatframe;
end

local function NewChatWindow()
	nibChatTabs:UpdateTabs(false);
end

local function HookFCF()
	-- Tab Click
	local Orig_FCF_Tab_OnClick = FCF_Tab_OnClick;
	FCF_Tab_OnClick = function(...)
		-- Click the Tab
		Orig_FCF_Tab_OnClick(...);

		nibChatTabs:UpdateTabs(true);
	end

	-- New Window
	hooksecurefunc("FCF_OpenNewWindow", NewChatWindow);
	
	-- Window Close
	hooksecurefunc("FCF_Close", function(self, fallback)
		local frame = fallback or self;
		UIParent.Hide(_G[frame:GetName().."Tab"]);
		FCF_Tab_OnClick(_G["ChatFrame1Tab"], "LeftButton")
	end);
	
	-- Flash
	-- Start
	hooksecurefunc("FCF_StartAlertFlash", function(chatFrame)
		local chatTab = _G[chatFrame:GetName().."Tab"];
		ChatTabFlash_OnShow(chatTab)
	end)
	-- Stop
	hooksecurefunc("FCF_StopAlertFlash", function(chatFrame)
		local chatTab = _G[chatFrame:GetName().."Tab"];
		ChatTabFlash_OnHide(chatTab)
	end)
	
	-- New UpdateColors function, stop it!
	FCFTab_UpdateColors = function(...) end;
end

----
local function ClassColorsUpdate()
	nibChatTabs:UpdateTabs(true);
end

function nibChatTabs:PLAYER_LOGIN()
	nibChatTabs:UpdateTabs(false);
	nibChatTabs:UpdateAlphas();
	GENERAL_CHAT_DOCK.overflowButton:SetAlpha(CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA);
	HookFCF();
	
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate);
	end
end

function nibChatTabs:Refresh()
	db = self.db.profile;
	nibChatTabs:ConfigRefresh();
	
	nibChatTabs:UpdateTabs(false);
	nibChatTabs:UpdateAlphas()
end

function nibChatTabs:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("nibChatTabsDB", defaults, "Default");
	
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh");
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh");
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh");
	
	nibChatTabs:SetUpOptions();
	
	db = self.db.profile;
	
	self:RegisterEvent("PLAYER_LOGIN");
end