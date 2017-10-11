package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class EnemyShot extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		color.red;
		scale.set(2, 2);
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