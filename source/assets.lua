local dirFonts = "assets/fonts/"
local dirImages = "assets/images/"
local dirSounds = "assets/sounds/"
local dirTracks = "assets/tracks/"
local dirLevels = "assets/levels/"

kAssetsImages = {
	menuWheel = dirImages.."menu/wheel",
	checkpoint = dirImages.."sprites/checkpoint/checkpoint",
	checkpointSet = dirImages.."sprites/checkpoint/checkpoint_isSet",
	coin = dirImages.."sprites/coin",
	killBlock = dirImages.."sprites/killBlock",
	platform = dirImages.."sprites/platform",
	levelEnd = dirImages.."sprites/portal",
	wheel = dirImages.."sprites/wheel",
	wheelLoading = dirImages.."sprites/wheel/0",
	star = dirImages.."sprites/star/star",
}

kAssetsSounds = {
	checkpointSet = dirSounds.."checkpoint",
	coin = dirSounds.."coin",
	playerDied = dirSounds.."death",
	menuSelectFail = dirSounds.."menu-fail",
	menuSelect = dirSounds.."menu-select",
	wheelMovement = dirSounds.."wheel_movement"
}

kAssetsTracks = {
	
}

kAssetsFonts = {
	twinbee = dirFonts.."Twinbee (1)",
	marbleMadness = dirFonts.."Marble Madness [unused 1] (1)"
}

kAssetsLevels = {
	mountain = dirLevels.."1_mountain",
	space = dirLevels.."2_space",
	city = dirLevels.."3_city",
}