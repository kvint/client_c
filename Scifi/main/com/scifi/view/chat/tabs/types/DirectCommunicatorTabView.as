/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs.types
{
import feathers.controls.Label;
import feathers.events.FeathersEventType;
import feathers.skins.IStyleProvider;

public class DirectCommunicatorTabView extends DefaultCommunicatorTabView
{
	public static const CHILD_COMMUNICATOR_TAB_NAME_LABEL:String = "child-communicator-tab-name-label";
	public static const CHILD_COMMUNICATOR_TAB_COUNT_LABEL:String = "child-communicator-tab-count-label";

	private var _nameLabel:Label = new Label();
	private var _countLabel:Label = new Label();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();

		nameLabel.styleNameList.add(CHILD_COMMUNICATOR_TAB_NAME_LABEL);
		countLabel.styleNameList.add(CHILD_COMMUNICATOR_TAB_COUNT_LABEL);

		addChild(nameLabel);
		addChild(countLabel);

		nameLabel.addEventListener(FeathersEventType.RESIZE, child_onResize);
		countLabel.addEventListener(FeathersEventType.RESIZE, child_onResize);
	}

	override protected function autoSizeIfNeeded():Boolean
	{
		super.autoSizeIfNeeded();

		const needsWidth:Boolean = isNaN(explicitWidth);
		const needsHeight:Boolean = isNaN(explicitHeight);

		if(!needsWidth && !needsHeight)
			return false;

		nameLabel.validate();
		countLabel.validate();

		var newWidth:Number = explicitWidth;

		if(needsWidth)
			newWidth = paddingLeft + nameLabel.width + gap + countLabel.width + paddingRight;

		var newHeight:Number = explicitHeight;

		if(needsHeight)
		{
			newHeight = paddingTop;
			newHeight += Math.max(nameLabel.height, countLabel.height)
			newHeight += paddingBottom;
		}

		return setSizeInternal(newWidth, newHeight, false);
	}

	override protected function layoutContent():void
	{
		super.layoutContent();

		nameLabel.validate();
		countLabel.validate();

		nameLabel.x = paddingLeft;
		nameLabel.y = (actualHeight - nameLabel.height) / 2;

		countLabel.x = actualWidth - countLabel.width - paddingRight;
		countLabel.y = (actualHeight - countLabel.height) / 2;
	}

	private function child_onResize():void
	{
		invalidate(INVALIDATION_FLAG_STYLES);
	}

	public function get countLabel():Label
	{
		return _countLabel;
	}

	public function get nameLabel():Label
	{
		return _nameLabel;
	}

}
}
