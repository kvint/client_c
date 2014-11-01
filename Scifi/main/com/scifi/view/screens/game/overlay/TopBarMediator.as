/**
 * Created with IntelliJ IDEA.
 * User: kuts
 * Date: 12/2/13
 * Time: 7:18 PM
 * To change this template use File | Settings | File Templates.
 */
package com.scifi.view.screens.game.overlay {

import com.scifi.view.screens.game.overlay.bars.bot.BotBarView;
import com.scifi.view.screens.game.overlay.bars.clocks.ClocksBarView;
import com.scifi.view.screens.game.overlay.bars.navigation.NavigationBarView;
import com.scifi.view.screens.game.overlay.bars.pilot.PilotBarView;
import com.scifi.view.screens.game.settings.SettingsPanelView;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;
import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;
import starling.display.DisplayObject;

public class TopBarMediator extends FeathersMediator {

	private static const log	:ILogger = getLogger(TopBarMediator);

	public static const NAME	:String = "TopBarMediator";

	[Inject]
	public var bar				:TopBarView;

	override public function initializeComplete():void
	{
		bar.leftItems = new <DisplayObject>[
			new PilotBarView(),
			new BotBarView()
		];

		bar.rightItems = new <DisplayObject>[
			new ClocksBarView(),
			new NavigationBarView(),
			new SettingsPanelView()
		];
	}

}
}
