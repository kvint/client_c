/**
 * Created by AlexanderSla on 21.11.2014.
 */
package tests {
	import com.chat.model.presences.IPresences;
	import com.chat.model.presences.IPresencesHandler;
	import com.chat.model.presences.Presences;

	import org.flexunit.asserts.assertEquals;

	import robotlegs.bender.framework.impl.RobotlegsInjector;

	public class PresencesTest {

		private var injector:RobotlegsInjector;

		[Before]
		public function setUp():void {
			injector = new RobotlegsInjector();
		}

		[Test]
		public function testInstance():void {
			var presences:Presences = new Presences();
			presences.subscribe();

		}
	}
}
