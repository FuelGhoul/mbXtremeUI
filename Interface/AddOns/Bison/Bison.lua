Bison = LibStub( 'AceAddon-3.0'):NewAddon( 'Bison', 'AceEvent-3.0', 'AceConsole-3.0', 'LibDebugLog-1.0')
if not Bison then return end -- already loaded and no upgrade necessary

local L = LibStub( 'AceLocale-3.0'):GetLocale( 'Bison')
local DEFAULTS = { 
	profile = {
		buff   = { xPos = 400, yPos = 500, xPadding = 5, yPadding = 15, scale = 1.0, rows = 2, cols = 16, show = true, flashing = true, timer = true, horizontal = true, sort = 'dec',  style = { 'Blizzard', 0, nil }, },
		debuff = { xPos = 400, yPos = 250, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols = 16, show = true, flashing = true, timer = true, horizontal = true, sort = 'dec',  style = { 'Blizzard', 0, nil }, },
		weapon = { xPos = 400, yPos = 200, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols = 2,  show = true, flashing = true, timer = true, horizontal = true, sort = 'none', style = { 'Blizzard', 0, nil }, },
		locked  = true,
		enabled = true,
		debug   = false,
	} 
}
local MAX_BUTTONS = {
	buff   = 40,
	debuff = 16,
	weapon = 2,
}
local BAR_NAMES = {
	[L.BarBuff]   = 'buff',
	[L.BarDebuff] = 'debuff',
	[L.BarWeapon] = 'weapon',
}
local SORT_TYPES = {
	['none']   = 1,
	['alpha']  = 2,
	['revert'] = 3,
	['inc']    = 4,
	['dec']    = 5,
	['durationasc']  = 6,
	['durationdesc'] = 7,
	
}
local SORT_DESC = {
	[1] = L.SortNone,
	[2] = L.SortAlpha,
	[3] = L.SortRevert,
	[4] = L.SortInc,
	[5] = L.SortDec,
	[6] = L.SortDurationAsc,
	[7] = L.SortDurationDesc
}
local HIDE_BLIZZ_BARS = true -- for tests false
local SUB_HELP_MSG = ' - |cFF33FF99%s|r: %s'

--[[---------------------------------------------------------------------------------
  Class Setup
------------------------------------------------------------------------------------]]
Bison.name, Bison.localizedname = GetAddOnInfo( 'Bison')
Bison.version = format( L.Version, GetAddOnMetadata( 'Bison', 'Version') or 'unknown', RED_FONT_COLOR_CODE, 'WotLK', FONT_COLOR_CODE_CLOSE)

function Bison:OnInitialize()
	self.db = LibStub( 'AceDB-3.0'):New( 'BisonDB', DEFAULTS, 'Default')
	self:ToggleDebugLog( self.db.profile.debug)
	self:InitConfig()
end

function Bison:OnEnable()
	self.buff   = self.BisonBar:NewBuffBar(   self.db.profile.buff,   L.BarBuff)
	self.debuff = self.BisonBar:NewDebuffBar( self.db.profile.debuff, L.BarDebuff)
	self.weapon = self.BisonBar:NewWeaponBar( self.db.profile.weapon, L.BarWeapon)
	self.buff:CreateButtons(   MAX_BUTTONS.buff, 0)
	self.debuff:CreateButtons( MAX_BUTTONS.debuff, 0)
	self.weapon:CreateButtons( MAX_BUTTONS.weapon, 15)
	self:Update()
	self.db.RegisterCallback( self, 'OnNewProfile')
	self.db.RegisterCallback( self, 'OnProfileChanged')
	self.db.RegisterCallback( self, 'OnProfileCopied')
	self.db.RegisterCallback( self, 'OnProfileReset')
	self.db.RegisterCallback( self, 'OnProfileDeleted')
	local LBF = LibStub( 'LibButtonFacade', true)
	if LBF then
		LBF:RegisterSkinCallback( 'Bison', self.OnSkin, self)
	end
	self:Debug( 'Bison enabled')
	self:Print( self.version, 'loaded')
end

function Bison:OnDisable()
	self:HideFrames()
end

function Bison:OnSkin( skin, gloss, backdrop, group, button, colors)
	if group and BAR_NAMES[group] then
		local bar = BAR_NAMES[group]
		local pro = self.db.profile[bar]
		if type(pro.style) ~= 'table' then pro.style = {} end
		pro.style[1] = skin
		pro.style[2] = gloss
		pro.style[3] = backdrop
		pro.style[4] = colors
	end
end

--[[---------------------------------------------------------------------------------
  Main Methods
------------------------------------------------------------------------------------]]
function Bison:Update()
	if self.db.profile.enabled then
		self:ShowFrames()
		self:RestoreSettings()
	else
		self:HideFrames()
	end
end

function Bison:RestoreSettings()
	self.buff:RestoreSettings( self.db.profile.locked, self.db.profile.buff)
	self.debuff:RestoreSettings( self.db.profile.locked, self.db.profile.debuff)
	self.weapon:RestoreSettings( self.db.profile.locked, self.db.profile.weapon)
