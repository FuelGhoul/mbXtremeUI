local Bison = LibStub( 'AceAddon-3.0'):GetAddon( 'Bison')
local L = LibStub( 'AceLocale-3.0'):GetLocale( 'Bison')
	
local function OptionTable( name, order)
	return {
		type = 'group', order = order, name = L.OptionName, inline = true, 
		args = {
			show  = { type = 'toggle', order = 1, name = L.ShowName,     desc = L.ShowDesc,     width = 'full', arg = name, get = 'IsVisible',  set = 'ToggleVisible', },
			flash = { type = 'toggle', order = 2, name = L.FlashingName, desc = L.FlashingDesc, width = 'full', arg = name, get = 'IsFlashing', set = 'ToggleFlashing', },
			timer = { type = 'toggle', order = 3, name = L.TimerName,    desc = L.TimerDesc,    width = 'full', arg = name, get = 'IsTimer',    set = 'ToggleTimer', },
			sort  = { type = 'select', order = 4, name = L.SortName,     desc = L.SortDesc,                     arg = name, get = 'GetSort',    set = 'SetSort', values = 'SortTypes', },
		},
	}
end

local function LayoutTable( name, order)
	local max = Bison:GetMaxButton( name)
	return {
		type = 'group', order = order, name = L.BarName, inline = true, 
		args = {
			horizontal = { type = 'toggle', order = 1, name = L.HorizontalName, desc = L.HorizontalDesc, arg = name, get = 'IsHorizontal', set = 'ToggleHorizontal', },
			scale      = { type = 'range',  order = 2, name = L.ScaleName,      desc = L.ScaleDesc,      arg = name, get = 'GetScale',     set = 'SetScale',    min = 0.01, max = 2,   step = 0.01, isPercent = true, },
			cols       = { type = 'range',  order = 3, name = L.ColsName,       desc = L.ColsDesc,       arg = name, get = 'GetCols',      set = 'SetCols',     min = 1,    max = max, step = 1, },
			rows       = { type = 'range',  order = 5, name = L.RowsName,       desc = L.RowsDesc,       arg = name, get = 'GetRows',      set = 'SetRows',     min = 1,    max = max, step = 1, },
			xPadding   = { type = 'range',  order = 4, name = L.XPaddingName,   desc = L.XPaddingDesc,   arg = name, get = 'GetXPadding',  set = 'SetXPadding', min = -20,  max = 20,  step = 1, },
			yPadding   = { type = 'range',  order = 6, name = L.YPaddingName,   desc = L.YPaddingDesc,   arg = name, get = 'GetYPadding',  set = 'SetYPadding', min = -50,  max = 50,  step = 1, },
		},
	}
end

local function BarTable( name, order)
	return {
		type = 'group', order = order, name = name, dialogHidden = true, dialogInline = true, 
		args = {
			option = OptionTable( name, 1),
			layout = LayoutTable( name, 2),
		},
	}
end

local options = {
	type = 'group', name = Bison.localizedname, handler = Bison,
	args = {
		release     = { type = 'description', order = 2,  name = Bison.version, cmdHidden = true, },
		description = { type = 'description', order = 3,  name = L.Description, cmdHidden = true, },
		space 		= { type = 'description', order = 4,  name = '',            cmdHidden = true, },
		enable 		= { type = 'toggle', order = 14, name = L.EnabledName, desc = L.EnabledDesc, width = 'full', get = 'IsEnabled',    set = 'ToggleEnabled', },
		lock 		= { type = 'toggle', order = 15, name = L.LockName,    desc = L.LockDesc,    width = 'full', get = 'IsLocked',     set = 'ToggleLocked', },
		debug 		= { type = 'toggle', order = 16, name = L.DebugName,   desc = L.DebugDesc,   width = 'full', get = 'IsDebug',      set = 'ToggleDebug', },
		version 	= { type = 'toggle', order = 17, name = 'version',     dialogHidden = true, disabled = true, get = 'PrintVersion', set = false, },
		help 		= { type = 'toggle', order = 18, name = 'help',        dialogHidden = true, disabled = true, get = 'PrintHelp',    set = false, },
		buff 		= BarTable( 'buff',   20),
		debuff      = BarTable( 'debuff', 21),
		weapon      = BarTable( 'weapon', 22),
	},
}

local function OnCommand( input)
	if input and input:trim() ~= '' then
		LibStub( 'AceConfigCmd-3.0'):HandleCommand( 'bison', 'bison', input)
	else
		InterfaceOptionsFrame_OpenToCategory( 'Bison')
	end
end

function Bison:InitConfig()
	options.args.profile = LibStub( 'AceDBOptions-3.0'):GetOptionsTable( self.db)
	options.args.profile.dialogHidden = true
	options.args.profile.dialogInline = true
	options.args.profile.args.desc.dialogHidden = true
	LibStub('AceConfig-3.0'):RegisterOptionsTable( 'bison', options)
	local dialog = LibStub( 'AceConfigDialog-3.0')
	dialog:SetDefaultSize( 'Bison', 600, 400)
	dialog:AddToBlizOptions( 'bison', 'Bison')
	dialog:AddToBlizOptions( 'bison', L.BarBuff,   'Bison', 'buff')
	dialog:AddToBlizOptions( 'bison', L.BarDebuff, 'Bison', 'debuff')
	dialog:AddToBlizOptions( 'bison', L.BarWeapon, 'Bison', 'weapon')
	dialog:AddToBlizOptions( 'bison', L.Profile,   'Bison', 'profile')
	self:RegisterChatCommand( 'bison', OnCommand)
	self:RegisterChatCommand( 'bi', OnCommand)
end
