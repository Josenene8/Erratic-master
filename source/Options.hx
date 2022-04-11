package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.util.FlxColor;
import lime.app.Application;
import lime.system.DisplayMode;
import openfl.Lib;
import openfl.display.FPS;

class OptionCategory
{
	private var _options:Array<Option> = new Array<Option>();

	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = "New Category";

	public final function getName()
	{
		return _name;
	}

	public function new(catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}

	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;

	var video:MP4Handler;

	function playCutscene(name:String)
	{
		video = new MP4Handler();
		video.finishCallback = function() video.playVideo(Paths.video(name));
	}

	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String
	{
		return throw "stub!";
	};

	// Returns whether the label is to be updated.
	public function press():Bool
	{
		return throw "stub!";
	}

	private function updateDisplay():String
	{
		return throw "stub!";
	}

	public function left():Bool
	{
		return throw "stub!";
	}

	public function right():Bool
	{
		return throw "stub!";
	}
}

class DFJKOption extends Option
{
	private var controls:Controls;

	public function new(controls:Controls)
	{
		super();
		this.controls = controls;
	}

	public override function press():Bool
	{
		OptionsMenu.instance.openSubState(new KeyBindMenu());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Key Bindings";
	}
}

class CpuStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cpuStrums = !FlxG.save.data.cpuStrums;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.cpuStrums ? "Light CPU Strums" : "CPU Strums stay static";
	}
}
class CustomControls extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.switchState(new options.CustomControlsState());
		return true;
	}
	private override function updateDisplay():String
	{
		return "controls";
	}

}
class About extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.switchState(new options.AboutState());
		return true;
	}
	private override function updateDisplay():String
	{
		return "About";
	}

}
class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.downscroll ? "Downscroll" : "Upscroll";
	}
}

class GhostTapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.ghost ? "Ghost Tapping" : "No Ghost Tapping";
	}
}

class AccuracyOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy " + (!FlxG.save.data.accuracyDisplay ? "off" : "on");
	}
}

class SongPositionOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Song Position " + (!FlxG.save.data.songPosition ? "off" : "on");
	}
}

class DistractionsAndEffectsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.distractions = !FlxG.save.data.distractions;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Distractions " + (!FlxG.save.data.distractions ? "off" : "on");
	}
}

class ResetButtonOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Reset Button " + (!FlxG.save.data.resetButton ? "off" : "on");
	}
}

class RemoveCutscenesOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cutscenes = !FlxG.save.data.cutscenes;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Cutscenes " + (!FlxG.save.data.cutscenes ? "enabled" : "disabled");
	}
}

class FlashingLightsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.flashing = !FlxG.save.data.flashing;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Flashing Lights " + (!FlxG.save.data.flashing ? "off" : "on");
	}
}

class ShowInput extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.inputShow = !FlxG.save.data.inputShow;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.inputShow ? "Extended Score Info" : "Minimalized Info");
	}
}

class Judgement extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return true;
	}

	private override function updateDisplay():String
	{
		return "Safe Frames";
	}

	override function left():Bool
	{
		if (Conductor.safeFrames == 1)
			return false;

		Conductor.safeFrames -= 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();
		return false;
	}

	override function getValue():String
	{
		return "Safe Frames: "
			+ Conductor.safeFrames
			+ " - SIK: "
			+ HelperFunctions.truncateFloat(45 * Conductor.timeScale, 0)
			+ "ms GD: "
			+ HelperFunctions.truncateFloat(90 * Conductor.timeScale, 0)
			+ "ms BD: "
			+ HelperFunctions.truncateFloat(135 * Conductor.timeScale, 0)
			+ "ms SHT: "
			+ HelperFunctions.truncateFloat(166 * Conductor.timeScale, 0)
			+ "ms TOTAL: "
			+ HelperFunctions.truncateFloat(Conductor.safeZoneOffset, 0)
			+ "ms";
	}

	override function right():Bool
	{
		if (Conductor.safeFrames == 20)
			return false;

		Conductor.safeFrames += 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();
		return true;
	}
}

class EncounterCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('GrandOpening');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Welcome to the Circus";
	}
}

class KermisCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('KermisCutscene');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Erratic's Worry";
	}
}

class RingmasterCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('AngryErratic');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Erratic's Wrath";
	}
}

class VencitIntroCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('VencitCutscene');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Entrance to the Hellscape";
	}
}

class VencitOutroCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('Erratic Spares BF');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Escaping the Hellscape";
	}
}

class FreakshowCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('Freakshow');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Old Foes, New Allies";
	}
}

class VengenaceCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('DDincoming');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Daddy Dearest";
	}
}

class MaledictaintroCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('Foes');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Foes";
	}
}

class MaledictaoutroCutsceneExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		playCutscene('GrandFinale');
		return true;
	}

	private override function updateDisplay():String
	{
		return "Death of the Demon";
	}
}

class YouTubeTeamManiacExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://www.youtube.com/channel/UC4YzrNhUu2RUEl9AkRsP8Tg");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Team Maniac";
	}
}

class YouTubeCQTheKidExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://www.youtube.com/channel/UCZlhI-rvPNKu5rRo4rW8syQ");
		return true;
	}

	private override function updateDisplay():String
	{
		return "CQ The Kid";
	}
}

class YouTubeRedExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://youtube.com/channel/UCDRMS9sjDQMrzoItPdUr3ZQ");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Redpanzee";
	}
}

class YouTubeBirbExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://youtube.com/channel/UClyd5uvF1N9pCKdND6Gqwyg");
		return true;
	}

	private override function updateDisplay():String
	{
		return "ImaLilBirbBoi";
	}
}

class YouTubePyroExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://youtube.com/channel/UCTZ32jMa8fQbW6ZXx4y1nXg");
		return true;
	}

	private override function updateDisplay():String
	{
		return "PyroMANIAC";
	}
}

class YouTubeNyxExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://youtube.com/channel/UC8MiY0atAKx7lkPVYpdGxeQ");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Nyx";
	}
}

class YouTubeSpeedyExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://youtube.com/channel/UCOMsCbeW7URhiyF2eRgH3Zw");
		return true;
	}

	private override function updateDisplay():String
	{
		return "SpeedyTheOne";
	}
}

class YouTubeTechExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://www.youtube.com/channel/UCdPbvPZsnsbgC8aFtIcsFcA");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Technically Insane";
	}
}

class YouTubeRzoarExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://www.youtube.com/channel/UCAAKPT5ybKH6PCTZFqJTzDg");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Rzoarian";
	}
}

class YouTubeTGExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://www.youtube.com/channel/UCC1Lem77TP8u7UJsCxAN1hQ");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Broken Rat";
	}
}

class YouTubeLSExtra extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.openURL("https://youtube.com/channel/UCKRBrjBqQw52ZGgG_DoaccA");
		return true;
	}

	private override function updateDisplay():String
	{
		return "Lost Spirits";
	}
}

class DataEraseOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.erase();
		FlxG.save.flush();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Delete All Data";
	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast(Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Counter " + (!FlxG.save.data.fps ? "off" : "on");
	}
}

class ScoreScreen extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.scoreScreen = !FlxG.save.data.scoreScreen;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.scoreScreen ? "Show Score Screen" : "No Score Screen");
	}
}

class FPSCapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "FPS Cap";
	}

	override function right():Bool
	{
		if (FlxG.save.data.fpsCap >= 290)
		{
			FlxG.save.data.fpsCap = 290;
			(cast(Lib.current.getChildAt(0), Main)).setFPSCap(290);
		}
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 10;
		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		return true;
	}

	override function left():Bool
	{
		if (FlxG.save.data.fpsCap > 290)
			FlxG.save.data.fpsCap = 290;
		else if (FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = Application.current.window.displayMode.refreshRate;
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 10;
				(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
		return true;
	}

	override function getValue():String
	{
		return "Current FPS Cap: "
			+ FlxG.save.data.fpsCap
			+ (FlxG.save.data.fpsCap == Application.current.window.displayMode.refreshRate ? "Hz (Refresh Rate)" : "");
	}
}

class ScrollSpeedOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Scroll Speed";
	}

	override function right():Bool
	{
		FlxG.save.data.scrollSpeed += 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 4)
			FlxG.save.data.scrollSpeed = 4;
		return true;
	}

	override function getValue():String
	{
		return "Current Scroll Speed: " + HelperFunctions.truncateFloat(FlxG.save.data.scrollSpeed, 1);
	}

	override function left():Bool
	{
		FlxG.save.data.scrollSpeed -= 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 4)
			FlxG.save.data.scrollSpeed = 4;

		return true;
	}
}

class RainbowFPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fpsRain = !FlxG.save.data.fpsRain;
		(cast(Lib.current.getChildAt(0), Main)).changeFPSColor(FlxColor.WHITE);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Rainbow " + (!FlxG.save.data.fpsRain ? "off" : "on");
	}
}

class Optimization extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.optimize = !FlxG.save.data.optimize;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Optimization " + (FlxG.save.data.optimize ? "ON" : "OFF");
	}
}

class NPSDisplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "NPS Display " + (!FlxG.save.data.npsDisplay ? "off" : "on");
	}
}

class ReplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		FlxG.switchState(new LoadReplayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Load replays";
	}
}

class AccuracyDOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy Mode: " + (FlxG.save.data.accuracyMod == 0 ? "Accurate" : "Complex");
	}
}

class WatermarkOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		Main.watermarks = !Main.watermarks;
		FlxG.save.data.watermark = Main.watermarks;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Watermarks " + (Main.watermarks ? "on" : "off");
	}
}

class OffsetMenu extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		var poop:String = Highscore.formatSong("Tutorial", 1);

		PlayState.SONG = Song.loadFromJson(poop, "Tutorial");
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 0;
		PlayState.offsetTesting = true;
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Time your offset";
	}
}

class BotPlay extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
		return "BotPlay " + (FlxG.save.data.botplay ? "on" : "off");
}

class CamZoomOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.camzoom = !FlxG.save.data.camzoom;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Zoom " + (!FlxG.save.data.camzoom ? "off" : "on");
	}
}