end

function Bison:ShowFrames()
	self.buff:UpdateVisible( self.db.profile.buff.show)
	self.debuff:UpdateVisible( self.db.profile.debuff.show)
	self.weapon:UpdateVisible( self.db.profile.weapon.show)
	if HIDE_BLIZZ_BARS then
		BuffFrame:Hide()
		TemporaryEnchantFrame:Hide()
	end
end

function Bison:HideFrames()
	self.buff:UpdateVisible( false)
	self.debuff:UpdateVisible( false)
	self.weapon:UpdateVisible( false)
	BuffFrame:Show()
	TemporaryEnchantFrame:Show()
end

function Bison:PrintHelp()
	local function PrintCmd( cmd, desc) self:Print( format( SUB_HELP_MSG, cmd, desc)) end
	self:Print( 'Commands (/bi, /bison)')
	PrintCmd( 'enable', L.EnabledDesc)
	PrintCmd( 'lock', L.LockDesc)
	PrintCmd( 'debug', L.DebugDesc)
	PrintCmd( '<bar> show', L.ShowDesc)
	PrintCmd( '<bar> flashing', L.FlashingDesc)
	PrintCmd( '<bar> timer', L.TimerDesc)
	PrintCmd( '<bar> scale <value>', L.ScaleDesc)
	PrintCmd( '<bar> rows <value>', L.RowsDesc)
	PrintCmd( '<bar> cols <value>', L.ColsDesc)
	PrintCmd( '<bar> horizontal', L.HorizontalDesc)
	PrintCmd( '<bar> xPadding <value>', L.XPaddingDesc)
	PrintCmd( '<bar> yPadding <value>', L.YPaddingDesc)
	PrintCmd( '<bar> sort <value>', L.SortDesc)
	PrintCmd( 'version', L.VersionDesc)
end

function Bison:PrintVersion() 
	self:Print( self.version) 
end

local function GetBar( info)
	return (type(info) == 'table') and info.arg or tostring(info)
end

function Bison:AddButtons( biGrp, info)
	self:Debug(info)
	local bar = GetBar( info)
	self:Debug(bar)
	if self.db.profile[bar] then
		self[bar]:AddButtons( biGrp)
	end
end

--[[---------------------------------------------------------------------------------
  Set/Get Methods
------------------------------------------------------------------------------------]]
function Bison:IsLocked()
	return self.db.profile.locked
end

function Bison:SetLocked( value)
	self.db.profile.locked = value
	self.buff:UpdateLock( value)
	self.debuff:UpdateLock( value)
	self.weapon:UpdateLock( value)
end

function Bison:ToggleLocked() 
	self:SetLocked( not self:IsLocked()) 
end

function Bison:IsDebug()
	return self.db.profile.debug
end

function Bison:SetDebug( value)
	self.db.profile.debug = value
	self:ToggleDebugLog( value)
end

function Bison:ToggleDebug() 
	self:SetDebug( not self:IsDebug()) 
end

function Bison:IsEnabled()
	return self.db.profile.enabled
end

function Bison:SetEnabled( value)
	self.db.profile.enabled = value
	if value then
		self:ShowFrames()
	else
		self:HideFrames()
	end
end

function Bison:ToggleEnabled() 
	self:SetEnabled( not self:IsEnabled()) 
end

function Bison:IsVisible( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].show
end

function Bison:SetVisible( info, value)
	local bar = GetBar( info)
	if self.db.profile[bar] then
		self.db.profile[bar].show = value
		self[bar]:UpdateVisible( value)
	end
end

function Bison:ToggleVisible( info)
	local bar = GetBar( info)
	self:SetVisible( bar, not self:IsVisible( bar))
end

function Bison:IsFlashing( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].flashing
end

function Bison:SetFlashing( info, value)
	local bar = GetBar( info)
	if self.db.profile[bar] then
		self.db.profile[bar].flashing = value
	end
end

function Bison:ToggleFlashing( info) 
	local bar = GetBar( info)
	self:SetFlashing( bar, not self:IsFlashing( bar)) 
end

function Bison:IsTimer( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].timer
end

function Bison:SetTimer( info, value)
	local bar = GetBar( info)
	if self.db.profile[bar] then
		self.db.profile[bar].timer = value
	end
end

function Bison:ToggleTimer( info) 
	local bar = GetBar( info)
	self:SetTimer( bar, not self:IsTimer( bar)) 
end

function Bison:GetScale( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].scale or 1
end

function Bison:SetScale( info, value)
	local bar = GetBar( info)
	value = tonumber(value)
	if self.db.profile[bar] and value and value > 0 and value <= 2 then
		self.db.profile[bar].scale = value
		self[bar]:SetAnchors()
	end
end

function Bison:GetMaxButton( bar)
	return MAX_BUTTONS[bar] or 16
end

function Bison:GetRows( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].rows or 1
end

