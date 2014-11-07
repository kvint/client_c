/*
 Copyright (c) 2014 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package com.scifi.view.theme {

import com.scifi.view.chat.ChatView;
import com.scifi.view.screens.game.GameView;
import com.scifi.view.utils.UIUtils;

import feathers.display.Scale9Image;

import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.themes.MetalWorksDesktopTheme;

import starling.core.Starling;

public class ChatTheme extends MetalWorksDesktopTheme {

	override protected function initializeStage():void
	{
		Starling.current.stage.color = 0x000000;
		Starling.current.nativeStage.color = 0x000000;
	}

	override protected function initializeStyleProviders():void
	{
		super.initializeStyleProviders();

		getStyleProviderForClass(GameView).defaultStyleFunction = setGameViewStyles;
		getStyleProviderForClass(ChatView).defaultStyleFunction = setChatViewStyles;
	}

	private function setGameViewStyles(view:GameView):void
	{
		view.backgroundSkin = new Scale9Image(UIUtils.getScale9RectTexture(6, 6, 0xf332233));

		view.layout = new AnchorLayout();

		var chatView:AnchorLayoutData = new AnchorLayoutData();

		chatView.percentWidth = 100;
		chatView.bottom = 0;

		view.chatView.layoutData = chatView;
	}

	private function setChatViewStyles(view:ChatView):void
	{
		view.layout = new AnchorLayout();

		var containerView:AnchorLayoutData = new AnchorLayoutData();

		containerView.percentWidth = 100;
		containerView.bottomAnchorDisplayObject = view.tabsView;
		containerView.bottom = 0;

//		view.containerView.layoutData = containerView;

		var tabsView:AnchorLayoutData = new AnchorLayoutData();

		tabsView.percentWidth = 100;
		tabsView.bottom = 0;

		view.tabsView.layoutData = tabsView;
	}

}
}
