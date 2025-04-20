local nibMicroMenu = LibStub("AceAddon-3.0"):GetAddon("nibMicroMenu");
local db;

local table_AnchorPoints = {
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
};

local table_Orientation = {
	"Horizontal",
	"Vertical",
};

local table_Outline = {
	"NONE",
	"OUTLINE",
	"THICKOUTLINE",
};

local function ValidateOffset(value)
	val = tonumber(value);
	if val == nil then val = 0; end;
	if val < -5000 then val = 5000 elseif val > 5000 then val = 5000; end;
	return val;
end

-- Return the Options table
local options = nil;
local function GetOptions()
	if not options then
		options = {
			name = "nibMicroMenu",
			handler = nibMicroMenu,
			type = "group",
			childGroups = "tab",
			args = {
				textsfont = {
					name = "Texts/Font",
					type = "group",
					order = 10,
					args = {
						buttontext_area = {
							name = "Button Texts",
							type = "group",
							inline = true,
							order = 10,
							args = {
								character = {
									type = "input",
									name = "Character Screen",
									width = "half",
									order = 10,
									get = function(info) return db.texts.character end,
									set = function(info, value)	db.texts.character = value; nibMicroMenu:UpdateTexts(); end,
								},
								spellbook = {
									type = "input",
									name = "Spell Book",
									width = "half",
									order = 20,
									get = function(info) return db.texts.spellbook end,
									set = function(info, value)	db.texts.spellbook = value; nibMicroMenu:UpdateTexts(); end,
								},
								talents = {
									type = "input",
									name = "Talents",
									width = "half",
									order = 30,
									get = function(info) return db.texts.talents end,
									set = function(info, value)	db.texts.talents = value; nibMicroMenu:UpdateTexts(); end,
								},
								achievements = {
									type = "input",
									name = "Achievements",
									width = "half",
									order = 40,
									get = function(info) return db.texts.achievements end,
									set = function(info, value)	db.texts.achievements = value; nibMicroMenu:UpdateTexts(); end,
								},
								questlog = {
									type = "input",
									name = "Quest Log",
									width = "half",
									order = 50,
									get = function(info) return db.texts.questlog end,
									set = function(info, value)	db.texts.questlog = value; nibMicroMenu:UpdateTexts(); end,
								},
								guild = {
									type = "input",
									name = "Guild/Social",
									width = "half",
									order = 60,
									get = function(info) return db.texts.guild end,
									set = function(info, value)	db.texts.guild = value; nibMicroMenu:UpdateTexts(); end,
								},
								pvp = {
									type = "input",
									name = "PvP",
									width = "half",
									order = 70,
									get = function(info) return db.texts.pvp end,
									set = function(info, value)	db.texts.pvp = value; nibMicroMenu:UpdateTexts(); end,
								},
								dungeonfinder = {
									type = "input",
									name = "LFG/LFM",
									width = "half",
									order = 80,
									get = function(info) return db.texts.dungeonfinder end,
									set = function(info, value)	db.texts.dungeonfinder = value; nibMicroMenu:UpdateTexts(); end,
								},
								helprequest = {
									type = "input",
									name = "Help/GM",
									width = "half",
									order = 90,
									get = function(info) return db.texts.helprequest end,
									set = function(info, value)	db.texts.helprequest = value; nibMicroMenu:UpdateTexts(); end,
								},
							},
						},
						font_area = {
							name = "Font",
							type = "group",
							inline = true,
							order = 20,
							args = {
								fontname = {
									type = "select",
									name = "Font name",
									values = AceGUIWidgetLSMlists.font,
									get = function()
										return db.font.name
									end,
									set = function(info, value)
										db.font.name = value
										nibMicroMenu:UpdateTexts()
									end,
									dialogControl='LSM30_Font',
									order = 10,
								},
								fontsize = {
									type = "range",
									name = "Font Size",
									min = 6, max = 36, step = 1,
									get = function(info) return db.font.size end,
									set = function(info, value) db.font.size = value; nibMicroMenu:UpdateTexts(); end,
									order = 20,
								},
							},
						},
					},
				},
				positionsize = {
					name = "Position/Size",
					type = "group",
					order = 20,
					args = {
						micromenuposition_area = {
							name = "MicroMenu Position",
							type = "group",
							inline = true,
							order = 10,
							args = {
								xoffset = {
									type = "input",
									name = "X Offset",
									width = "half",
									order = 10,
									get = function(info) return tostring(db.position.x) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.position.x = value
										nibMicroMenu:UpdatePosition()
									end,
								},
								yoffset = {
									type = "input",
									name = "Y Offset",
									width = "half",
									order = 20,
									get = function(info) return tostring(db.position.y) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.position.y = value
										nibMicroMenu:UpdatePosition()
									end,
								},
								anchorto = {
									type = "select",
									name = "Anchor To",
									get = function(info) 
										for k,v in pairs(table_AnchorPoints) do
											if v == db.position.anchorto then return k end
										end
									end,
									set = function(info, value)
										db.position.anchorto = table_AnchorPoints[value]
										nibMicroMenu:UpdatePosition()
									end,
									style = "dropdown",
									width = nil,
									values = table_AnchorPoints,
									order = 30,
								},
								anchorfrom = {
									type = "select",
									name = "Anchor From",
									get = function(info) 
										for k,v in pairs(table_AnchorPoints) do
											if v == db.position.anchorfrom then return k end
										end
									end,
									set = function(info, value)
										db.position.anchorfrom = table_AnchorPoints[value]
										nibMicroMenu:UpdatePosition()
									end,
									style = "dropdown",
									width = nil,
									values = table_AnchorPoints,
									order = 40,
								},
								parent = {
									type = "input",
									name = "Parent Frame",
									get = function(info) return db.position.parent end,
									set = function(info, value) db.position.parent = value; nibMicroMenu:UpdatePosition(); end,
									order = 50,
								},
							},
						},
						micromenualignment_area = {
							name = "MicroMenu Alignment",
							type = "group",
							inline = true,
							order = 20,
							args = {
								orientation = {
									type = "select",
									name = "Orientation",
									get = function(info) 
										for k,v in pairs(table_Orientation) do
											if v == db.position.orientation then return k end
										end
									end,
									set = function(info, value)
										db.position.orientation = table_Orientation[value]
										nibMicroMenu:UpdateSize()
									end,
									style = "dropdown",
									width = nil,
									values = table_Orientation,
									order = 10,
								},
								reversed = {
									name = "Reversed",
									type = "toggle",
									get = function(info) return db.position.reversed end,
									set = function(info, value) db.position.reversed = value; nibMicroMenu:UpdateSize(); end,
									order = 20,
								},		
							},
						},
						microadjustments_area = {
							type = "group",
							name = "Micro Adjustments",
							inline = true,
							order = 30,
							args = {
								header1 = {
									type = "description",
									name = "Micro adjustments for Texts. Use these if the font you use ends up being out of place slightly.",
									order = 10,
								},
								sep1 = {
									type = "description",
									name = " ",
									order = 20,
								},
								xoffset = {
									type = "input",
									name = "Text X Offset",
									order = 30,
									get = function(info) return tostring(db.microadjustments.x) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.microadjustments.x = value
										nibMicroMenu:UpdateSize()
									end,
								},
								yoffset = {
									type = "input",
									name = "Text Y Offset",
									order = 40,
									get = function(info) return tostring(db.microadjustments.y) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.microadjustments.y = value
										nibMicroMenu:UpdateSize()
									end,
								},
								width = {
									type = "range",
									name = "Button Width (+/-)",
									min = -32,
									max = 32,
									step = 1,
									get = function(info) return db.microadjustments.width end,
									set = function(info, value) db.microadjustments.width = value; nibMicroMenu:UpdateSize(); end,
									order = 50,
								},
								height = {
									type = "range",
									name = "Button Height (+/-)",
									min = -32,
									max = 32,
									step = 1,
									get = function(info) return db.microadjustments.height end,
									set = function(info, value) db.microadjustments.height = value; nibMicroMenu:UpdateSize(); end,
									order = 60,
								},
							},
						},
					},
				},
				styles = {
					type = "group",
					name = "Styles",
					childGroups = "tab",
					order = 30,
					args = {
						normalstyle = {
							type = "group",
							name = "Normal Style",
							order = 10,
							childGroups = "tab",
							args = {
								textcolor = {
									type = "group",
									name = "Text Color",
									order = 10,
									args = {
										color = {
											type = "color",
											name = "Normal color",
											hasAlpha = false,
											get = function(info,r,g,b)
												return db.normal.colors.r, db.normal.colors.g, db.normal.colors.b
											end,
											set = function(info,r,g,b)
												db.normal.colors.r = r
												db.normal.colors.g = g
												db.normal.colors.b = b
												nibMicroMenu:UpdateButtons()
											end,
											disabled = function()
												if db.normal.colors.class.enabled then return true else return false; end 
											end,
											order = 10,
										},
										classcolor_area = {
											type = "group",
											name = "Class Color",
											inline = true,
											order = 20,
											args = {			
												useclasscolor = {
													name = "Use Class Color",
													type = "toggle",
													get = function(info) return db.normal.colors.class.enabled end,
													set = function(info, value) db.normal.colors.class.enabled = value; nibMicroMenu:UpdateButtons(); end,
													order = 10,
												},											
												classshade = {
													name = "Shade",
													type = "range",
													desc = "Adjust how dark the Class Color will appear.",
													min = 0,
													max = 1,
													step = 0.05,
													isPercent = true,
													get = function(info) return db.normal.colors.class.shade end,
													set = function(info, value) db.normal.colors.class.shade = value; nibMicroMenu:UpdateButtons(); end,
													disabled = function() if db.normal.colors.class.enabled then return false else return true end end,
													order = 20,
												},
											},
										},
									},
								},
								fontstyle = {
									type = "group",
									name = "Font Style",
									order = 20,
									args = {
										shadow_area = {
											name = "Shadow",
											type = "group",
											inline = true,
											order = 10,
											args = {
												useshadow = {
													name = "Use Shadow",
													type = "toggle",
													get = function(info) return db.normal.shadow.useshadow end,
													set = function(info, value) db.normal.shadow.useshadow = value; nibMicroMenu:UpdateButtons(); end,
													order = 10,							
												},
												offsets = {
													name = "Position",
													type = "group",
													inline = true,
													disabled = function() if db.normal.shadow.useshadow then return false else return true end end,
													order = 20,
													args = {
														shadowx = {
															type = "range",
															name = "X Offset",
															min = -8,
															max = 8,
															step = 1,
															get = function(info) return db.normal.shadow.position.x end,
															set = function(info, value) db.normal.shadow.position.x = value; nibMicroMenu:UpdateButtons(); end,
															order = 10,
														},
														shadowy = {
															type = "range",
															name = "Y Offset",
															min = -8,
															max = 8,
															step = 1,
															get = function(info) return db.normal.shadow.position.y end,
															set = function(info, value) db.normal.shadow.position.y = value; nibMicroMenu:UpdateButtons(); end,
															order = 20,
														},
													},
												},
												color = {
													name = "Color",
													type = "color",
													hasAlpha = true,
													get = function(info,r,g,b,a)
														return db.normal.shadow.color.r, db.normal.shadow.color.g, db.normal.shadow.color.b, db.normal.shadow.color.a
													end,
													set = function(info,r,g,b,a)
														db.normal.shadow.color.r = r
														db.normal.shadow.color.g = g
														db.normal.shadow.color.b = b
														db.normal.shadow.color.a = a
														nibMicroMenu:UpdateButtons()
													end,
													disabled = function() if db.normal.shadow.useshadow then return false else return true end end,
													order = 30,
												},
											},
										},
										outline = {
											type = "group",
											name = "Outline",
											inline = true,
											order = 20,
											args = {
												style = {
													type = "select",
													name = "Style",
													values = table_Outline,
													get = function()
														for k,v in pairs(table_Outline) do
															if v == db.normal.outline then return k end
														end
													end,
													set = function(info, value)
														db.normal.outline = table_Outline[value]
														nibMicroMenu:UpdateButtons()
													end,
													order = 10,
												},
											},
										},
									},
								},						
								opacity = {
									type = "group",
									name = "Opacity",
									order = 30,
									args = {
										opacity = {
											type = "range",
											name = "Opacity",
											min = 0,
											max = 1,
											step = 0.05,
											isPercent = true,
											get = function(info) return db.normal.opacity end,
											set = function(info, value) db.normal.opacity = value; nibMicroMenu:UpdateButtons(); end,
											order = 10,
										},
									},
								},
							},
						},
						highlightstyle = {
							type = "group",
							name = "Highlight Style",
							order = 20,
							childGroups = "tab",
							args = {
								textcolor = {
									type = "group",
									name = "Text Color",
									order = 10,
									args = {
										color = {
											type = "color",
											name = "Highlight color",
											hasAlpha = false,
											get = function(info,r,g,b)
												return db.highlight.colors.r, db.highlight.colors.g, db.highlight.colors.b
											end,
											set = function(info,r,g,b)
												db.highlight.colors.r = r
												db.highlight.colors.g = g
												db.highlight.colors.b = b
												nibMicroMenu:UpdateButtons()
											end,
											disabled = function()
												if db.highlight.colors.class.enabled then return true else return false; end 
											end,
											order = 10,
										},
										classcolor_area = {
											type = "group",
											name = "Class Color",
											inline = true,
											order = 20,
											args = {			
												useclasscolor = {
													name = "Use Class Color",
													type = "toggle",
													get = function(info) return db.highlight.colors.class.enabled end,
													set = function(info, value) db.highlight.colors.class.enabled = value; nibMicroMenu:UpdateButtons(); end,
													order = 10,
												},											
												classshade = {
													name = "Shade",
													type = "range",
													desc = "Adjust how dark the Class Color will appear.",
													min = 0,
													max = 1,
													step = 0.05,
													isPercent = true,
													get = function(info) return db.highlight.colors.class.shade end,
													set = function(info, value) db.highlight.colors.class.shade = value; nibMicroMenu:UpdateButtons(); end,
													disabled = function() if db.highlight.colors.class.enabled then return false else return true end end,
													order = 20,
												},
											},
										},
									},
								},
								fontstyle = {
									type = "group",
									name = "Font Style",
									order = 20,
									args = {
										shadow_area = {
											name = "Shadow",
											type = "group",
											inline = true,
											order = 10,
											args = {
												useshadow = {
													name = "Use Shadow",
													type = "toggle",
													get = function(info) return db.highlight.shadow.useshadow end,
													set = function(info, value) db.highlight.shadow.useshadow = value; nibMicroMenu:UpdateButtons(); end,
													order = 10,							
												},
												offsets = {
													name = "Position",
													type = "group",
													inline = true,
													disabled = function() if db.highlight.shadow.useshadow then return false else return true end end,
													order = 20,
													args = {
														shadowx = {
															type = "range",
															name = "X Offset",
															min = -8,
															max = 8,
															step = 1,
															get = function(info) return db.highlight.shadow.position.x end,
															set = function(info, value) db.highlight.shadow.position.x = value; nibMicroMenu:UpdateButtons(); end,
															order = 10,
														},
														shadowy = {
															type = "range",
															name = "Y Offset",
															min = -8,
															max = 8,
															step = 1,
															get = function(info) return db.highlight.shadow.position.y end,
															set = function(info, value) db.highlight.shadow.position.y = value; nibMicroMenu:UpdateButtons(); end,
															order = 20,
														},
													},
												},
												color = {
													name = "Color",
													type = "color",
													hasAlpha = true,
													get = function(info,r,g,b,a)
														return db.highlight.shadow.color.r, db.highlight.shadow.color.g, db.highlight.shadow.color.b, db.highlight.shadow.color.a
													end,
													set = function(info,r,g,b,a)
														db.highlight.shadow.color.r = r
														db.highlight.shadow.color.g = g
														db.highlight.shadow.color.b = b
														db.highlight.shadow.color.a = a
														nibMicroMenu:UpdateButtons()
													end,
													disabled = function() if db.highlight.shadow.useshadow then return false else return true end end,
													order = 30,
												},
											},
										},
										outline = {
											type = "group",
											name = "Outline",
											inline = true,
											order = 20,
											args = {
												style = {
													type = "select",
													name = "Style",
													values = table_Outline,
													get = function()
														for k,v in pairs(table_Outline) do
															if v == db.highlight.outline then return k end
														end
													end,
													set = function(info, value)
														db.highlight.outline = table_Outline[value]
														nibMicroMenu:UpdateButtons()
													end,
													order = 10,
												},
											},
										},
									},
								},						
								opacity = {
									type = "group",
									name = "Opacity",
									order = 30,
									args = {
										opacity = {
											type = "range",
											name = "Opacity",
											min = 0,
											max = 1,
											step = 0.05,
											isPercent = true,
											get = function(info) return db.highlight.opacity end,
											set = function(info, value) db.highlight.opacity = value; nibMicroMenu:UpdateButtons(); end,
											order = 10,
										},
									},
								},
							},
						},
						disabledstyle = {
							type = "group",
							name = "Disabled Style",
							order = 30,
							childGroups = "tab",
							args = {
								textcolor = {
									type = "group",
									name = "Text Color",
									order = 10,
									args = {
										color = {
											type = "color",
											name = "Disabled color",
											hasAlpha = false,
											get = function(info,r,g,b)
												return db.disabled.colors.r, db.disabled.colors.g, db.disabled.colors.b
											end,
											set = function(info,r,g,b)
												db.disabled.colors.r = r
												db.disabled.colors.g = g
												db.disabled.colors.b = b
												nibMicroMenu:UpdateButtons()
											end,
											disabled = function()
												if db.disabled.colors.class.enabled then return true else return false; end 
											end,
											order = 10,
										},
										classcolor_area = {
											type = "group",
											name = "Class Color",
											inline = true,
											order = 20,
											args = {			
												useclasscolor = {
													name = "Use Class Color",
													type = "toggle",
													get = function(info) return db.disabled.colors.class.enabled end,
													set = function(info, value) db.disabled.colors.class.enabled = value; nibMicroMenu:UpdateButtons(); end,
													order = 10,
												},											
												classshade = {
													name = "Shade",
													type = "range",
													desc = "Adjust how dark the Class Color will appear.",
													min = 0,
													max = 1,
													step = 0.05,
													isPercent = true,
													get = function(info) return db.disabled.colors.class.shade end,
													set = function(info, value) db.disabled.colors.class.shade = value; nibMicroMenu:UpdateButtons(); end,
													disabled = function() if db.disabled.colors.class.enabled then return false else return true end end,
													order = 20,
												},
											},
										},
									},
								},
								fontstyle = {
									type = "group",
									name = "Font Style",
									order = 20,
									args = {
										shadow_area = {
											name = "Shadow",
											type = "group",
											inline = true,
											order = 10,
											args = {
												useshadow = {
													name = "Use Shadow",
													type = "toggle",
													get = function(info) return db.disabled.shadow.useshadow end,
													set = function(info, value) db.disabled.shadow.useshadow = value; nibMicroMenu:UpdateButtons(); end,
													order = 10,							
												},
												offsets = {
													name = "Position",
													type = "group",
													inline = true,
													disabled = function() if db.disabled.shadow.useshadow then return false else return true end end,
													order = 20,
													args = {
														shadowx = {
															type = "range",
															name = "X Offset",
															min = -8,
															max = 8,
															step = 1,
															get = function(info) return db.disabled.shadow.position.x end,
															set = function(info, value) db.disabled.shadow.position.x = value; nibMicroMenu:UpdateButtons(); end,
															order = 10,
														},
														shadowy = {
															type = "range",
															name = "Y Offset",
															min = -8,
															max = 8,
															step = 1,
															get = function(info) return db.disabled.shadow.position.y end,
															set = function(info, value) db.disabled.shadow.position.y = value; nibMicroMenu:UpdateButtons(); end,
															order = 20,
														},
													},
												},
												color = {
													name = "Color",
													type = "color",
													hasAlpha = true,
													get = function(info,r,g,b,a)
														return db.disabled.shadow.color.r, db.disabled.shadow.color.g, db.disabled.shadow.color.b, db.disabled.shadow.color.a
													end,
													set = function(info,r,g,b,a)
														db.disabled.shadow.color.r = r
														db.disabled.shadow.color.g = g
														db.disabled.shadow.color.b = b
														db.disabled.shadow.color.a = a
														nibMicroMenu:UpdateButtons()
													end,
													disabled = function() if db.disabled.shadow.useshadow then return false else return true end end,
													order = 30,
												},
											},
										},
										outline = {
											type = "group",
											name = "Outline",
											inline = true,
											order = 20,
											args = {
												style = {
													type = "select",
													name = "Style",
													values = table_Outline,
													get = function()
														for k,v in pairs(table_Outline) do
															if v == db.disabled.outline then return k end
														end
													end,
													set = function(info, value)
														db.disabled.outline = table_Outline[value]
														nibMicroMenu:UpdateButtons()
													end,
													order = 10,
												},
											},
										},
									},
								},						
								opacity = {
									type = "group",
									name = "Opacity",
									order = 30,
									args = {
										opacity = {
											type = "range",
											name = "Opacity",
											min = 0,
											max = 1,
											step = 0.05,
											isPercent = true,
											get = function(info) return db.disabled.opacity end,
											set = function(info, value) db.disabled.opacity = value; nibMicroMenu:UpdateButtons(); end,
											order = 10,
										},
									},
								},
							},
						},
					},
				},
				combatfader = {
					type = "group",
					name = "Combat Fader",
					childGroups = "tab",
					order = 40,
					args = {
						header = {
							type = "header",
							name = "Combat Fader",
							order = 10,
						},
						desc = {
							type = "description",
							name = "Controls the fading of the MicroMenu based on player status.",
							order = 20,
						},
						enabled = {
							type = "toggle",
							name = "Enabled",
							desc = "Enable/Disable combat fading.",
							get = function() return db.combatfader.enabled end,
							set = function(info, value) 
								db.combatfader.enabled = value
								nibMicroMenu:UpdateCombatFaderEnabled()
							end,
							order = 30,
						},
						opacity = {
							type = "group",
							name = "Opacity",
							inline = true,
							disabled = function() if db.combatfader.enabled then return false else return true end end,
							order = 30,
							args = {
								incombat = {
									type = "range",
									name = "In-combat",
									min = 0, max = 1, step = 0.05,
									isPercent = true,
									get = function(info) return db.combatfader.opacity.incombat end,
									set = function(info, value) db.combatfader.opacity.incombat = value; nibMicroMenu:UpdateCombatFader(); end,
									order = 10,
								},
								hurt = {
									type = "range",
									name = "Hurt",
									min = 0, max = 1, step = 0.05,
									isPercent = true,
									get = function(info) return db.combatfader.opacity.hurt end,
									set = function(info, value) db.combatfader.opacity.hurt = value; nibMicroMenu:UpdateCombatFader(); end,
									order = 20,
								},
								target = {
									type = "range",
									name = "Target-selected",
									min = 0, max = 1, step = 0.05,
									isPercent = true,
									get = function(info) return db.combatfader.opacity.target end,
									set = function(info, value) db.combatfader.opacity.target = value; nibMicroMenu:UpdateCombatFader(); end,
									order = 30,
								},
								outofcombat = {
									type = "range",
									name = "Out-of-combat",
									min = 0, max = 1, step = 0.05,
									isPercent = true,
									get = function(info) return db.combatfader.opacity.outofcombat end,
									set = function(info, value) db.combatfader.opacity.outofcombat = value; nibMicroMenu:UpdateCombatFader(); end,
									order = 40,
								},
							},
						},
					},
				},
			},
		};				
	end
	return options
end

function nibMicroMenu:ChatCommand(input)
	InterfaceOptionsFrame_OpenToCategory(self.profilesFrame)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	InterfaceOptionsFrame:Raise()
end

function nibMicroMenu:ConfigRefresh()
	db = self.db.profile;
end

function nibMicroMenu:SetUpOptions()
	db = self.db.profile;

	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibMicroMenu", GetOptions);
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibMicroMenu-Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db));
	
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibMicroMenu", "nibMicroMenu");
	self.profilesFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibMicroMenu-Profiles", "Profiles", "nibMicroMenu");
	
	self:RegisterChatCommand("nibmicromenu", "ChatCommand");
end