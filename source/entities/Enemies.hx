package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;


class Enemies extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		
		
	}
	
}