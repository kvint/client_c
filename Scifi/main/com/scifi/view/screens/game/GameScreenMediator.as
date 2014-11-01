/**
 * Created with IntelliJ IDEA.
 * User: Neste
 * Date: 13.12.12
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */

package com.scifi.view.screens.game {

	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

	public class GameScreenMediator extends FeathersMediator
{
	private static const log	:ILogger 	= getLogger(GameScreenMediator);

	public static const NAME	:String		= "LoginScreenMediator";

	[Inject]
	public var screen			:GameScreen;

	[Inject]
	public var chat				:IChatService;

	override public function initializeComplete():void
	{
		screen.addChild(chat.view);
	}

}
}
