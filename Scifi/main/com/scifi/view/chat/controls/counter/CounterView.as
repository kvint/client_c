/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.controls.counter
{
import com.scifi.utils.providers.IViewDataProvider;
import com.scifi.utils.providers.ViewDataProvider;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

public class CounterView extends LayoutGroup
{
	public static const CHILD_COUNTER_VALUE_LABEL:String = "child-counter-value-label";

	private var _valueLabel:Label = new Label();
	private var _countProvider:IViewDataProvider = new ViewDataProvider();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();

		valueLabel.styleNameList.add(CHILD_COUNTER_VALUE_LABEL);

		addChild(valueLabel);
	}

	public function get countProvider():IViewDataProvider
	{
		return _countProvider;
	}

	public function get valueLabel():Label
	{
		return _valueLabel;
	}
}
}
