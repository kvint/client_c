/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs
{
import com.chat.model.communicators.ICommunicator;
import com.scifi.view.chat.communicator.ICommunicatorView;

import feathers.controls.ToggleButton;
import feathers.core.IFeathersControl;
import feathers.events.FeathersEventType;
import feathers.skins.IStyleProvider;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import starling.display.DisplayObject;
import starling.events.Event;

public class CommunicatorTabContainerView extends ToggleButton
{
	private static const log:ILogger = getLogger(CommunicatorTabContainerView);

	private var _provider:ICommunicator;
	private var _tabView:ICommunicatorView;
	private var _viewFactoryClass:Class;

	public function CommunicatorTabContainerView()
	{
		isQuickHitAreaEnabled = false;
	}

	override protected function draw():void
	{
		super.draw();

		const dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
		const stylesInvalid:Boolean = isInvalid(INVALIDATION_FLAG_STYLES);
		const stateInvalid:Boolean = isInvalid(INVALIDATION_FLAG_STATE);
		var sizeInvalid:Boolean = isInvalid(INVALIDATION_FLAG_SIZE);
		var layoutInvalid:Boolean = isInvalid(INVALIDATION_FLAG_LAYOUT);

		if (dataInvalid)
			updateTabView();

		if (stateInvalid)
			updateTabState();

		sizeInvalid = autoSizeIfNeeded() || sizeInvalid;

		if (layoutInvalid || stylesInvalid || sizeInvalid || stateInvalid || dataInvalid)
			layoutContent();
	}

	private function updateTabState():void
	{
		if (_tabView)
			(_tabView as ToggleButton).isSelected = isSelected;
	}

	override protected function autoSizeIfNeeded():Boolean
	{
		const needsWidth:Boolean = isNaN(explicitWidth);
		const needsHeight:Boolean = isNaN(explicitHeight);

		if (!needsWidth && !needsHeight)
			return false;

		var control:IFeathersControl;

		if (_tabView)
		{
			control = IFeathersControl(_tabView);
			control.validate();
		}

		var newWidth:Number = explicitWidth;

		if (needsWidth)
			newWidth = control ? control.width : 0;

		var newHeight:Number = explicitHeight;

		if (needsHeight)
			newHeight = control ? control.height : 0;

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

		if (_viewFactoryClass)
			_tabView = new _viewFactoryClass();

		if (_tabView)
		{
			_tabView.provider.data = provider;
			_tabView.addEventListener(FeathersEventType.RESIZE, child_onResize);
			addChild(_tabView as DisplayObject);
		}
	}

	override protected function layoutContent():void
	{
		/*if (_tabView)
		{
			_tabView.validate();
			_tabView.width = actualWidth;
			_tabView.height = actualHeight;
		}*/
	}

	public function get provider():ICommunicator
	{
		return _provider;
	}

	public function set provider(value:ICommunicator):void
	{
		if (_provider == value)
			return;

		_provider = value;

		invalidate(INVALIDATION_FLAG_DATA);
	}

	public function set viewFactoryClass(value:Class):void
	{
		if (_viewFactoryClass == value)
			return;

		_viewFactoryClass = value;

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
