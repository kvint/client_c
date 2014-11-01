/**
 * Created by mikhailkuts on 03.10.14.
 */
package com.scifi.config {

import com.scifi.controller.StartApp;
import com.scifi.model.ModelEvent;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class CommandsConfig implements IConfig {

	[Inject]
	public var commandMap		:IEventCommandMap;

	public function configure():void
	{
		mapCommands();
	}

	private function mapCommands():void
	{
		commandMap.map(ModelEvent.APP_INITIALIZE, ModelEvent)					.toCommand(StartApp);
	}

}
}
