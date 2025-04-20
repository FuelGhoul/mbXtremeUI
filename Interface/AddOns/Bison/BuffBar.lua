local Bison = LibStub( 'AceAddon-3.0'):GetAddon( 'Bison')

local UPDATE_TIME_BUFF = 0.2
local UPDATE_TIME_WEAPON = 0.2

--[[---------------------------------------------------------------------------------
  Locals
------------------------------------------------------------------------------------]]
local updateTimeBuff = 0
local updateTimeWeapon = 0.1

--[[---------------------------------------------------------------------------------
  BisonButton
------------------------------------------------------------------------------------]]
local BisonButton = Bison:CreateClass( 'Button')

function BisonButton:New( bar, id, name, template)
	local b = self:Bind( CreateFrame( 'Button', name, bar, template))
	b.bar = bar
 	b.timeLeft = nil
	b:SetID( id)
	b:SetWidth( 30)
	b:SetHeight( 30)
	b.icon = b:CreateTexture( name..'Icon', 'BACKGROUND')
	b.icon:SetPoint( 'TOPRIGHT')
	b.icon:SetPoint( 'BOTTOMLEFT')
	b.count = b:CreateFontString( name..'Count', 'BACKGROUND', 'NumberFontNormal')
	b.count:SetPoint( 'BOTTOMRIGHT', b, 'BOTTOMRIGHT', -2, 2)
	b.left = b:CreateFontString( nil, 'ARTWORK', 'GameFontNormalSmall')
	b.left:SetPoint( 'TOP', b, 'BOTTOM')
	b.ghostlabel = b:CreateFontString( nil, 'OVERLAY', 'GameFontHighlight')
	b.ghostlabel:SetHeight( 10)
	b.ghostlabel:SetPoint( 'TOPRIGHT')
	b.ghostlabel:SetPoint( 'BOTTOMLEFT')
	b.ghosticon = b:CreateTexture( nil, 'OVERLAY')
	b.ghosticon:SetBlendMode( 'ADD')
	b.ghosticon:SetPoint( 'TOPRIGHT')
	b.ghosticon:SetPoint( 'BOTTOMLEFT')
	b.buffFilter = bar.buffFilter
	b:SetScript( 'OnMouseDown', self.OnMouseDown)
	b:SetScript( 'OnMouseUp', self.OnMouseUp)
	b:SetScript( 'OnLeave', self.OnLeave)
	return b
end

function BisonButton:NewBuff( bar, id, name)
	local b = self:New( bar, id, name)-- , 'SecureActionButtonTemplate')
--	b:SetAttribute('type', 'cancelaura')
--	b:SetAttribute('unit', PlayerFrame.unit);
--	b:SetAttribute('index', id);
	b:RegisterForClicks( 'RightButtonUp')
	b:SetScript( 'OnEnter', self.OnEnter)
	b:SetScript( 'OnShow', self.Update)
	b:SetScript( 'OnClick', self.OnClick)
	b:SetScript( 'OnUpdate', self.OnUpdate)
	return b
end

function BisonButton:NewDebuff( bar, id, name)
	local b = self:New( bar, id, name)
	b:AddBorderDebuff()
	b:SetScript( 'OnEnter', self.OnEnter)
	b:SetScript( 'OnShow', self.Update)
	b:SetScript( 'OnUpdate', self.OnUpdate)
	return b
end

function BisonButton:NewWeapon( bar, id, name)
	local b = self:New( bar, id, name) -- , 'SecureActionButtonTemplate')
--	b:SetAttribute('unit', PlayerFrame.unit);
	b:AddBorderWeapon()
	b:RegisterForClicks( 'RightButtonUp')
	b:SetScript( 'OnEnter', self.OnEnterWeapon)
	b:SetScript( 'OnClick', self.OnClickWeapon)
	return b
end

function BisonButton:AddBorderDebuff()
	self.border = self:CreateTexture( self:GetName()..'Border', 'OVERLAY')
	self.border:SetTexture( 'Interface\\Buttons\\UI-Debuff-Overlays')
	self.border:SetTexCoord( 0.296875, 0.5703125, 0, 0.515625)
	self.border:SetAllPoints( self)
