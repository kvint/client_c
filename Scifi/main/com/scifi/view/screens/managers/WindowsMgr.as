/**
 * Created by kuts on 2/19/14.
 */
package com.scifi.view.screens.managers {

import com.scifi.view.accessories.windows.manager.WindowsManager;
import com.scifi.view.factories.ViewFactories;
import com.scifi.view.items.description.InventoryItemDescriptionWindow;
import com.scifi.view.items.description.NpcDescriptionWindow;
import com.scifi.view.screens.managers.data.ScreenWindowData;
import com.scifi.view.ui.components.popup.components.Window;
import com.scifi.view.ui.states.UIStates;
import feathers.core.PopUpManager;
import feathers.events.FeathersEventType;
import flash.utils.Dictionary;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Quad;
import starling.events.Event;

public class WindowsMgr implements WindowsManager {

	private static const log					:ILogger 					= getLogger(WindowsMgr);

	public static const NAME					:String 					= "ScreenWindowsManager";

	public static var instance					:WindowsMgr 				= new WindowsMgr();

	private var _rootScreen						:DisplayObjectContainer 	= null;

	private var _screensHash					:Dictionary 				= new Dictionary(); // Dictionary.<ScreenWindowData>

	private var _npcDescriptionWindowsHash		:Dictionary 				= new Dictionary();
	private var _itemDescriptionWindowsHash		:Dictionary 				= new Dictionary();

	private var _overlayFactory					:Function 					= null;

	public function initStates():void
	{
		var windowData:ScreenWindowData;

		for (var screenId:int in UIStates.instance.windowsStates)
		{
			_screensHash[screenId] = new Dictionary();

			for (var windowId:int in UIStates.instance.windowsStates[screenId])
			{
				windowData = new ScreenWindowData();

				if (UIStates.instance.windowsStates[screenId].hasOwnProperty(windowId))
				{
					windowData.state = UIStates.instance.windowsStates[screenId][windowId];
					_screensHash[screenId][windowId] = windowData;
				}
			}
		}
	}

	public function showWindow(	windowId:int,
								isModal:Boolean = false,
								isMovable:Boolean = true,
								isClosable:Boolean = true,
								disposeOnClose:Boolean = false):void
	{
		var windowData:ScreenWindowData = getScreenWindowData(windowId);

		if (!windowData)
		{
			windowData = new ScreenWindowData();
			setScreenWindowData(windowId, windowData);
		}

		if (windowData.window)
		{
			var windowClass:Class = Object(windowData.window).constructor;
			windowData.window.removeEventListener(Window.CLOSE, window_onClose);
			windowData.window = new windowClass();
			windowData.window.addEventListener(Window.CLOSE, window_onClose);
			windowData.window.windowId = windowId;
		}
		else
			windowData.window = createWindow(windowId);

		if (!windowData.state)
		{
			windowData.window.isMovable = isMovable;
			windowData.window.isClosable = isClosable;
		}
		else
		{
			windowData.window.isMovable = windowData.state.movable;
			windowData.window.isClosable = windowData.state.closable;
			windowData.window.stateProvider = windowData.state;
		}

		windowData.window.disposeOnClose = disposeOnClose;

		if (isModal)
		{
			windowData.overlay = createOverlay();
			rootScreen.addChild(windowData.overlay);
		}

		rootScreen.addChild(windowData.window);

		function createWindow(windowId:int):Window
		{
			var window:Window = ViewFactories.windowsFactory.createWindow(windowId);

			window.addEventListener(Window.CLOSE, window_onClose);

			window.windowId = windowId;

			return window;
		}

		function createOverlay():DisplayObject
		{
			if (!overlayFactory)
				overlayFactory = defaultOverlayFactory;

			var overlay:DisplayObject = overlayFactory();

			overlay.width = rootScreen.width;
			overlay.height = rootScreen.height;

			return overlay;
		}
	}

	public function hideWindow(windowId:int, dispose:Boolean = false):void
	{
		if (!activeScreenWindowsData || !activeScreenWindowsData[windowId])
			return;

		var windowData:ScreenWindowData = activeScreenWindowsData[windowId];

		if (isWindowOnScreen(windowId) && windowData.window.stateProvider)
			windowData.window.stateProvider.visible = false;

		removeWindowFromScreen(windowId, dispose);
	}

	public function isWindowOnScreen(windowId:int):Boolean
	{
		var windowData:ScreenWindowData = getScreenWindowData(windowId);
		return windowData ? rootScreen.contains(windowData.window) : null;
	}

	public function removeAllWindows():void
	{
		if (activeScreenWindowsData == null)
			return;

		for each(var data:ScreenWindowData in activeScreenWindowsData)
			if (data.window)
				removeWindowFromScreen(data.window.windowId);
	}

	public function restoreWindows():void
	{
		if (!activeScreenWindowsData)
			return;

		for each(var data:ScreenWindowData in activeScreenWindowsData)
			if (data.state && data.state.visible)
				showWindow(data.state.windowId);
	}

	public function showNpcDescriptionWindow(npcIdx:int):NpcDescriptionWindow
	{
		if (_npcDescriptionWindowsHash[npcIdx])
			return _npcDescriptionWindowsHash[npcIdx];

		var window:NpcDescriptionWindow = new NpcDescriptionWindow(npcIdx);

		window.addEventListener(Window.CLOSE, npcDescriptionWindow_onClose);

		PopUpManager.addPopUp(window, false);

		window.validate();

		window.x = (PopUpManager.root.width - window.width) * 0.5;
		window.y = (PopUpManager.root.height - window.height) * 0.5;

		_npcDescriptionWindowsHash[npcIdx] = window;

		return window;
	}

	public function hideNpcDescriptionWindow(npcIdx:int):void
	{
		var window:NpcDescriptionWindow = _npcDescriptionWindowsHash[npcIdx];

		if (!window)
			return;

		window.removeEventListener(Window.CLOSE, npcDescriptionWindow_onClose);

		if (PopUpManager.isPopUp(window))
			PopUpManager.removePopUp(window);

		delete _npcDescriptionWindowsHash[npcIdx];
	}

	private function npcDescriptionWindow_onClose(event:Event):void
	{
		var window:NpcDescriptionWindow = event.currentTarget as NpcDescriptionWindow;
		hideNpcDescriptionWindow(int(window.npcIdxProvider.data));
	}

	public function showItemDescriptionWindow(item:Object):InventoryItemDescriptionWindow
	{
		if (_itemDescriptionWindowsHash[item])
			return _itemDescriptionWindowsHash[item];

		var window:InventoryItemDescriptionWindow = new InventoryItemDescriptionWindow(item);

		window.addEventListener(Window.CLOSE, itemDescriptionWindow_onClose);

		PopUpManager.addPopUp(window, false);

		window.validate();

		window.x = (PopUpManager.root.width - window.width) * 0.5;
		window.y = (PopUpManager.root.height - window.height) * 0.5;

		_itemDescriptionWindowsHash[item] = window;

		return window;
	}

	public function hideItemDescriptionWindow(item:Object):void
	{
		var window:InventoryItemDescriptionWindow = _itemDescriptionWindowsHash[item];

		if (!window)
			return;

		window.removeEventListener(Window.CLOSE, itemDescriptionWindow_onClose);

		if (PopUpManager.isPopUp(window))
			PopUpManager.removePopUp(window);

		delete _itemDescriptionWindowsHash[item];
	}

	private function itemDescriptionWindow_onClose(event:Event):void
	{
		var window:InventoryItemDescriptionWindow = event.currentTarget as InventoryItemDescriptionWindow;
		hideItemDescriptionWindow(window.item);
	}

	protected function removeWindowFromScreen(windowId:int, dispose:Boolean = false):void
	{
		if (!activeScreenWindowsData || !activeScreenWindowsData[windowId])
			return;

		var windowData:ScreenWindowData = activeScreenWindowsData[windowId];

		if (isWindowOnScreen(windowId))
		{
			windowData.window.disposeOnClose = dispose;

			if (dispose)
				windowData.window.removeEventListener(Window.CLOSE, window_onClose);

			windowData.window.removeFromParent(dispose);

			if (windowData.overlay)
				windowData.overlay.removeFromParent(dispose);
		}

		if (dispose)
			delete activeScreenWindowsData[windowId];
	}

	protected function getScreenWindowData(windowId:int):ScreenWindowData
	{
		return activeScreenWindowsData ? activeScreenWindowsData[windowId] : null
	}

	protected function setScreenWindowData(windowId:int, data:ScreenWindowData):void
	{
		if (!activeScreenWindowsData)
			_screensHash[activeScreenId] = new Dictionary();
		activeScreenWindowsData[windowId] = data;
	}

	public function get overlayFactory():Function
	{
		return _overlayFactory;
	}

	public function set overlayFactory(value:Function):void
	{
		_overlayFactory = value;
	}

	protected static function defaultOverlayFactory():DisplayObject
	{
		var quad:Quad = new Quad(100, 100, 0x000000);
		quad.alpha = 0;
		return quad;
	}

	protected function window_onClose(event:Event):void
	{
		var window:Window = event.currentTarget as Window;
		hideWindow(window.windowId, window.disposeOnClose);
	}

	protected function root_onRemovedFromStage(event:Event):void
	{
		_rootScreen.removeEventListener(Event.REMOVED_FROM_STAGE, root_onRemovedFromStage);
		removeAllWindows();
	}

	protected function root_onResize(event:Event):void
	{
		if (activeScreenWindowsData)
			return;

		for each(var data:ScreenWindowData in activeScreenWindowsData)
		{
			if (!isWindowOnScreen(data.window.windowId) || !data.overlay)
				continue;
			data.overlay.width = rootScreen.width;
			data.overlay.height = rootScreen.height;
		}
	}

	public function get rootScreen():DisplayObjectContainer
	{
		return _rootScreen;
	}

	public function set rootScreen(value:DisplayObjectContainer):void
	{
		if (_rootScreen === value)
			return;

		if (_rootScreen)
		{
			_rootScreen.removeEventListener(FeathersEventType.RESIZE, root_onResize);
			_rootScreen.removeEventListener(Event.REMOVED_FROM_STAGE, root_onRemovedFromStage);
		}

		_rootScreen = value;

		_rootScreen.addEventListener(FeathersEventType.RESIZE, root_onResize);
		_rootScreen.addEventListener(Event.REMOVED_FROM_STAGE, root_onRemovedFromStage);

		restoreWindows();
	}

	protected function get activeScreenWindowsData():Dictionary
	{
		return _screensHash[int(activeScreenId)];
	}

	protected static function get activeScreenId():String
	{
		return ScreensManagerImpl.instance.activeScreenID;
	}

}
}
