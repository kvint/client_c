/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs
{
import com.scifi.view.chat.communicator.ICommunicatorView;

import feathers.controls.ToggleButton;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.events.FeathersEventType;
import feathers.skins.IStyleProvider;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import starling.display.DisplayObject;
import starling.events.Event;

public class CommunicatorTabContainerView extends DefaultListItemRenderer
{
	private static const log:ILogger = getLogger(CommunicatorTabContainerView);

	private var _tabView:ICommunicatorView;
	private var _tabFactoryFunc:Function;

	public function CommunicatorTabContainerView()
	{
		isQuickHitAreaEnabled = false;
	}

	override protected function draw():void
	{
		super.draw();

		const dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
		const stateInvalid:Boolean = isInvalid(INVALIDATION_FLAG_STATE);

		if (dataInvalid || stateInvalid)
			updateTabState();
	}

	private function updateTabState():void
	{
		if (_tabView)
			(_tabView as ToggleButton).isSelected = isSelected;
	}

	override protected function commitData():void
	{
		super.commitData();

		updateTabView();
	}

	override protected function layoutContent():void
	{
		super.layoutContent();

		if (_tabView)
		{
			_tabView.validate();
			_tabView.height = actualHeight;
		}
	}

	override protected function autoSizeIfNeeded():Boolean
	{
		const needsWidth:Boolean = isNaN(explicitWidth);
		const needsHeight:Boolean = isNaN(explicitHeight);

		if (!needsWidth && !needsHeight)
			return false;

		if (_tabView)
			_tabView.validate();

		var newWidth:Number = explicitWidth;

		if (needsWidth)
			newWidth = _tabView ? _tabView.width : 0;

		var newHeight:Number = explicitHeight;

		if (needsHeight)
			newHeight = _tabView ? _tabView.height : 0;

		return setSizeInternal(newWidth, newHeight, false);
	}

	protected function updateTabView():void
	{
		if (_tabView)
		{
			_tabView.removeFromParent();
			_tabView.removeEventListener(FeathersEventType.RESIZE, child_onResize);
			_tabView = null;
		}

		if (_tabFactoryFunc)
			_tabView = _tabFactoryFunc(data);

		if (_tabView)
		{
			_tabView.addEventListener(FeathersEventType.RESIZE, child_onResize);
			addChild(_tabView as DisplayObject);
		}
	}

	public function set tabFactoryFunc(value:Function):void
	{
		if (_tabFactoryFunc == value)
			return;

		_tabFactoryFunc = value;

		invalidate(INVALIDATION_FLAG_DATA);
	}

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	private function child_onResize(event:Event):void
	{
		invalidate(INVALIDATION_FLAG_STYLES);
	}

}
}
