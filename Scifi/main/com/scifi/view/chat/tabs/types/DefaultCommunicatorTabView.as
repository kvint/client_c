/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs.types
{
import com.scifi.utils.providers.IViewDataProvider;
import com.scifi.utils.providers.ViewDataProvider;
import com.scifi.view.chat.communicator.ICommunicatorView;
import com.scifi.view.chat.controls.counter.CounterView;

import feathers.controls.Label;
import feathers.controls.ToggleButton;
import feathers.events.FeathersEventType;
import feathers.skins.IStyleProvider;

import org.as3commons.logging.api.ILogger;

import org.as3commons.logging.api.getLogger;

public class DefaultCommunicatorTabView extends ToggleButton implements ICommunicatorView
{
	private static const log:ILogger = getLogger(DefaultCommunicatorTabView);

	public static const CHILD_COMMUNICATOR_TAB_NAME_LABEL:String = "child-communicator-tab-name-label";
	public static const CHILD_COMMUNICATOR_TAB_COUNT_LABEL:String = "child-communicator-tab-count-label";

	private var _nameText:String = null;
	private var _nameLabel:Label = new Label();
	private var _counterView:CounterView = new CounterView();

	private var _provider:IViewDataProvider = new ViewDataProvider();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();

		nameLabel.styleNameList.add(CHILD_COMMUNICATOR_TAB_NAME_LABEL);
		counterView.styleNameList.add(CHILD_COMMUNICATOR_TAB_COUNT_LABEL);

		addChild(nameLabel);
		addChild(counterView);

		counterView.visible = false;

		counterView.addEventListener(FeathersEventType.RESIZE, child_onResize);
	}

	override protected function refreshLabel():void
	{
		nameLabel.text = _nameText;
	}

	override protected function refreshLabelStyles():void
	{
		super.refreshLabelStyles();
	}

	override protected function autoSizeIfNeeded():Boolean
	{
		const needsWidth:Boolean = isNaN(explicitWidth);
		const needsHeight:Boolean = isNaN(explicitHeight);

		if(!needsWidth && !needsHeight)
			return false;

		nameLabel.validate();

		if (counterView.visible)
			counterView.validate();

		var newWidth:Number = explicitWidth;

		if(needsWidth)
		{
			newWidth = paddingLeft + nameLabel.width + paddingRight;

			if (counterView.visible)
				newWidth += gap + counterView.width;
		}

		var newHeight:Number = explicitHeight;

		if(needsHeight)
			newHeight = paddingTop + Math.max(nameLabel.height, counterView.height) + paddingBottom;

		return setSizeInternal(newWidth, newHeight, false);
	}

	override protected function layoutContent():void
	{
		super.layoutContent();

		nameLabel.validate();

		nameLabel.x = paddingLeft;
		nameLabel.y = (actualHeight - nameLabel.height) / 2;

		if (counterView.visible)
		{
			counterView.validate();

			if (_nameText && _nameText != "")
				nameLabel.maxWidth = actualWidth - paddingLeft - counterView.width - paddingRight;
			counterView.x = actualWidth - counterView.width - paddingRight;
			counterView.y = (actualHeight - counterView.height) / 2;
		}
		else if (_nameText && _nameText != "")
			nameLabel.maxWidth = actualWidth - paddingLeft - paddingRight;
	}

	private function child_onResize():void
	{
		invalidate(INVALIDATION_FLAG_STYLES);
	}

	public function get provider():IViewDataProvider
	{
		return _provider;
	}

	public function get nameLabel():Label
	{
		return _nameLabel;
	}

	public function get counterView():CounterView
	{
		return _counterView;
	}

	public function setCounterVisible(value:Boolean):void
	{
		if (counterView.visible == value)
			return;

		counterView.visible = value;

		invalidate(INVALIDATION_FLAG_STYLES);
	}

	public function set nameText(value:String):void
	{
		if (_nameText == value)
			return;

		_nameText = value;

		invalidate(INVALIDATION_FLAG_DATA);
	}
}
}
