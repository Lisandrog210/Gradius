package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;


class Storm extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		velocity.set(30, 0);
		loadGraphic(AssetPaths.storm30x69__png, true, 30, 23);
		animation.add("storm", [0, 1, 3], 12, true);
		animation.play("storm");
	}
	
}