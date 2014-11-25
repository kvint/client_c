/**
 * Created by AlexanderSla on 21.11.2014.
 */
package tests {
	import com.chat.model.config.PresenceStatuses;
	import com.chat.model.presences.Presences;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.Presence;

	import robotlegs.bender.framework.impl.RobotlegsInjector;

	public class PresencesTest {

		private var injector:RobotlegsInjector;
		private var presences:Presences;

		private var bob:FakePresence;
		private var joe:FakePresence;

		[Before]
		public function setUp():void {
			injector = new RobotlegsInjector();
			presences = new Presences();

			bob = new FakePresence("bob@localhost");
			joe = new FakePresence("joe@localhost");
		}

		[Test]
		public function basicSubscribe():void {

			assertEquals(0, bob.showStatus);
			presences.subscribe(bob);
			assertEquals(PresenceStatuses.UNKNOWN, bob.showStatus);
		}

		[Test]
		public function testSubscribeAfterHandle():void {

			var bobPresence:Presence = new Presence(null, new UnescapedJID(bob.uid).escaped);
			presences.handlePresence(bobPresence);
			presences.subscribe(bob);

			assertEquals(bob.showStatus, PresenceStatuses.ONLINE);
		}


		[Test]
		public function testUnavailable():void {
			var bobPresence:Presence = new Presence(null, new UnescapedJID(bob.uid).escaped);
			bobPresence.type = Presence.TYPE_UNAVAILABLE;
			presences.handlePresence(bobPresence);
			presences.subscribe(bob);

			assertEquals(bob.showStatus, PresenceStatuses.OFFLINE);
		}
	}
}

import com.chat.model.presences.IPresenceStatus;

class FakePresence implements IPresenceStatus {

	private var _uid:String;
	private var _status:int;

	public function FakePresence(uid:String) {
		_uid = uid;
	}


	public function set showStatus(value:int):void {
		_status = value;
	}

	public function set textStatus(value:String):void {
	}

	public function get uid():String {
		return _uid;
	}

	public function get showStatus():int {
		return _status;
	}
}
