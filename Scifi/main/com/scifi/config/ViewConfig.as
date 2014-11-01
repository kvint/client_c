/**
 * Created by mikhailkuts on 03.10.14.
 */
package com.scifi.config
{

import com.scifi.view.screens.game.GameScreen;
import com.scifi.view.screens.game.GameScreenMediator;
import com.scifi.view.screens.managers.ScreensManager;
import com.scifi.view.screens.managers.ScreensManagerImpl;
import com.scifi.view.starling.StarlingStageMediator;
import com.scifi.view.starling.StarlingStageView;
import com.scifi.view.screens.game.GameMediator;
import com.scifi.view.screens.game.GameView;
import com.scifi.view.theme.UITheme;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

	public class ViewConfig implements IConfig
{

	[Inject]
	public var mediatorMap:IMediatorMap;

	[Inject]
	public var injector:IInjector;

	public function configure():void
	{
		mapView();
	}

	private function mapView():void
	{
		injector.map(ScreensManager).toValue(ScreensManagerImpl.instance);
		injector.map(UITheme).toValue(UITheme.instance);

		mediatorMap.map(StarlingStageView).toMediator(StarlingStageMediator);

		mediatorMap.map(GameView).toMediator(GameMediator);

		mediatorMap.map(GameScreen).toMediator(GameScreenMediator);


	}

}
}
