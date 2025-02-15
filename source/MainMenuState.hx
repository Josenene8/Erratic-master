package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

using StringTools;

#if windows
import Discord.DiscordClient;
#end

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = if (FlxG.save.data.week2completed)
		{
			['story mode', 'freeplay', 'options', 'donate'];
		}
		else
		{
			['story mode', 'freeplay', 'options'];
		}
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;

	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "";
	public static var gameVer:String = "";

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('circus/circuswall', 'erratic'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('circus/circuswall', 'erratic'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		if (!FlxG.save.data.weekcompleted)
		{
			var erraticmenu:FlxSprite = new FlxSprite(-100);
			erraticmenu.frames = Paths.getSparrowAtlas('Erratic Main Menu');
			erraticmenu.animation.addByPrefix('idle', 'Erratic Main Menu Boppin', 14, true);
			erraticmenu.animation.play('idle');
			erraticmenu.scrollFactor.x = 0;
			erraticmenu.scrollFactor.y = 0.10;
			erraticmenu.setGraphicSize(Std.int(erraticmenu.width * 1.2));
			erraticmenu.updateHitbox();
			erraticmenu.screenCenter();
			erraticmenu.x = -50;
			erraticmenu.y = 175;
			erraticmenu.antialiasing = true;
			add(erraticmenu);
		}
		else
		{
			var erraticmenu2:FlxSprite = new FlxSprite(-100);
			erraticmenu2.frames = Paths.getSparrowAtlas('Erratic Title Screen 2');
			erraticmenu2.animation.addByPrefix('idle', 'Erratic Title Screen 2 Boppin', 14, true);
			erraticmenu2.animation.play('idle');
			erraticmenu2.scrollFactor.x = 0;
			erraticmenu2.scrollFactor.y = 0.10;
			erraticmenu2.setGraphicSize(Std.int(erraticmenu2.width * 1.2));
			erraticmenu2.updateHitbox();
			erraticmenu2.screenCenter();
			erraticmenu2.x = -100;
			erraticmenu2.y = 200;
			erraticmenu2.antialiasing = true;
			add(erraticmenu2);

			var boyfriendmenu:FlxSprite = new FlxSprite(-100);
			boyfriendmenu.frames = Paths.getSparrowAtlas('Boyfriend Title Screen');
			boyfriendmenu.animation.addByPrefix('idle', 'Boyfriend Title Screen Boppin', 14, true);
			boyfriendmenu.animation.play('idle');
			boyfriendmenu.scrollFactor.x = 0;
			boyfriendmenu.scrollFactor.y = 0.10;
			boyfriendmenu.setGraphicSize(Std.int(boyfriendmenu.width * 1.2));
			boyfriendmenu.updateHitbox();
			boyfriendmenu.screenCenter();
			boyfriendmenu.x = 350;
			boyfriendmenu.y = 400;
			boyfriendmenu.antialiasing = true;
			add(boyfriendmenu);
		}

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		if (!FlxG.save.data.week2completed)
		{
			for (i in 0...optionShit.length)
			{
				var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
				menuItem.frames = tex;
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				menuItem.scrollFactor.set();
				menuItem.antialiasing = true;
				if (firstStart)
					FlxTween.tween(menuItem, {y: 150 + (i * 160)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut,
						onComplete: function(flxTween:FlxTween)
						{
							finishedFunnyMove = true;
							changeItem();
						}
					});
				else
					menuItem.y = 150 + (i * 160);
			}

			firstStart = false;

			FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
		}
		else
		{
			for (i in 0...optionShit.length)
			{
				var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
				menuItem.frames = tex;
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				menuItem.scrollFactor.set();
				menuItem.antialiasing = true;
				if (firstStart)
					FlxTween.tween(menuItem, {y: 75 + (i * 160)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut,
						onComplete: function(flxTween:FlxTween)
						{
							finishedFunnyMove = true;
							changeItem();
						}
					});
				else
					menuItem.y = 75 + (i * 160);
			}

			firstStart = false;

			FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
		}
		var corners:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('Menu_Corners'));
		corners.scrollFactor.x = 0;
		corners.scrollFactor.y = 0.10;
		corners.setGraphicSize(Std.int(corners.width * 1.1));
		corners.updateHitbox();
		corners.screenCenter();
		corners.antialiasing = true;
		add(corners);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer + (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();
		
                #if mobileC
		addVirtualPad(UP_DOWN, A_B);
		#end
			
		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));

				if (FlxG.save.data.flashing)
					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0}, 1.3, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						if (FlxG.save.data.flashing)
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								goToState();
							});
						}
						else
						{
							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
						}
					}
				});
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
			spr.x = 600;
		});
	}

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");

			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'options':
				FlxG.switchState(new OptionsMenu());
				trace("Options Menu Selected");
			case 'donate':
				FlxG.switchState(new ExtrasMenu());
				trace("Extras Menu Selected");
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
			}

			spr.updateHitbox();
		});
	}
}