--	self.border:SetWidth( 33)
--	self.border:SetHeight( 32)
end

function BisonButton:AddBorderWeapon()
	self.border = self:CreateTexture( self:GetName()..'Border', 'OVERLAY')
	self.border:SetTexture( 'Interface\\Buttons\\UI-TempEnchant-Border')
	self.border:SetAllPoints( self)
--	self.border:SetWidth( 33)
--	self.border:SetHeight( 32)
end

function BisonButton:SetGhost( id, r, g, b)
	self.ghostlabel:SetText( id)
	self.ghosticon:SetTexture( r, g, b, 1)
end

function BisonButton:OnMouseDown()
	self.bar:OnMouseDown()
end

function BisonButton:OnMouseUp()
	self.bar:OnMouseUp()
end

function BisonButton:OnEnter()
	GameTooltip:SetOwner( self, 'ANCHOR_BOTTOMLEFT')
	GameTooltip:SetUnitAura( PlayerFrame.unit, self:GetID(), self.buffFilter)
end

function BisonButton:OnEnterWeapon()
	if self.timeLeft then
		GameTooltip:SetOwner( self, 'ANCHOR_BOTTOMLEFT')
		GameTooltip:SetInventoryItem( PlayerFrame.unit, self:GetID())
	end
end

function BisonButton:OnLeave()
	GameTooltip:Hide()
end

function BisonButton:OnClick()
	CancelUnitBuff( PlayerFrame.unit, self:GetID(), self.buffFilter);
end

function BisonButton:OnClickWeapon()
	CancelItemTempEnchantment( self:GetID() - 15);
end

function BisonButton:OnUpdate( elapsed)
	if self.timeLeft then
		self.timeLeft = max( self.timeLeft - elapsed, 0);
		if updateTimeBuff < 0 then
			self:Duration()
		 	self:Tooltip()
		end
	end
	self:SetFlashing()
end

