/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.controls.counter
{
import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class CounterMediator extends FeathersMediator
{
	[Inject]
	public var view:CounterView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		setCount();

		view.countProvider.subscribe(countProvider_onDataChange);
	}

	private function setCount():void
	{
		view.valueLabel.text = String(view.countProvider.data);
	}

	override public function destroy():void
	{
		view.countProvider.unsubscribe(countProvider_onDataChange);

		super.destroy();
	}

	private function countProvider_onDataChange():void
	{
		setCount();
	}
}
}
