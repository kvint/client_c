/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.conversations
{
import com.scifi.view.chat.controls.counter.CounterView;

import feathers.controls.ToggleButton;
import feathers.events.FeathersEventType;

public class ConversationsBar extends ToggleButton
{
	private var _counterView:CounterView = new CounterView();

	override protected function initialize():void
	{
		super.initialize();

		addChild(counterView);

		counterView.addEventListener(FeathersEventType.RESIZE, child_onResize);
	}

	override protected function layoutContent():void
	{
		super.layoutContent();

		counterView.validate();

		counterView.x = actualWidth - counterView.width / 2;
		counterView.y = actualHeight - counterView.height / 2;
	}

	protected function child_onResize():void
	{
		invalidate(INVALIDATION_FLAG_STYLES);
	}

	public function get counterView():CounterView
	{
		return _counterView;
	}
}
}
