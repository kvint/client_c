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

import feathers.themes.MetalWorksDesktopTheme;

import starling.core.Starling;

public class ChatTheme extends MetalWorksDesktopTheme {

	override protected function initializeTextures():void
	{
		super.initializeTextures();
	}

	override protected function initializeDimensions():void
	{
		super.initializeDimensions();
	}

	override protected function initializeStage():void
	{
		Starling.current.stage.color = 0x000000;
		Starling.current.nativeStage.color = 0x000000;
	}

	override protected function initializeFonts():void
	{
		super.initializeFonts();
	}

	override protected function initializeStyleProviders():void
	{
		super.initializeStyleProviders();

//		getStyleProviderForClass(Tree).defaultStyleFunction 							= setTreeStyles;
//		getStyleProviderForClass(List).setFunctionForStyleName(Tree.DEFAULT_CHILD_NAME_LIST, treeListInitializer);
	}

	/*private function setContentLayerViewStyles(view:ContentLayerView):void
	{
		view.layout = new AnchorLayout();

		var topBarView:AnchorLayoutData = new AnchorLayoutData();

		topBarView.left = 0;
		topBarView.top = 0;
		topBarView.right = 0;

		view.topBarView.layoutData = topBarView;
	}*/

}
}
