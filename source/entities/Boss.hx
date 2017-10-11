package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import entities.BossShot;

class Boss extends FlxSprite 
{
	private var Timer: Float = 0;
	private var AllowShot: Bool = false;
	public var shot(get, null): BossShot;
	private var initialY: Float;

	public function new(?x:Float=0, ?y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(x, y, SimpleGraphic);
		loadGraphic(AssetPaths.boss1__png, true, 63, 35);
		animation.add("fly", [0, 1, 2, 3, 4, 5], 12, true);
		animation.play("fly");
		initialY = y;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		shootTimer(elapsed);
		Shoot();
		movement();
	}
	
	function movement() 
	{
		if (y <= initialY) 
		{
			velocity.set(0, 50);
		}
		else if (y >= 200) 
		{
			velocity.set(0, -50);
		}
	}
	
	function shootTimer(elapsed:Float) 
	{
		Timer = Timer + elapsed;
		
		if (Timer > 1.5)
		{
			AllowShot = true;
			Timer = 0;
		}
	}
	
	function Shoot() 
	{
		if (AllowShot == true) 
		{
			shot = new BossShot(x, y, AssetPaths.missile1__png);
			shot.velocity.set( -40, 0);
			shot.scale.set(1, 1);
			FlxG.state.add(shot);
			AllowShot = false;
		}
	}
	
	function get_shot():BossShot 
	{
		return shot;
	}
	
}