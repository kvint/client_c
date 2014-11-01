/*
 * User: kuts
 * Date: 3/20/13
 */
package com.scifi.view.utils {

import feathers.core.FeathersControl;
import feathers.textures.Scale9Textures;
import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Image;
import starling.textures.Texture;

public class UIUtils {

	public static function getFrameTexture(width:Number, height:Number, color:uint, thickness:Number = 2):Texture
	{
		var sp:Sprite = new Sprite();

		sp.graphics.lineStyle(thickness, color, 1, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
		sp.graphics.drawRect(thickness * 0.5, thickness * 0.5, width - thickness, height - thickness);

		var bd:BitmapData = new BitmapData(width, height, true, 0x00000000);
		bd.draw(sp);

		return Texture.fromBitmapData(bd, false, false);
	}

	public static function getScale9RectTexture(w:uint, h:uint, c:uint = 0x303335, a:Number = 1):Scale9Textures
	{
		return new Scale9Textures(getRectTexture(w, h, c, a), new Rectangle(w * 0.1, h * 0.1, w * 0.8, h * 0.8));
	}

	public static function getRectTexture(w:uint, h:uint, c:uint = 0x303335, a:Number = 1):Texture
	{
		var sp:Sprite = new Sprite();

		sp.graphics.beginFill(c, a);
		sp.graphics.drawRect(0, 0, w, h);
		sp.graphics.endFill();

		var bd:BitmapData = new BitmapData(w, h, true, 0x00000000);
		bd.draw(sp);

		return Texture.fromBitmapData(bd, false, false);
	}

	public static function getCircleTexture(r:Number, c:uint = 0x303335, a:Number = 1):Texture
	{
		var sp:Sprite = new Sprite();

		sp.graphics.beginFill(c, a);
		sp.graphics.drawCircle(r, r, r);
		sp.graphics.endFill();

		var bd:BitmapData = new BitmapData(r * 2, r * 2, true, 0x00000000);
		bd.draw(sp);

		return Texture.fromBitmapData(bd, false, false);
	}

	public static function getFrameImage(width:Number, height:Number, lineThickness:Number = 1, lineColor:uint = 0x000000, lineAlpha:Number = 1):Image
	{
		var sp:Sprite = new Sprite();

		sp.graphics.beginFill(lineColor, lineAlpha);
		sp.graphics.drawRect(0, 0, width, height);
		sp.graphics.drawRect(lineThickness, lineThickness, width - lineThickness * 2, height - lineThickness * 2);
		sp.graphics.endFill();

		var bd:BitmapData = new BitmapData(width, height, true, 0x00000000);
		bd.draw(sp);

		return new Image(Texture.fromBitmapData(bd, false, false));
	}

	public static function getShapeTexture(vertices:Array, fillColor:uint = 0x0b333c, fillAlpha:Number = 1):Texture
	{
		if (vertices.length < 3)
			return null;

		var sp:Sprite = new Sprite();

		sp.graphics.beginFill(fillColor, fillAlpha);

		sp.graphics.moveTo(vertices[0].x, vertices[0].y);

		for (var s:uint = 1; s < vertices.length; s++)
			sp.graphics.lineTo(vertices[s].x, vertices[s].y);

		sp.graphics.endFill();

		var bd:BitmapData = new BitmapData(sp.width, sp.height, true, 0x00000000);
		bd.draw(sp);

		return Texture.fromBitmapData(bd, false, false);
	}

	public static function createStageMouseObject():DisplayObject
	{
		var mouseObject:starling.display.Sprite = new starling.display.Sprite();
		var starlingViewPort:Rectangle = Starling.current.viewPort;
		var mousePoint:Point = new Point(Starling.current.nativeStage.mouseX , Starling.current.nativeStage.mouseY);

		mouseObject.x = (mousePoint.x - starlingViewPort.x) / Starling.contentScaleFactor;
		mouseObject.y = (mousePoint.y - starlingViewPort.y) / Starling.contentScaleFactor;

		return Starling.current.stage.addChild(mouseObject);
	}

	public static function validateContainer(container:DisplayObjectContainer):void
	{
		if (!container)
			return;

		for (var i:uint = 0; i < container.numChildren; i++)
		{
			var child:DisplayObject = container.getChildAt(i) as DisplayObject;
			if (child is FeathersControl)
			{
				(child as FeathersControl).validate();
				return;
			}
			if (child is DisplayObjectContainer)
			{
				var node:DisplayObjectContainer = child as DisplayObjectContainer;
				if (node.numChildren > 0)
					validateContainer(node);
			}
		}
	}

}
}
