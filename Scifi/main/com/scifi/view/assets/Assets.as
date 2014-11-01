/**
 * Created by kuts on 8/21/14.
 */
package com.scifi.view.assets {

import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

public class Assets {

	private static var _manager		:AssetManager = new AssetManager();

	public static function loadAssets(sources:Array, onComplete:Function):void
	{
		for each(var source:String in sources)
			_manager.enqueue(source);

		_manager.loadQueue(onLoadComplete);

		function onLoadComplete(ratio:Number):void
		{
			if (ratio == 1.0)
				onComplete();
		}
	}

	public static function getTexture(name:String):Texture
	{
		return _manager.getTexture(name);
	}

	public static function getXml(name:String):XML
	{
		return _manager.getXml(name);
	}

	public static function getTextureAtlas(name:String):TextureAtlas
	{
		return _manager.getTextureAtlas(name);
	}

}
}
