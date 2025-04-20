
Grid2DB = {
	["namespaces"] = {
		["Grid2Layout"] = {
			["profiles"] = {
				["mbXtremeUI 6.0"] = {
					["BackgroundTexture"] = "None",
					["layouts"] = {
						["party"] = "By Group 5",
						["solo"] = "None",
						["raid10"] = "By Group 10",
						["arena"] = "By Group 5",
						["raid25"] = "By Group 25",
						["raid15"] = "By Group 15",
					},
					["BackgroundB"] = 0.1019607843137255,
					["BorderTexture"] = "None",
					["BackgroundG"] = 0.1019607843137255,
					["PosY"] = -406.9341015831843,
					["BackgroundA"] = 0,
					["horizontal"] = false,
					["BackgroundR"] = 0.1019607843137255,
					["PosX"] = 1034.756809414847,
				},
				["Testingui - Icecrown"] = {
					["BackgroundG"] = 0.1019607843137255,
					["BackgroundTexture"] = "None",
					["PosY"] = -406.9341015831843,
					["layouts"] = {
						["party"] = "By Group 5",
						["solo"] = "None",
						["raid10"] = "By Group 10",
						["arena"] = "By Group 5",
						["raid25"] = "By Group 25",
						["raid15"] = "By Group 15",
					},
					["BackgroundB"] = 0.1019607843137255,
					["BackgroundA"] = 0,
					["BorderTexture"] = "None",
					["horizontal"] = false,
					["PosX"] = 1034.756809414847,
					["BackgroundR"] = 0.1019607843137255,
				},
			},
		},
		["LibDualSpec-1.0"] = {
		},
		["Grid2AoeHeals"] = {
		},
		["Grid2RaidDebuffs"] = {
		},
		["Grid2Frame"] = {
			["profiles"] = {
				["mbXtremeUI 6.0"] = {
					["frameHeight"] = 42,
					["frameWidth"] = 82,
				},
				["Testingui - Icecrown"] = {
					["frameHeight"] = 42,
					["frameWidth"] = 82,
				},
			},
		},
	},
	["profileKeys"] = {
		["Plesar - Icecrown"] = "mbXtremeUI 6.0",
		["Testingui - Icecrown"] = "Testingui - Icecrown",
		["Alvarlth - Icecrown"] = "mbXtremeUI 6.0",
	},
	["profiles"] = {
		["Plesar - Icecrown"] = {
			["statuses"] = {
				["debuff-Forbearance"] = {
					["type"] = "debuff",
					["spellName"] = 25771,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["buff-BeaconOfLight-mine"] = {
					["spellName"] = 53563,
					["type"] = "buff",
					["mine"] = true,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["buff-DivineProtection-mine"] = {
					["spellName"] = 498,
					["type"] = "buff",
					["mine"] = true,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["buff-BeaconOfLight"] = {
					["type"] = "buff",
					["spellName"] = 53563,
					["color1"] = {
						["a"] = 1,
						["r"] = 0.7,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["buff-HandOfProtection-mine"] = {
					["spellName"] = 1022,
					["type"] = "buff",
					["mine"] = true,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["buff-HandOfSalvation"] = {
					["type"] = "buff",
					["spellName"] = 1038,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["buff-DivineShield-mine"] = {
					["spellName"] = 642,
					["type"] = "buff",
					["mine"] = true,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["buff-HandOfSalvation-mine"] = {
					["spellName"] = 1038,
					["type"] = "buff",
					["mine"] = true,
					["color1"] = {
						["a"] = 1,
						["r"] = 0.8,
						["g"] = 0.8,
						["b"] = 0.7,
					},
				},
			},
			["versions"] = {
				["Grid2"] = 9,
			},
			["indicators"] = {
				["corner-top-left"] = {
					["type"] = "text",
					["fontSize"] = 8,
					["level"] = 9,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "TOPLEFT",
						["point"] = "TOPLEFT",
						["x"] = 0,
					},
					["duration"] = true,
					["textlength"] = 12,
					["font"] = "Friz Quadrata TT",
				},
				["side-top"] = {
					["type"] = "text",
					["fontSize"] = 8,
					["level"] = 9,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "TOP",
						["point"] = "TOP",
						["x"] = 0,
					},
					["duration"] = true,
					["textlength"] = 12,
					["font"] = "Friz Quadrata TT",
				},
				["corner-bottom-right"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "BOTTOMRIGHT",
						["point"] = "BOTTOMRIGHT",
						["x"] = 0,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["text-down"] = {
					["type"] = "text",
					["location"] = {
						["y"] = 4,
						["relPoint"] = "BOTTOM",
						["point"] = "BOTTOM",
						["x"] = 0,
					},
					["level"] = 6,
					["textlength"] = 6,
					["fontSize"] = 10,
				},
				["icon-left"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "LEFT",
						["point"] = "LEFT",
						["x"] = -2,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["border"] = {
					["type"] = "border",
					["color1"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["corner-top-right-color"] = {
					["type"] = "text-color",
				},
				["background"] = {
					["type"] = "background",
				},
				["side-top-color"] = {
					["type"] = "text-color",
				},
				["icon-center"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 14,
				},
				["health-color"] = {
					["type"] = "bar-color",
				},
				["icon-right"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "RIGHT",
						["point"] = "RIGHT",
						["x"] = 2,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["heals-color"] = {
					["type"] = "bar-color",
				},
				["alpha"] = {
					["type"] = "alpha",
				},
				["text-down-color"] = {
					["type"] = "text-color",
				},
				["heals"] = {
					["type"] = "bar",
					["parentBar"] = "health",
					["texture"] = "Gradient",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 1,
					["opacity"] = 0.25,
					["color1"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["corner-top-left-color"] = {
					["type"] = "text-color",
				},
				["text-up"] = {
					["type"] = "text",
					["location"] = {
						["y"] = -8,
						["relPoint"] = "TOP",
						["point"] = "TOP",
						["x"] = 0,
					},
					["level"] = 7,
					["textlength"] = 6,
					["fontSize"] = 8,
				},
				["corner-bottom-left"] = {
					["type"] = "square",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "BOTTOMLEFT",
						["point"] = "BOTTOMLEFT",
						["x"] = 0,
					},
					["level"] = 5,
					["size"] = 5,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["text-up-color"] = {
					["type"] = "text-color",
				},
				["health"] = {
					["type"] = "bar",
					["texture"] = "Gradient",
					["childBar"] = "heals",
					["level"] = 2,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["color1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["corner-top-right"] = {
					["type"] = "text",
					["fontSize"] = 8,
					["level"] = 9,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "TOPRIGHT",
						["point"] = "TOPRIGHT",
						["x"] = 0,
					},
					["duration"] = true,
					["textlength"] = 12,
					["font"] = "Friz Quadrata TT",
				},
			},
			["statusMap"] = {
				["corner-top-left"] = {
					["buff-BeaconOfLight"] = 99,
					["buff-BeaconOfLight-mine"] = 89,
				},
				["side-top"] = {
					["buff-FlashOfLight-mine"] = 99,
				},
				["corner-bottom-right"] = {
					["debuff-Forbearance"] = 99,
				},
				["text-down"] = {
					["name"] = 99,
				},
				["icon-left"] = {
					["raid-icon-player"] = 155,
				},
				["border"] = {
					["debuff-Disease"] = 90,
					["health-low"] = 55,
					["debuff-Poison"] = 80,
					["target"] = 50,
					["debuff-Magic"] = 70,
					["debuff-Curse"] = 60,
				},
				["corner-top-right-color"] = {
					["buff-DivineShield-mine"] = 97,
					["buff-DivineProtection-mine"] = 95,
					["buff-HandOfProtection-mine"] = 93,
				},
				["text-down-color"] = {
					["classcolor"] = 99,
				},
				["side-top-color"] = {
					["buff-FlashOfLight-mine"] = 99,
				},
				["icon-center"] = {
					["ready-check"] = 150,
					["death"] = 155,
				},
				["health-color"] = {
					["classcolor"] = 99,
				},
				["corner-top-right"] = {
					["buff-DivineShield-mine"] = 97,
					["buff-DivineProtection-mine"] = 95,
					["buff-HandOfProtection-mine"] = 93,
				},
				["heals-color"] = {
					["classcolor"] = 99,
				},
				["alpha"] = {
					["offline"] = 97,
					["range"] = 99,
					["death"] = 98,
				},
				["health"] = {
					["health-current"] = 99,
				},
				["text-up"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["death"] = 95,
					["vehicle"] = 70,
				},
				["corner-bottom-left"] = {
					["threat"] = 99,
					["buff-HandOfSalvation-mine"] = 100,
					["buff-HandOfSalvation"] = 101,
				},
				["text-up-color"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["death"] = 95,
					["vehicle"] = 70,
				},
				["corner-top-left-color"] = {
					["buff-BeaconOfLight"] = 99,
					["buff-BeaconOfLight-mine"] = 89,
				},
				["heals"] = {
					["heals-incoming"] = 99,
				},
			},
		},
		["Testingui - Icecrown"] = {
			["versions"] = {
				["Grid2"] = 9,
			},
			["indicators"] = {
				["heals"] = {
					["type"] = "bar",
					["parentBar"] = "health",
					["color1"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 1,
					["opacity"] = 0.25,
					["texture"] = "Gradient",
				},
				["icon-right"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "RIGHT",
						["point"] = "RIGHT",
						["x"] = 2,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["text-down"] = {
					["type"] = "text",
					["fontSize"] = 10,
					["font"] = "Impact",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 6,
					["textlength"] = 6,
					["fontFlags"] = "OUTLINE",
				},
				["heals-color"] = {
					["type"] = "bar-color",
				},
				["icon-left"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "LEFT",
						["point"] = "LEFT",
						["x"] = -2,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["alpha"] = {
					["type"] = "alpha",
				},
				["text-up-color"] = {
					["type"] = "text-color",
				},
				["text-down-color"] = {
					["type"] = "text-color",
				},
				["text-up"] = {
					["type"] = "text",
					["location"] = {
						["y"] = -8,
						["relPoint"] = "TOP",
						["point"] = "TOP",
						["x"] = 0,
					},
					["level"] = 7,
					["textlength"] = 6,
					["fontSize"] = 8,
				},
				["health"] = {
					["type"] = "bar",
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["childBar"] = "heals",
					["level"] = 2,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["texture"] = "Healbot",
				},
				["border"] = {
					["color1"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["type"] = "border",
				},
				["corner-bottom-left"] = {
					["type"] = "square",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "BOTTOMLEFT",
						["point"] = "BOTTOMLEFT",
						["x"] = 0,
					},
					["level"] = 5,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["size"] = 5,
				},
				["background"] = {
					["type"] = "background",
				},
				["health-color"] = {
					["type"] = "bar-color",
				},
				["icon-center"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 14,
				},
			},
			["statusMap"] = {
				["heals"] = {
					["heals-incoming"] = 99,
				},
				["text-down"] = {
					["name"] = 99,
				},
				["heals-color"] = {
					["classcolor"] = 99,
				},
				["icon-left"] = {
					["raid-icon-player"] = 155,
				},
				["alpha"] = {
					["offline"] = 97,
					["range"] = 99,
					["death"] = 98,
				},
				["border"] = {
					["target"] = 50,
					["health-low"] = 55,
				},
				["corner-bottom-left"] = {
					["threat"] = 99,
				},
				["health"] = {
					["health-current"] = 99,
				},
				["text-down-color"] = {
					["classcolor"] = 99,
				},
				["text-up"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["vehicle"] = 70,
					["death"] = 95,
				},
				["text-up-color"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["vehicle"] = 70,
					["death"] = 95,
				},
				["health-color"] = {
					["classcolor"] = 99,
				},
				["icon-center"] = {
					["ready-check"] = 150,
					["death"] = 155,
				},
			},
		},
		["mbXtremeUI 6.0"] = {
			["indicators"] = {
				["health-color"] = {
					["type"] = "bar-color",
				},
				["icon-right"] = {
					["fontSize"] = 8,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "RIGHT",
						["point"] = "RIGHT",
						["x"] = 2,
					},
					["level"] = 8,
					["type"] = "icon",
					["size"] = 12,
				},
				["text-down"] = {
					["fontSize"] = 10,
					["font"] = "Impact",
					["type"] = "text",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 6,
					["textlength"] = 6,
					["fontFlags"] = "OUTLINE",
				},
				["heals-color"] = {
					["type"] = "bar-color",
				},
				["icon-left"] = {
					["fontSize"] = 8,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "LEFT",
						["point"] = "LEFT",
						["x"] = -2,
					},
					["level"] = 8,
					["type"] = "icon",
					["size"] = 12,
				},
				["alpha"] = {
					["type"] = "alpha",
				},
				["heals"] = {
					["type"] = "bar",
					["parentBar"] = "health",
					["texture"] = "Gradient",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 1,
					["opacity"] = 0.25,
					["color1"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["background"] = {
					["type"] = "background",
				},
				["corner-bottom-left"] = {
					["type"] = "square",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "BOTTOMLEFT",
						["point"] = "BOTTOMLEFT",
						["x"] = 0,
					},
					["level"] = 5,
					["size"] = 5,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["health"] = {
					["type"] = "bar",
					["texture"] = "Healbot",
					["childBar"] = "heals",
					["level"] = 2,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["color1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["border"] = {
					["type"] = "border",
					["color1"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				},
				["text-up"] = {
					["type"] = "text",
					["location"] = {
						["y"] = -8,
						["relPoint"] = "TOP",
						["point"] = "TOP",
						["x"] = 0,
					},
					["level"] = 7,
					["textlength"] = 6,
					["fontSize"] = 8,
				},
				["text-up-color"] = {
					["type"] = "text-color",
				},
				["text-down-color"] = {
					["type"] = "text-color",
				},
				["icon-center"] = {
					["fontSize"] = 8,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 8,
					["type"] = "icon",
					["size"] = 14,
				},
			},
			["statusMap"] = {
				["heals"] = {
					["heals-incoming"] = 99,
				},
				["text-down"] = {
					["name"] = 99,
				},
				["heals-color"] = {
					["classcolor"] = 99,
				},
				["icon-left"] = {
					["raid-icon-player"] = 155,
				},
				["border"] = {
					["target"] = 50,
					["health-low"] = 55,
				},
				["alpha"] = {
					["offline"] = 97,
					["range"] = 99,
					["death"] = 98,
				},
				["health-color"] = {
					["classcolor"] = 99,
				},
				["health"] = {
					["health-current"] = 99,
				},
				["text-up-color"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["death"] = 95,
					["vehicle"] = 70,
				},
				["corner-bottom-left"] = {
					["threat"] = 99,
				},
				["text-down-color"] = {
					["classcolor"] = 99,
				},
				["text-up"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["death"] = 95,
					["vehicle"] = 70,
				},
				["icon-center"] = {
					["ready-check"] = 150,
					["death"] = 155,
				},
			},
			["versions"] = {
				["Grid2"] = 9,
			},
		},
		["Alvarlth - Icecrown"] = {
			["statusMap"] = {
				["heals"] = {
					["heals-incoming"] = 99,
				},
				["corner-bottom-right"] = {
					["buff-FelArmor-mine"] = 99,
					["buff-ShadowWard-mine"] = 99,
					["buff-SoulLink-mine"] = 99,
				},
				["text-down"] = {
					["name"] = 99,
				},
				["heals-color"] = {
					["classcolor"] = 99,
				},
				["icon-left"] = {
					["raid-icon-player"] = 155,
				},
				["alpha"] = {
					["offline"] = 97,
					["range"] = 99,
					["death"] = 98,
				},
				["icon-right"] = {
					["raid-icon-target"] = 90,
				},
				["border"] = {
					["target"] = 50,
					["health-low"] = 55,
				},
				["text-down-color"] = {
					["classcolor"] = 99,
				},
				["health"] = {
					["health-current"] = 99,
				},
				["text-up"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["vehicle"] = 70,
					["death"] = 95,
				},
				["corner-bottom-left"] = {
					["threat"] = 99,
				},
				["text-up-color"] = {
					["charmed"] = 65,
					["feign-death"] = 96,
					["health-deficit"] = 50,
					["offline"] = 93,
					["vehicle"] = 70,
					["death"] = 95,
				},
				["health-color"] = {
					["classcolor"] = 99,
				},
				["icon-center"] = {
					["ready-check"] = 150,
					["death"] = 155,
				},
			},
			["versions"] = {
				["Grid2"] = 9,
			},
			["indicators"] = {
				["icon-right"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "RIGHT",
						["point"] = "RIGHT",
						["x"] = 2,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["heals"] = {
					["type"] = "bar",
					["parentBar"] = "health",
					["color1"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 1,
					["opacity"] = 0.25,
					["texture"] = "Gradient",
				},
				["corner-bottom-right"] = {
					["location"] = {
						["y"] = 0,
						["relPoint"] = "BOTTOMRIGHT",
						["point"] = "BOTTOMRIGHT",
						["x"] = 0,
					},
					["type"] = "square",
					["level"] = 5,
					["size"] = 5,
				},
				["text-down"] = {
					["type"] = "text",
					["location"] = {
						["y"] = 4,
						["relPoint"] = "BOTTOM",
						["point"] = "BOTTOM",
						["x"] = 0,
					},
					["level"] = 6,
					["textlength"] = 6,
					["fontSize"] = 10,
				},
				["heals-color"] = {
					["type"] = "bar-color",
				},
				["icon-left"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "LEFT",
						["point"] = "LEFT",
						["x"] = -2,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 12,
				},
				["alpha"] = {
					["type"] = "alpha",
				},
				["text-up-color"] = {
					["type"] = "text-color",
				},
				["text-down-color"] = {
					["type"] = "text-color",
				},
				["text-up"] = {
					["type"] = "text",
					["location"] = {
						["y"] = -8,
						["relPoint"] = "TOP",
						["point"] = "TOP",
						["x"] = 0,
					},
					["level"] = 7,
					["textlength"] = 6,
					["fontSize"] = 8,
				},
				["health"] = {
					["type"] = "bar",
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["childBar"] = "heals",
					["level"] = 2,
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["texture"] = "Gradient",
				},
				["border"] = {
					["color1"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["type"] = "border",
				},
				["corner-bottom-left"] = {
					["type"] = "square",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "BOTTOMLEFT",
						["point"] = "BOTTOMLEFT",
						["x"] = 0,
					},
					["level"] = 5,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["size"] = 5,
				},
				["background"] = {
					["type"] = "background",
				},
				["health-color"] = {
					["type"] = "bar-color",
				},
				["icon-center"] = {
					["type"] = "icon",
					["location"] = {
						["y"] = 0,
						["relPoint"] = "CENTER",
						["point"] = "CENTER",
						["x"] = 0,
					},
					["level"] = 8,
					["fontSize"] = 8,
					["size"] = 14,
				},
			},
			["statuses"] = {
				["buff-FelArmor-mine"] = {
					["type"] = "buff",
					["missing"] = true,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["mine"] = true,
					["spellName"] = 28176,
				},
				["buff-ShadowWard-mine"] = {
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["type"] = "buff",
					["mine"] = true,
					["spellName"] = 6229,
				},
				["buff-DemonArmor-mine"] = {
					["type"] = "buff",
					["missing"] = true,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["mine"] = true,
					["spellName"] = 687,
				},
				["buff-SoulLink-mine"] = {
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["type"] = "buff",
					["mine"] = true,
					["spellName"] = 19028,
				},
			},
		},
	},
}
