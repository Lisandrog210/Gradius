package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BossShot extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.missile1__png, true, 32, 11);
		animation.add("fuegitoChingon", [0, 1], 12, true);
		animation.play("fuegitoChingon");
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		limites();
	}
	
	function limites() 
	{
		
		if (x > camera.scroll.x + FlxG.width - width)
		{
			this.kill();
		}
	}
	
}