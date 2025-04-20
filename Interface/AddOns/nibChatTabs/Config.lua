local nibChatTabs = LibStub("AceAddon-3.0"):GetAddon("nibChatTabs");
local db

-- Options
local table_Outline = {
	"NONE",
	"OUTLINE",
	"THICKOUTLINE",
};

local options;
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "nibChatTabs",
		childGroups = "tab",
		args = {
			font = {
				name = "Font",
				type = "group",
				childGroups = "tab",
				order = 10,
				args = {
					fontname = {
						type = "select",
						name = "Font Name",
						values = AceGUIWidgetLSMlists.font,
						get = function()
							return db.font.name
						end,
						set = function(info, value)
							db.font.name = value
							nibChatTabs:UpdateTabs()
						end,
						dialogControl='LSM30_Font',
						order = 10,
					},
					fontsize = {
						type = "range",
						name = "Font Size",
						min = 6, max = 36, step = 1,
						get = function(info) return db.font.size end,
						set = function(info, value)
							db.font.size = value
							nibChatTabs:UpdateTabs()
						end,
						order = 20,
					},
				},
			},
			textposition = {
				name = "Text Position",
				type = "group",
				order = 20,
				args = {
					note = {
						type = "description",
						name = "Note: Position changes won't take effect until you Log Out or Reload the UI.",
						order = 10,
					},
					normal = {
						name = "Regular Tabs",
						type = "group",
						inline = true,
						order = 20,
						args = {
							xoffset = {
								type = "range",
								name = "X Offset",
								min = -10, max = 10, step = 0.5,
								get = function(info) return db.textposition.normal.x end,
								set = function(info, value)
									db.textposition.normal.x = value
								end,
								order = 10,
							},
							yoffset = {
								type = "range",
								name = "Y Offset",
								min = -10, max = 10, step = 0.5,
								get = function(info) return db.textposition.normal.y end,
								set = function(info, value)
									db.textposition.normal.y = value
								end,
								order = 20,
							},
						},
					},
					combatlog = {
						name = "Combat Log Tab",
						type = "group",
						inline = true,
						order = 30,
						args = {
							xoffset = {
								type = "range",
								name = "X Offset",
								min = -10, max = 10, step = 0.5,
								get = function(info) return db.textposition.combatlog.x end,
								set = function(info, value)
									db.textposition.combatlog.x = value
								end,
								order = 10,
							},
							yoffset = {
								type = "range",
								name = "Y Offset",
								min = -10, max = 10, step = 0.5,
								get = function(info) return db.textposition.combatlog.y end,
								set = function(info, value)
									db.textposition.combatlog.y = value
								end,
								order = 20,
							},
						},
					},
				},
			},
			alphas = {
				type = "group",
				name = "Opacity",
				childGroups = "tab",
				order = 30,
				args = {
					tabs = {
						type = "group",
						name = "Chat Tabs",
						order = 10,
						args = {
							nomousealpha = {
								type = "group",
								name = "No Mouse Alpha",
								inline = true,
								order = 10,
								args = {
									selected = {
										type = "range",
										name = "Selected",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.alphas.nomousealpha.selected end,
										set = function(info, value) db.alphas.nomousealpha.selected = value; nibChatTabs:UpdateAlphas(); end,
										order = 10,
									},
									normal = {
										type = "range",
										name = "Normal",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.alphas.nomousealpha.normal end,
										set = function(info, value) db.alphas.nomousealpha.normal = value; nibChatTabs:UpdateAlphas(); end,
										order = 20,
									},
									flash = {
										type = "range",
										name = "Flash",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.alphas.nomousealpha.flash end,
										set = function(info, value) db.alphas.nomousealpha.flash = value; nibChatTabs:UpdateAlphas(); end,
										order = 30,
									},
								},
							},
							mouseoveralpha = {
								type = "group",
								name = "Mouse Over Alpha",
								inline = true,
								order = 20,
								args = {
									selected = {
										type = "range",
										name = "Selected",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.alphas.mouseoveralpha.selected end,
										set = function(info, value) db.alphas.mouseoveralpha.selected = value; nibChatTabs:UpdateAlphas(); end,
										order = 10,
									},
									normal = {
										type = "range",
										name = "Normal",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.alphas.mouseoveralpha.normal end,
										set = function(info, value) db.alphas.mouseoveralpha.normal = value; nibChatTabs:UpdateAlphas(); end,
										order = 20,
									},
									flash = {
										type = "range",
										name = "Flash",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.alphas.mouseoveralpha.flash end,
										set = function(info, value) db.alphas.mouseoveralpha.flash = value; nibChatTabs:UpdateAlphas(); end,
										order = 30,
									},
								},
							},
						},
					},
					chatframe = {
						type = "group",
						name = "Chat Frame",
						order = 20,
						args = {
							selected = {
								type = "range",
								name = "Background Alpha",
								min = 0, max = 1, step = 0.05,
								isPercent = true,
								get = function(info) return db.alphas.chatframe end,
								set = function(info, value) db.alphas.chatframe = value; nibChatTabs:UpdateAlphas(); end,
								order = 10,
							},
						},
					},
				},
			},
			styles = {
				type = "group",
				name = "Styles",
				childGroups = "tab",
				order = 40,
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
											nibChatTabs:UpdateTabs()
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
												set = function(info, value) db.normal.colors.class.enabled = value; nibChatTabs:UpdateTabs(); end,
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
												set = function(info, value) db.normal.colors.class.shade = value; nibChatTabs:UpdateTabs(); end,
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
												set = function(info, value) db.normal.shadow.useshadow = value; nibChatTabs:UpdateTabs(); end,
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
														set = function(info, value) db.normal.shadow.position.x = value; nibChatTabs:UpdateTabs(); end,
														order = 10,
													},
													shadowy = {
														type = "range",
														name = "Y Offset",
														min = -8,
														max = 8,
														step = 1,
														get = function(info) return db.normal.shadow.position.y end,
														set = function(info, value) db.normal.shadow.position.y = value; nibChatTabs:UpdateTabs(); end,
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
													nibChatTabs:UpdateTabs()
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
													nibChatTabs:UpdateTabs()
												end,
												order = 10,
											},
										},
									},
								},
							},						
						},
					},
					selectedstyle = {
						type = "group",
						name = "Selected Style",
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
										name = "Selected color",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.selected.colors.r, db.selected.colors.g, db.selected.colors.b
										end,
										set = function(info,r,g,b)
											db.selected.colors.r = r
											db.selected.colors.g = g
											db.selected.colors.b = b
											nibChatTabs:UpdateTabs()
										end,
										disabled = function()
											if db.selected.colors.class.enabled then return true else return false; end 
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
												get = function(info) return db.selected.colors.class.enabled end,
												set = function(info, value) db.selected.colors.class.enabled = value; nibChatTabs:UpdateTabs(); end,
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
												get = function(info) return db.selected.colors.class.shade end,
												set = function(info, value) db.selected.colors.class.shade = value; nibChatTabs:UpdateTabs(); end,
												disabled = function() if db.selected.colors.class.enabled then return false else return true end end,
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
												get = function(info) return db.selected.shadow.useshadow end,
												set = function(info, value) db.selected.shadow.useshadow = value; nibChatTabs:UpdateTabs(); end,
												order = 10,							
											},
											offsets = {
												name = "Position",
												type = "group",
												inline = true,
												disabled = function() if db.selected.shadow.useshadow then return false else return true end end,
												order = 20,
												args = {
													shadowx = {
														type = "range",
														name = "X Offset",
														min = -8,
														max = 8,
														step = 1,
														get = function(info) return db.selected.shadow.position.x end,
														set = function(info, value) db.selected.shadow.position.x = value; nibChatTabs:UpdateTabs(); end,
														order = 10,
													},
													shadowy = {
														type = "range",
														name = "Y Offset",
														min = -8,
														max = 8,
														step = 1,
														get = function(info) return db.selected.shadow.position.y end,
														set = function(info, value) db.selected.shadow.position.y = value; nibChatTabs:UpdateTabs(); end,
														order = 20,
													},
												},
											},
											color = {
												name = "Color",
												type = "color",
												hasAlpha = true,
												get = function(info,r,g,b,a)
													return db.selected.shadow.color.r, db.selected.shadow.color.g, db.selected.shadow.color.b, db.selected.shadow.color.a
												end,
												set = function(info,r,g,b,a)
													db.selected.shadow.color.r = r
													db.selected.shadow.color.g = g
													db.selected.shadow.color.b = b
													db.selected.shadow.color.a = a
													nibChatTabs:UpdateTabs()
												end,
												disabled = function() if db.selected.shadow.useshadow then return false else return true end end,
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
														if v == db.selected.outline then return k end
													end
												end,
												set = function(info, value)
													db.selected.outline = table_Outline[value]
													nibChatTabs:UpdateTabs()
												end,
												order = 10,
											},
										},
									},
								},
							},						
						},
					},
					highlightstyle = {
						type = "group",
						name = "Highlight Style",
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
										name = "Highlight color",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.highlight.colors.r, db.highlight.colors.g, db.highlight.colors.b
										end,
										set = function(info,r,g,b)
											db.highlight.colors.r = r
											db.highlight.colors.g = g
											db.highlight.colors.b = b
											nibChatTabs:UpdateTabs()
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
												set = function(info, value) db.highlight.colors.class.enabled = value; nibChatTabs:UpdateTabs(); end,
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
												set = function(info, value) db.highlight.colors.class.shade = value; nibChatTabs:UpdateTabs(); end,
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
												set = function(info, value) db.highlight.shadow.useshadow = value; nibChatTabs:UpdateTabs(); end,
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
														set = function(info, value) db.highlight.shadow.position.x = value; nibChatTabs:UpdateTabs(); end,
														order = 10,
													},
													shadowy = {
														type = "range",
														name = "Y Offset",
														min = -8,
														max = 8,
														step = 1,
														get = function(info) return db.highlight.shadow.position.y end,
														set = function(info, value) db.highlight.shadow.position.y = value; nibChatTabs:UpdateTabs(); end,
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
													nibChatTabs:UpdateTabs()
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
													nibChatTabs:UpdateTabs()
												end,
												order = 10,
											},
										},
									},
								},
							},						
						},
					},
					flashstyle = {
						type = "group",
						name = "Flash Style",
						order = 40,
						childGroups = "tab",
						args = {
							textcolor = {
								type = "group",
								name = "Text Color",
								order = 10,
								args = {
									color = {
										type = "color",
										name = "Flash color",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.flash.colors.r, db.flash.colors.g, db.flash.colors.b
										end,
										set = function(info,r,g,b)
											db.flash.colors.r = r
											db.flash.colors.g = g
											db.flash.colors.b = b
											nibChatTabs:UpdateTabs()
										end,
										disabled = function()
											if db.flash.colors.class.enabled then return true else return false; end 
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
												get = function(info) return db.flash.colors.class.enabled end,
												set = function(info, value) db.flash.colors.class.enabled = value; nibChatTabs:UpdateTabs(); end,
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
												get = function(info) return db.flash.colors.class.shade end,
												set = function(info, value) db.flash.colors.class.shade = value; nibChatTabs:UpdateTabs(); end,
												disabled = function() if db.flash.colors.class.enabled then return false else return true end end,
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
												get = function(info) return db.flash.shadow.useshadow end,
												set = function(info, value) db.flash.shadow.useshadow = value; nibChatTabs:UpdateTabs(); end,
												order = 10,							
											},
											offsets = {
												name = "Position",
												type = "group",
												inline = true,
												disabled = function() if db.flash.shadow.useshadow then return false else return true end end,
												order = 20,
												args = {
													shadowx = {
														type = "range",
														name = "X Offset",
														min = -8,
														max = 8,
														step = 1,
														get = function(info) return db.flash.shadow.position.x end,
														set = function(info, value) db.flash.shadow.position.x = value; nibChatTabs:UpdateTabs(); end,
														order = 10,
													},
													shadowy = {
														type = "range",
														name = "Y Offset",
														min = -8,
														max = 8,
														step = 1,
														get = function(info) return db.flash.shadow.position.y end,
														set = function(info, value) db.flash.shadow.position.y = value; nibChatTabs:UpdateTabs(); end,
														order = 20,
													},
												},
											},
											color = {
												name = "Color",
												type = "color",
												hasAlpha = true,
												get = function(info,r,g,b,a)
													return db.flash.shadow.color.r, db.flash.shadow.color.g, db.flash.shadow.color.b, db.flash.shadow.color.a
												end,
												set = function(info,r,g,b,a)
													db.flash.shadow.color.r = r
													db.flash.shadow.color.g = g
													db.flash.shadow.color.b = b
													db.flash.shadow.color.a = a
													nibChatTabs:UpdateTabs()
												end,
												disabled = function() if db.flash.shadow.useshadow then return false else return true end end,
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
														if v == db.flash.outline then return k end
													end
												end,
												set = function(info, value)
													db.flash.outline = table_Outline[value]
													nibChatTabs:UpdateTabs()
												end,
												order = 10,
											},
										},
									},
								},
							},						
						},
					},
				},
			},
		},
	};
	end
	return options;
end

function nibChatTabs:ChatCommand(input)
	InterfaceOptionsFrame_OpenToCategory(self.profilesFrame)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	InterfaceOptionsFrame:Raise()
end

function nibChatTabs:ConfigRefresh()
	db = self.db.profile;
end

function nibChatTabs:SetUpOptions()
	db = self.db.profile;

	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibChatTabs", GetOptions);
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibChatTabs-Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db));
	
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibChatTabs", "nibChatTabs");
	self.profilesFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibChatTabs-Profiles", "Profiles", "nibChatTabs");
	
	self:RegisterChatCommand("nibchattabs", "ChatCommand");
	self:RegisterChatCommand("nibct", "ChatCommand");
end