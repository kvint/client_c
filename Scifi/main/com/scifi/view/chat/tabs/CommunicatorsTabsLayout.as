/**
 * Created by kuts on 12/4/14.
 */
package com.scifi.view.chat.tabs
{
import feathers.core.IFeathersControl;
import feathers.layout.ILayout;
import feathers.layout.ILayoutDisplayObject;
import feathers.layout.LayoutBoundsResult;
import feathers.layout.ViewPortBounds;

import flash.geom.Point;

import starling.display.DisplayObject;
import starling.events.Event;

import starling.events.EventDispatcher;

public class CommunicatorsTabsLayout extends EventDispatcher implements ILayout
{
	protected var _gap:Number = 0;

	public function get gap():Number
	{
		return _gap;
	}

	public function set gap(value:Number):void
	{
		if(_gap == value)
			return;

		_gap = value;

		dispatchEventWith(Event.CHANGE);
	}

	public function layout(items:Vector.<DisplayObject>, viewPortBounds:ViewPortBounds = null, result:LayoutBoundsResult = null):LayoutBoundsResult
	{
		// initialize the view port's position and dimensions
		var startX:Number = 0;
		var startY:Number = 0;

		var explicitWidth:Number = NaN;
		var explicitHeight:Number = NaN;

		var minWidth:Number = 0;
		var minHeight:Number = 0;

		var maxWidth:Number = Number.POSITIVE_INFINITY;
		var maxHeight:Number = Number.POSITIVE_INFINITY;

		if(viewPortBounds)
		{
			startX = viewPortBounds.x;
			startY = viewPortBounds.y;

			explicitWidth = viewPortBounds.explicitWidth;
			explicitHeight = viewPortBounds.explicitHeight;

			minWidth = viewPortBounds.minWidth;
			minHeight = viewPortBounds.minHeight;

			maxWidth = viewPortBounds.maxWidth;
			maxHeight = viewPortBounds.maxHeight;
		}

		// loop through the items and position them
		var positionX:Number = startX;

		var maxItemHeight:Number = 0;

		var itemCount:int = items.length;

		for(var i:int = 0; i < itemCount; i++)
		{
			var item:DisplayObject = items[i];

			// skip items that aren't included in the layout
			var layoutItem:ILayoutDisplayObject = item as ILayoutDisplayObject;
			if(layoutItem && !layoutItem.includeInLayout)
				continue;

			// special case for Feathers components
			if(item is IFeathersControl)
				IFeathersControl(item).validate();

			item.x = positionX;
			item.y = startY;

			positionX += item.width + gap;

			// used for the final content width below
			maxItemHeight = Math.max(maxItemHeight, item.height);
		}

		// prepare the result object and return it
		if(!result)
			result = new LayoutBoundsResult();

		var viewPortWidth:Number = explicitWidth;
		var viewPortHeight:Number = explicitHeight;

		if(isNaN(viewPortWidth))
			viewPortWidth = Math.max(minWidth, Math.min(maxWidth, positionX));

		if(isNaN(explicitHeight))
			viewPortHeight = Math.max(minHeight, Math.min(maxHeight, maxItemHeight));

		var contentWidth:Number = Math.max(positionX, viewPortWidth);
		var contentHeight:Number = Math.max(maxItemHeight, viewPortHeight);

		result.viewPortWidth = viewPortWidth;
		result.viewPortHeight = viewPortHeight;
		result.contentWidth = contentWidth;
		result.contentHeight = contentHeight;

		return result;
	}

	public function getScrollPositionForIndex(index:int, items:Vector.<DisplayObject>, x:Number, y:Number, viewPortWidth:Number, viewPortHeight:Number, result:Point = null):Point
	{
		return new Point(0, 0);
	}

	public function get requiresLayoutOnScroll():Boolean
	{
		return false;
	}

	public function getNearestScrollPositionForIndex(index:int, scrollX:Number, scrollY:Number, items:Vector.<DisplayObject>,
													 x:Number, y:Number, width:Number, height:Number, result:Point = null):Point
	{
		return new Point(0, 0);
	}
}
}
