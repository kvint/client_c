package {

import com.junkbyte.console.Cc;
import com.scifi.GameConfig;
import com.scifi.GameContext;
import com.scifi.model.ModelEvent;
import com.scifi.view.starling.StarlingStageView;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.LOGGER_FACTORY;
import org.as3commons.logging.api.getLogger;
import org.as3commons.logging.setup.LevelTargetSetup;
import org.as3commons.logging.setup.LogSetupLevel;
import org.as3commons.logging.setup.target.FlashConsoleTarget;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.framework.api.IContext;
import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

import starling.core.Starling;
import starling.events.Event;

[SWF(width="400", height="600", frameRate="60", backgroundColor="#303335")]
public class App extends Sprite
{
	private static const log				:ILogger 			= getLogger(App);

	private var _starling					:Starling;

	private var _context					:IContext;

	public function App()
	{
		loaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderInfo_onComplete);
	}

	public function loaderInfo_onComplete(event:flash.events.Event):void
	{
		loaderInfo.removeEventListener(flash.events.Event.COMPLETE, loaderInfo_onComplete);

		init();
	}

	private function init():void
	{
		initLogging();
		initStarling();
		initRobotlegs()
	}

	private function initLogging():void
	{
		//LOGGER_FACTORY.setup = null; //Use in release build
		var logSetupLevel:LogSetupLevel = LogSetupLevel.INFO;

		logSetupLevel = LogSetupLevel.DEBUG;

		LOGGER_FACTORY.setup = new LevelTargetSetup( new FlashConsoleTarget(), logSetupLevel ); //Use in debug build
	}

	private function initRobotlegs():void
	{
		_context = new GameContext()
			.install(MVCSBundle, StarlingViewMapExtension)
			.configure(GameConfig, new ContextView(this), _starling);
	}

	private function initStarling():void
	{
//		Starling.handleLostContext = true;

		_starling = new Starling(StarlingStageView, stage);

//		Starling.current.showStats = true;

		//_starling.context.enableErrorChecking = true;

		Cc.store("starling", _starling);

		_starling.antiAliasing = 1;// no need for 2D content

		_starling.addEventListener(starling.events.Event.ROOT_CREATED, starling_onRootCreated);

		_starling.start();
	}

	private function starling_onRootCreated(event:starling.events.Event):void
	{
		_starling.removeEventListener(starling.events.Event.ROOT_CREATED, starling_onRootCreated);

		stage.addEventListener(flash.events.Event.RESIZE, handleNativeStageResize);

		GameContext.instance.dispatchModelEvent(ModelEvent.APP_INITIALIZE);
	}

	private function handleNativeStageResize(event:flash.events.Event):void
	{
		_starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);

		_starling.stage.stageWidth = stage.stageWidth;
		_starling.stage.stageHeight = stage.stageHeight;
	}

	private function onEnterFrame(event:flash.events.Event):void
	{
		_starling.nextFrame();
	}

}
}