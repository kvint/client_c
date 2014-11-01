/*
 * User: kuts
 * Date: 6/14/13
 */
package com.scifi.view.screens.game.settings {

import flash.display.StageDisplayState;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.core.Starling;

public class SettingsPanelMediator extends FeathersMediator {

	private static const log:ILogger = getLogger(SettingsPanelMediator);

	public static const NAME:String = 'SettingsPanelMediator';

	private static function toggleFullscreen():void
	{
		if (Starling.current.nativeStage.displayState == StageDisplayState.NORMAL)
			Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN;
		else
			Starling.current.nativeStage.displayState = StageDisplayState.NORMAL;
	}

	public function SettingsPanelMediator()
	{
		super();
	}

	[Inject]
	public var view:SettingsPanelView;

	override public function initializeComplete():void
	{
		view.fullscreenButton.label = "[  ]";

		Starling.current.nativeStage.addEventListener(MouseEvent.CLICK, handleStageClick);
	}

	private function handleStageClick(me:MouseEvent):void
	{
		var fullscreenBtnBounds:Rectangle;

		fullscreenBtnBounds = view.fullscreenButton.getBounds(view.fullscreenButton.parent);
		var globalPoint:Point = view.fullscreenButton.localToGlobal(new Point(0, 0));

		fullscreenBtnBounds.x = globalPoint.x;
		fullscreenBtnBounds.y = globalPoint.y;

		if (fullscreenBtnBounds.contains(me.stageX, me.stageY))
			toggleFullscreen();
	}

}
}
