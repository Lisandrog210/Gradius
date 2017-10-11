package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;


class EnemyPlane extends FlxSprite 
{
	
	private var Timer: Float = 0;
	private var AllowShot: Bool;
	
	public function new(?x:Float=0, ?y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(x, y, SimpleGraphic);
		loadGraphic(AssetPaths.england1__png, true, 26, 15);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		velocity.set( -40, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
}