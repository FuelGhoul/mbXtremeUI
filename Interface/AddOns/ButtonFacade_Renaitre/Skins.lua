--[[ Renaitre ]]

local LBF = LibStub("LibButtonFacade", true)
if not LBF then
	return
end

-- Renaitre: Circle
LBF:AddSkin("Renaitre: Circle", {

	-- Skin data start.
	Backdrop = {
		Width = 44,
		Height = 44,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Backdrop]],
	},
	Icon = {
		Width = 26,
		Height = 26,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 44,
		Height = 44,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Overlay]],
	},
	Cooldown = {
		Width = 26,
		Height = 26,
	},
	AutoCast = {
		Width = 24,
		Height = 24,
		OffsetX = 1,
		OffsetY = -1,
		AboveNormal = true,
	},
	Normal = {
		Width = 44,
		Height = 44,
		Static = true,
		Color = {0.30, 0.30, 0.30, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Normal]],
	},
	Pushed = {
		Width = 44,
		Height = 44,
		Color = {0.15, 0.42, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Overlay]],
	},
	Border = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		--Color = {0.02, 0.37, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Border]],
	},
	Disabled = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		--Color = {1, 0.05, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Border]],
	},
	Checked = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0, 0.12, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Border]],
	},
	AutoCastable = {
		Width = 48,
		Height = 48,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0.75, 0, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Highlight]],
	},
	Gloss = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0.7, 0.6, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle\Gloss]],
	},
	HotKey = {
		Width = 44,
		Height = 10,
		OffsetX = -12,
		OffsetY = 12,
	},
	Count = {
		Width = 44,
		Height = 10,
		OffsetX = -12,
		OffsetY = -12,
	},
	Name = {
		Width = 44,
		Height = 12,
		OffsetY = -12,
	},
	-- Skin data end.

}, true)

-- Renaitre: Square
LBF:AddSkin("Renaitre: Square", {

	-- Skin data start.
	Backdrop = {
		Width = 44,
		Height = 44,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Backdrop]],
	},
	Icon = {
		Width = 30,
		Height = 30,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 44,
		Height = 44,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Overlay]],
	},
	Cooldown = {
		Width = 30,
		Height = 30,
	},
	AutoCast = {
		Width = 30,
		Height = 30,
		OffsetX = 1,
		OffsetY = -1,
		AboveNormal = true,
	},
	Normal = {
		Width = 44,
		Height = 44,
		Static = true,
		Color = {0.3, 0.3, 0.3, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Normal]],
	},
	Pushed = {
		Width = 44,
		Height = 44,
		Color = {.15, 0.42, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Overlay]],
	},
	Border = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		--Color = {0.02, 0.37, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Border]],
	},
	Disabled = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		--Color = {1, 0.5, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Border]],
	},
	Checked = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0, 0.12, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Border]],
	},
	AutoCastable = {
		Width = 48,
		Height = 48,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0.75, 0, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Highlight]],
	},
	Gloss = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0.7, 0.6, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Square\Gloss]],
	},
	HotKey = {
		Width = 44,
		Height = 10,
		OffsetX = -6,
		OffsetY = 10,
	},
	Count = {
		Width = 44,
		Height = 10,
		OffsetX = -6,
		OffsetY = -10,
	},
	Name = {
		Width = 44,
		Height = 10,
		OffsetY = -10,
	},
	-- Skin data end.

}, true)

-- Renaitre: Circle2
LBF:AddSkin("Renaitre: Circle2", {

	-- Skin data start.
	Backdrop = {
		Width = 44,
		Height = 44,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Backdrop]],
	},
	Icon = {
		Width = 26,
		Height = 26,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 44,
		Height = 44,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Overlay]],
	},
	Cooldown = {
		Width = 26,
		Height = 26,
	},
	AutoCast = {
		Width = 24,
		Height = 24,
		OffsetX = 1,
		OffsetY = -1,
		AboveNormal = true,
	},
	Normal = {
		Width = 44,
		Height = 44,
		Static = true,
		Color = {0.30, 0.30, 0.30, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Normal]],
	},
	Pushed = {
		Width = 44,
		Height = 44,
		Color = {0.15, 0.42, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Overlay]],
	},
	Border = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		--Color = {0.02, 0.37, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Border]],
	},
	Disabled = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		--Color = {1, 0.05, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Border]],
	},
	Checked = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0, 0.12, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Border]],
	},
	AutoCastable = {
		Width = 48,
		Height = 48,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0.75, 0, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Highlight]],
	},
	Gloss = {
		Width = 44,
		Height = 44,
		BlendMode = "ADD",
		Color = {0.7, 0.6, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_Renaitre\Textures\Circle2\Gloss]],
	},
	HotKey = {
		Width = 44,
		Height = 10,
		OffsetX = -12,
		OffsetY = 12,
	},
	Count = {
		Width = 44,
		Height = 10,
		OffsetX = -12,
		OffsetY = -12,
	},
	Name = {
		Width = 44,
		Height = 12,
		OffsetY = -12,
	},
	-- Skin data end.

}, true)
