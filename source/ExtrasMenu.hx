package;

import Controls.Control;
import Options;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.utils.Assets;
import openfl.Lib;

class ExtrasMenu extends MusicBeatState
{
	public static var instance:ExtrasMenu;

	var selector:FlxText;
	var curSelected:Int = 0;

	var options:Array<OptionCategory> = [
		new OptionCategory("Cutscene Gallery", [
			new EncounterCutsceneExtra("The Grand Opening!"),
			new KermisCutsceneExtra("Erratic's worry grows as the crowd cheers BF on..."),
			new RingmasterCutsceneExtra("Fear the wrath of the Demonic Ringmaster!"),
			new VencitIntroCutsceneExtra("Enraged, Erratic reveals his mysterious powers!"),
			new VencitOutroCutsceneExtra("On the verge of Victory, flashbacks fill Erratic's mind, causing him to spare BF"),
			new FreakshowCutsceneExtra("Erratic awaits BF to help him with a special plan..."),
			new VengenaceCutsceneExtra("Erratic's curse slowly breaks!"),
			new MaledictaintroCutsceneExtra("Erratic finally breaks free from his curse!"),
			new MaledictaoutroCutsceneExtra("At long last... Erratic has gotten his revenge."),
		]),
		new OptionCategory("YouTube", [
			new YouTubeTeamManiacExtra("Head Over to the Official Team Maniac YouTube Channel!"),
			new YouTubeTechExtra("Technically Insane's Personal Channel!"),
			new YouTubeRedExtra("Redpanzee's Personal Channel!"), new YouTubeTGExtra("Table Gremlin's Personal Channel!"),
			new YouTubeLSExtra("Lost Spirits' Personal Channel!"), new YouTubeCQTheKidExtra("CQ The Kid's Personal Channel!"),
			new YouTubePyroExtra("PyroMANIAC's Personal Channel!"), new YouTubeNyxExtra("Nyx's Personal Channel!"),
			new YouTubeRzoarExtra("The Rzoarians's Personal Channel!"), new YouTubeSpeedyExtra("Speedy's Personal Channel!"),
			new YouTubeBirbExtra("ImaLilBirbBoi's Personal Channel!"),
		])
	];

	public var acceptInput:Bool = true;

	private var currentDescription:String = "";
	private var grpControls:FlxTypedGroup<Alphabet>;

	public static var versionShit:FlxText;

	var currentSelectedCat:OptionCategory;
	var blackBorder:FlxSprite;

	override function create()
	{
		instance = this;
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuDesat"));

		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...options.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false, true);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		currentDescription = "none";

		versionShit = new FlxText(5, FlxG.height
			+ 40, 0,
			"Offset (Left, Right, Shift for slow): "
			+ HelperFunctions.truncateFloat(FlxG.save.data.offset, 2)
			+ " - Description - "
			+ currentDescription, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		blackBorder = new FlxSprite(-30, FlxG.height + 40).makeGraphic((Std.int(versionShit.width + 900)), Std.int(versionShit.height + 600), FlxColor.BLACK);
		blackBorder.alpha = 0.5;

		add(blackBorder);

		add(versionShit);

		FlxTween.tween(versionShit, {y: FlxG.height - 18}, 2, {ease: FlxEase.elasticInOut});
		FlxTween.tween(blackBorder, {y: FlxG.height - 18}, 2, {ease: FlxEase.elasticInOut});
		
                #if mobileC
		addVirtualPad(FULL, A_B);
		#end
		
		super.create();
	}

	var isCat:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (acceptInput)
		{
			if (controls.BACK && !isCat)
				FlxG.switchState(new MainMenuState());
			else if (controls.BACK)
			{
				isCat = false;
				grpControls.clear();
				for (i in 0...options.length)
				{
					var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false);
					controlLabel.isMenuItem = true;
					controlLabel.targetY = i;
					grpControls.add(controlLabel);
					// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
				}

				curSelected = 0;

				changeSelection(curSelected);
			}

			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeSelection(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeSelection(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
				changeSelection(-1);
			if (FlxG.keys.justPressed.DOWN)
				changeSelection(1);

			if (isCat)
			{
				if (currentSelectedCat.getOptions()[curSelected].getAccept())
				{
					if (FlxG.keys.pressed.SHIFT)
					{
						if (FlxG.keys.pressed.RIGHT)
							currentSelectedCat.getOptions()[curSelected].right();
						if (FlxG.keys.pressed.LEFT)
							currentSelectedCat.getOptions()[curSelected].left();
					}
					else
					{
						if (FlxG.keys.justPressed.RIGHT)
							currentSelectedCat.getOptions()[curSelected].right();
						if (FlxG.keys.justPressed.LEFT)
							currentSelectedCat.getOptions()[curSelected].left();
					}
				}
				else
				{
					if (FlxG.keys.pressed.SHIFT)
					{
						if (FlxG.keys.justPressed.RIGHT)
							FlxG.save.data.offset += 0.1;
						else if (FlxG.keys.justPressed.LEFT)
							FlxG.save.data.offset -= 0.1;
					}
					else if (FlxG.keys.pressed.RIGHT)
						FlxG.save.data.offset += 0.1;
					else if (FlxG.keys.pressed.LEFT)
						FlxG.save.data.offset -= 0.1;

					versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2)
						+ " - Description - " + currentDescription;
				}
				if (currentSelectedCat.getOptions()[curSelected].getAccept())
					versionShit.text = currentSelectedCat.getOptions()[curSelected].getValue() + " - Description - " + currentDescription;
				else
					versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2)
						+ " - Description - " + currentDescription;
			}
			else
			{
				if (FlxG.keys.pressed.SHIFT)
				{
					if (FlxG.keys.justPressed.RIGHT)
						FlxG.save.data.offset += 0.1;
					else if (FlxG.keys.justPressed.LEFT)
						FlxG.save.data.offset -= 0.1;
				}
				else if (FlxG.keys.pressed.RIGHT)
					FlxG.save.data.offset += 0.1;
				else if (FlxG.keys.pressed.LEFT)
					FlxG.save.data.offset -= 0.1;

				versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2) + " - Description - "
					+ currentDescription;
			}

			if (controls.RESET)
				FlxG.save.data.offset = 0;

			if (controls.ACCEPT)
			{
				if (isCat)
				{
					if (currentSelectedCat.getOptions()[curSelected].press())
					{
						grpControls.members[curSelected].reType(currentSelectedCat.getOptions()[curSelected].getDisplay());
						trace(currentSelectedCat.getOptions()[curSelected].getDisplay());
					}
				}
				else
				{
					currentSelectedCat = options[curSelected];
					isCat = true;
					grpControls.clear();
					for (i in 0...currentSelectedCat.getOptions().length)
					{
						var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, currentSelectedCat.getOptions()[i].getDisplay(), true, false);
						controlLabel.isMenuItem = true;
						controlLabel.targetY = i;
						grpControls.add(controlLabel);
						// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
					}
					curSelected = 0;
				}

				changeSelection();
			}
		}
		FlxG.save.flush();
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent("Fresh");
		#end

		FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		if (isCat)
			currentDescription = currentSelectedCat.getOptions()[curSelected].getDescription();
		else
			currentDescription = "Please select a category";
		if (isCat)
		{
			if (currentSelectedCat.getOptions()[curSelected].getAccept())
				versionShit.text = currentSelectedCat.getOptions()[curSelected].getValue() + " - Description - " + currentDescription;
			else
				versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2) + " - Description - "
					+ currentDescription;
		}
		else
			versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2) + " - Description - "
				+ currentDescription;
		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
