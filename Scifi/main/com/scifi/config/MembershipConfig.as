/**
 * Created by mikhailkuts on 03.10.14.
 */
package com.scifi.config {

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class MembershipConfig implements IConfig {

	[Inject]
	public var injector		:IInjector;

	public function configure():void
	{
		mapMembership();
	}

	private function mapMembership():void
	{
	}

}
}