function BisonButton:Duration()
	if SHOW_BUFF_DURATIONS == '1' and self.timeLeft then
		self.left:SetFormattedText( BisonDurationString( self.timeLeft, self.bar.values.timer))
		if self.timeLeft < BUFF_DURATION_WARNING_TIME then
			self.left:SetVertexColor( HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		else
			self.left:SetVertexColor( NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
		self.left:Show();
	else
		self.left:Hide();
	end
end

function BisonButton:Texture( texture)
	if texture then
		self.icon:SetTexture( texture)
		self.icon:Show()
	else
		self.icon:Hide()
	end
end

function BisonButton:SetFlashing()
	local shouldFlash = self.bar.values.flashing and self.timeLeft
	if shouldFlash then
		if self.duration and self.duration < BUFF_WARNING_TIME then
			shouldFlash = self.timeLeft < self.duration/2
		else
			shouldFlash = self.timeLeft < BUFF_WARNING_TIME
		end
	end

	if shouldFlash then
		if not UIFrameIsFading(self) then
			UIFrameFlash(self, 0.2, 0.2, self.timeLeft, true, 0, 0.7)
		end
	else
		self:SetAlpha(1)
		UIFrameFlashRemoveFrame(self)
	end
end

function BisonButton:Count( count)
	if count and count > 1 then
		self.count:SetText( count)
		self.count:Show()
	else
		self.count:Hide()
	end
end

function BisonButton:Border( name, type)
	if self.border then
		if type then
			local color = DebuffTypeColor[type]
			self.border:SetVertexColor( color.r, color.g, color.b, 1)
		elseif name then
			local color = DebuffTypeColor['none']
			self.border:SetVertexColor( color.r, color.g, color.b, 1)
		else
			self.border:SetVertexColor( 0, 0, 0, 0)
		end
	end
end

function BisonButton:Tooltip()
	if GameTooltip:IsOwned( self) then
		GameTooltip:SetUnitAura( PlayerFrame.unit, self:GetID(), self.buffFilter)
	end
end

function BisonButton:TooltipWeapon()
	if GameTooltip:IsOwned( self) then
		GameTooltip:SetInventoryItem( PlayerFrame.unit, self:GetID())
	end
end

function BisonButton:Update()
 	local name, rank, texture, count, debuffType, duration, expiration = UnitAura( PlayerFrame.unit, self:GetID(), self.buffFilter)
 	if name then
		self.buffName = name
		self.duration = duration
		if duration > 0 and expiration then
			self.timeLeft = expiration - GetTime()
		else
			self.timeLeft = nil
		end
		self:Duration()
	 	self:Texture( texture)
		self:SetFlashing()
	 	self:Count( count)
	 	self:Border( name, debuffType)
	 	self:Show()
	 	self:Tooltip()
	else
		self.buffName = nil
		self.timeLeft = nil
		self.duration = nil
		self:Duration()
		self:Texture( nil)
	 	self:Count( 0)
	 	self:Border( nil, nil)
		if Bison:IsLocked() then
			self:Hide()
		end
		if GameTooltip:IsOwned( self) then
			GameTooltip:Hide( )
		end
	end
end

function BisonButton:UpdateWeapon( hasEnchant, timeLeft, charges)
	if hasEnchant then
		self.buffName = ''
		self.timeLeft = timeLeft and (timeLeft / 1000)
		self.duration = 0
		self:Duration()
	 	self:Texture( GetInventoryItemTexture( PlayerFrame.unit, self:GetID()))
	 	self:Count( charges)
		self:Show()
	 	self:TooltipWeapon()
	else
		self.buffName = nil
		self.timeLeft = nil
		self:Duration()
		self:Texture( nil)
	 	self:Count( 0)
		if Bison:IsLocked() then
			self:Hide()
		end
	end
end

--[[---------------------------------------------------------------------------------
  Sort Function
------------------------------------------------------------------------------------]]
local function sortNone( a, b)
	if not a then return false end
	if not b then return true end
	return a:GetID() < b:GetID()
end

local function sortNameAsc( a, b)
	if not a then return false end
	if not b then return true end
	if a.buffName and b.buffName then return a.buffName < b.buffName end
	if a.buffName then return true end
	if b.buffName then return false end
	return a:GetID() < b:GetID()
end

local function sortNameDesc( a, b)
	if not a then return false end
	if not b then return true end
	if a.buffName and b.buffName then return a.buffName > b.buffName end
	if a.buffName then return true end
	if b.buffName then return false end
	return a:GetID() < b:GetID()
end

local function sortTimeLeftAsc( a, b)
	if not a then return false end
	if not b then return true end
	if a.buffName and b.buffName then
		if a.timeLeft and b.timeLeft then return a.timeLeft < b.timeLeft end
		if a.timeLeft then return true end
		if b.timeLeft then return false end
		return a.buffName > b.buffName
	end
	if a.buffName then return true end
	if b.buffName then return false end
	return a:GetID() < b:GetID()
end

local function sortTimeLeftDesc( a, b)
	if not a then return false end
	if not b then return true end
	if a.buffName and b.buffName then
		if a.timeLeft and b.timeLeft then return a.timeLeft > b.timeLeft end
		if a.timeLeft then return false end
		if b.timeLeft then return true end
		return a.buffName < b.buffName
	end
	if a.buffName then return true end
	if b.buffName then return false end
	return a:GetID() < b:GetID()
end

local function sortDurationAsc( a, b)
	if not a then return false end
	if not b then return true end
	if a.buffName and b.buffName then
		if a.duration and b.duration then return a.duration < b.duration end
		if a.duration then return true end
		if b.duration then return false end
		return a.buffName > b.buffName
	end
	if a.buffName then return true end
	if b.buffName then return false end
	return a:GetID() < b:GetID()
end

local function sortDurationDesc( a, b)
	if not a then return false end
	if not b then return true end
	if a.buffName and b.buffName then
		if a.duration and b.duration then return a.duration > b.duration end
		if a.duration then return true end
		if b.duration then return false end
		return a.buffName > b.buffName
	end
	if a.buffName then return true end
	if b.buffName then return false end
	return a:GetID() < b:GetID()
end

local SORT = {
	['none']   = sortNone,
	['alpha']  = sortNameAsc,
	['revert'] = sortNameDesc,
	['inc']    = sortTimeLeftAsc,
	['dec']    = sortTimeLeftDesc,
	['durationasc']  = sortDurationAsc,
	['durationdesc'] = sortDurationDesc,
}

--[[---------------------------------------------------------------------------------
BisonBar
------------------------------------------------------------------------------------]]
local LBF = LibStub('LibButtonFacade', true)
local BisonBar = Bison:CreateClass( 'Frame')
Bison.BisonBar = BisonBar

function BisonBar:New( values, barName)
	local f = self:Bind( CreateFrame( 'Frame', nil, UIParent))
	f:SetToplevel( true)
	f:SetFrameStrata( 'LOW')
	f:SetWidth( 65)
	f:SetHeight( 40)
--	f:AddHelpTexture() -- only for test
	f.buttons = {}
	f.values  = values
	f.barName = barName
	return f
end

function BisonBar:AddHelpTexture()
	local tex = self:CreateTexture( nil, 'OVERLAY')
	tex:SetBlendMode( 'ADD')
	tex:SetTexture( 1, 0, 0, 1)
	tex:SetPoint( 'TOPRIGHT')
	tex:SetPoint( 'BOTTOMLEFT')
end

function BisonBar:NewBuffBar( values, barName)
	local f = self:New( values, barName)
	f:RegisterEvent( 'UNIT_AURA')
	f:SetScript( 'OnEvent', self.OnEvent)
	f:SetScript( 'OnUpdate', self.OnUpdate)
	f.name    = 'buff'
	f.buffFilter = 'HELPFUL'
	return f
end

function BisonBar:NewDebuffBar( values, barName)
	local f = self:New( values, barName)
	f:RegisterEvent( 'UNIT_AURA')
	f:SetScript( 'OnEvent', self.OnEvent)
	f.name    = 'debuff'
	f.buffFilter = 'HARMFUL'
	return f
end

function BisonBar:NewWeaponBar( values, barName)
	local f = self:New( values, barName)
	f:SetScript( 'OnUpdate', self.OnUpdateWeapon)
	f.name    = 'weapon'
	f.buffFilter = nil
	return f
end

function BisonBar:CreateButtons( size, offset)
	for i = 1, size do
		local b
		if self.name == 'buff' then
			b = BisonButton:NewBuff( self, i + offset, 'BisonBuff'..i)
			b:SetGhost( tostring( b:GetID()), 0.2, 0.8, 0.2)
		elseif self.name == 'debuff' then
			b = BisonButton:NewDebuff( self, i + offset, 'BisonDebuff'..i)
			b:SetGhost( tostring( b:GetID()), 0.8, 0.2, 0.2)
		elseif self.name == 'weapon' then
			b = BisonButton:NewWeapon( self, i + offset, 'BisonWeapon'..i)
			b:SetGhost( (b:GetID() == 17) and 'MH' or 'OH', 0.2, 0.2, 0.2)
		end
		b:Update()
		table.insert( self.buttons, b)
		if LBF then
			LBF:Group( 'Bison', self.barName):AddButton( b)
		end
	end
end

function BisonBar:OnEvent( event, unit)
	if event == 'UNIT_AURA' and unit == PlayerFrame.unit then
		for _, b in pairs( self.buttons) do
			b:Update()
		end
	end
	self:Sort()
	self:SetAnchors()
end

function BisonBar:OnUpdate( elapsed)
	if updateTimeBuff < 0 then
		updateTimeBuff = updateTimeBuff + UPDATE_TIME_BUFF
	else
		updateTimeBuff = updateTimeBuff - elapsed
	end
end

function BisonBar:OnUpdateWeapon( elapsed)
	local btnMain, btnOff = self.buttons[1], self.buttons[2]
	if btnMain:GetID() == 17 then
		btnMain, btnOff = btnOff, btnMain
	end
	if updateTimeWeapon < 0 then
		updateTimeWeapon = updateTimeWeapon + UPDATE_TIME_WEAPON
		local mainEnchant, mainExpiration, mainCharges, offEnchant, offExpiration, offCharges = GetWeaponEnchantInfo()
		btnMain:UpdateWeapon( mainEnchant, mainExpiration, mainCharges)
		btnOff:UpdateWeapon( offEnchant, offExpiration, offCharges)
	else
		updateTimeWeapon = updateTimeWeapon - elapsed
	end
	btnMain:SetFlashing()
	btnOff:SetFlashing()
end

function BisonBar:AddButtons( biGrp)
	for i,b in pairs( self.buttons) do
		biGrp:AddButton( b)
	end
end

function BisonBar:Sort()
	table.sort( self.buttons, SORT[self.values.sort])
end

function BisonBar:RestoreSettings( locked, values)
	self.values = values
	self:ClearAllPoints()
	self:SetPoint( 'BOTTOMLEFT', UIParent, 'BOTTOMLEFT', self.values.xPos, self.values.yPos)
	self:SetAnchors()
	self:UpdateLock( locked)
	if LBF then
		LBF:Group( 'Bison', self.barName):Skin( unpack( values.style))
	end
end

function BisonBar:SetAnchors()
	local last, lastFirst
	local row = 1
	local col = 1
	for i,b in pairs( self.buttons) do
		b:ClearAllPoints()
		if last and lastFirst then
			if self.values.horizontal then
				if self.values.xPadding < 0 then
					b:SetPoint( 'LEFT', last, 'RIGHT', -self.values.xPadding, 0)
				else
					b:SetPoint( 'RIGHT', last, 'LEFT', -self.values.xPadding, 0)
				end
			else
				if self.values.yPadding < 0 then
					b:SetPoint( 'BOTTOM', last, 'TOP', 0, -self.values.yPadding)
				else
					b:SetPoint( 'TOP', last, 'BOTTOM', 0, -self.values.yPadding)
				end
			end
			last = b
		elseif lastFirst then
			if self.values.horizontal then
				if self.values.yPadding < 0 then
					b:SetPoint( 'BOTTOM', lastFirst, 'TOP', 0, -self.values.yPadding)
				else
					b:SetPoint( 'TOP', lastFirst, 'BOTTOM', 0, -self.values.yPadding)
				end
			else
				if self.values.xPadding < 0 then
					b:SetPoint( 'LEFT', lastFirst, 'RIGHT', -self.values.xPadding, 0)
				else
					b:SetPoint( 'RIGHT', lastFirst, 'LEFT', -self.values.xPadding, 0)
				end
			end
			lastFirst = b
			last = b
		else
			if self.values.xPadding < 0 then
				if self.values.yPadding < 0 then
					b:SetPoint( 'BOTTOMLEFT', self)
				else
					b:SetPoint( 'TOPLEFT', self)
				end
			else
				if self.values.yPadding < 0 then
					b:SetPoint( 'BOTTOMRIGHT', self)
				else
					b:SetPoint( 'TOPRIGHT', self)
				end
			end
			lastFirst = b
			last = b
		end
		b:SetScale( self.values.scale)
		if self.values.horizontal then
			col = col + 1
			if col > self.values.cols then
				col = 1
				last = nil
			end
		else
			row = row + 1
			if row > self.values.rows then
				row = 1
				last = nil
			end
		end
	end
end

function BisonBar:UpdateVisible( show)
	if show then
		self:Show()
	else
		self:Hide()
	end
end

function BisonBar:UpdateLock( locked)
	if locked then
		self:SetMovable( false)
		for i, b in pairs( self.buttons) do
			if not b.icon:GetTexture() then
				b:Hide()
			end
			b.ghostlabel:Hide()
			b.ghosticon:Hide()
		end
	else
		self:SetMovable( true)
		for i, b in pairs( self.buttons) do
			b:Show()
			b.ghostlabel:Show()
			b.ghosticon:Show()
		end
	end
end

function BisonBar:OnMouseDown()
	if self:IsMovable() then
		self:StartMoving()
	end
end

function BisonBar:OnMouseUp()
	if self:IsMovable() then
		self:StopMovingOrSizing()
		self.values.xPos = self:GetLeft()
		self.values.yPos = self:GetBottom()
	end
end