function Bison:SetRows( info, value)
	local bar = GetBar( info)
	value = tonumber(value)
	if self.db.profile[bar] and value and value > 0 and value <= MAX_BUTTONS[bar] then
		value = math.floor( value)
		self.db.profile[bar].rows = value
		self.db.profile[bar].cols = math.ceil( MAX_BUTTONS[bar] / value)
		self[bar]:SetAnchors()
	end
end

function Bison:GetCols( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].cols or 16
end

function Bison:SetCols( info, value)
	local bar = GetBar( info)
	value = tonumber(value)
	if self.db.profile[bar] and value and value > 0 and value <= MAX_BUTTONS[bar] then
		value = math.floor( value)
		self.db.profile[bar].cols = value
		self.db.profile[bar].rows = math.ceil( MAX_BUTTONS[bar] / value)
		self[bar]:SetAnchors()
	end
end

function Bison:IsHorizontal( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].horizontal
end

function Bison:SetHorizontal( info, value)
	local bar = GetBar( info)
	if self.db.profile[bar] then
		self.db.profile[bar].horizontal = value
		self[bar]:SetAnchors()
	end
end

function Bison:ToggleHorizontal( info) 
	local bar = GetBar( info)
	self:SetHorizontal( bar, not self:IsHorizontal( bar)) 
end

function Bison:GetXPadding( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].xPadding
end

function Bison:SetXPadding( info, value)
	local bar = GetBar( info)
	value = tonumber(value)
	if self.db.profile[bar] and value and value >= -20 and value <= 20 then
		self.db.profile[bar].xPadding = math.floor( value)
		self[bar]:SetAnchors()
	end
end

function Bison:GetYPadding( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and self.db.profile[bar].yPadding
end

function Bison:SetYPadding( info, value)
	local bar = GetBar( info)
	value = tonumber(value)
	if self.db.profile[bar] and value and value >= -50 and value <= 50 then
		self.db.profile[bar].yPadding = math.floor( value)
		self[bar]:SetAnchors()
	end
end

function Bison:GetSort( info)
	local bar = GetBar( info)
	return self.db.profile[bar] and SORT_TYPES[self.db.profile[bar].sort]
end

function Bison:SetSort( info, value)
	local bar = GetBar( info)
	value = tonumber(value)
	if self.db.profile[bar] and value then
		for k,v in pairs(SORT_TYPES) do
			if v == value then
				self.db.profile[bar].sort = k
				self[bar]:Sort()
				self[bar]:SetAnchors()
				break
			end
		end
	end
end

function Bison:SortTypes()
	return SORT_DESC
end

--[[---------------------------------------------------------------------------------
  timer string
------------------------------------------------------------------------------------]]
function BisonDurationString( seconds, timer)
	if not timer then
		return SecondsToTimeAbbrev( seconds)
	end
	if not seconds then
		return ''
	end
	local negative, time
	if seconds < 0 then 
		negative = '-'
		time = -seconds
	else
		negative = ''
		time = seconds
	end
	if time < 60 then 
		return string.format( '|cffffffff%s%ds|r', negative, time) 
	end
	local min = math.floor( time / 60)
	if time < 600 then 
		return string.format( '|cffffffff%s%d:%02d|r', negative, min, time % 60) 
	end
	if time < 3600 then 
		return string.format( '|cffffffff%s%dm|r', negative, min) 
	end
	return string.format( '|cffffffff%s%d:%02dh|r', negative, math.floor( min / 60), min % 60)
end

--[[---------------------------------------------------------------------------------
  Profile Functions
------------------------------------------------------------------------------------]]
function Bison:ListProfiles()
	self:Print( L.AvailableProfiles)
	local current = self.db:GetCurrentProfile()
	for _,name in ipairs(self.db:GetProfiles()) do
		self:Print( format( (name == current) and ' - |cFFFFFF00%s|r' or ' - %s', name))
	end
end

function Bison:OnNewProfile( event, db, name)
	self:Update()
	self:Print( format( L.ProfileCreated, name))
end

function Bison:OnProfileChanged( event, db, name)
	self:Update()
	self:Print( format( L.ProfileLoaded, name))
end

function Bison:OnProfileCopied( event, db, name)
	self:Update()
	self:Print( format( L.ProfileCopied, name))
end

function Bison:OnProfileReset( event, db)
	self:Update()
	self:Print( format( L.ProfileReset, db:GetCurrentProfile()))
end

function Bison:OnProfileDeleted( event, db, name)
	self:Print( format( L.ProfileDeleted, name))
end

--[[---------------------------------------------------------------------------------
create a widget class
------------------------------------------------------------------------------------]]
function Bison:CreateClass( kind, parentClass)
	local class = CreateFrame( kind)
	class.mt = { __index = class }
	if parentClass then
		class = setmetatable( class, { __index = parentClass })
		class.super = parentClass
	end

	function class:Bind( o)
		return setmetatable( o, self.mt)
	end

	return class
end

