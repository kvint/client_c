/*
 * User: kuts
 * Date: 6/14/13
 */
package com.scifi.view.screens.game.settings {

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.layout.HorizontalLayout;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

public class SettingsPanelView extends LayoutGroup {

	private static const 	log						:ILogger 	= getLogger(SettingsPanelView);

	public static const 	NAME					:String 	= 'SettingsPanelView';

	private var _fullscreenButton					:Button 	= new Button();

	public function SettingsPanelView()
	{
		super();
	}

	override protected function initialize():void
	{
		addChild(fullscreenButton);
	}

	public function get fullscreenButton():Button
	{
		return _fullscreenButton;
	}

}
}
