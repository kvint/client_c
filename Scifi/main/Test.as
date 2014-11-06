/**
 * Created by kvint on 04.11.14.
 */
package {
	import flash.display.Sprite;

	import model.communicators.CommunicatorProvider;

	import org.igniterealtime.xiff.core.UnescapedJID;

	import org.igniterealtime.xiff.data.IQ;

	import org.igniterealtime.xiff.data.Message;
	import org.igniterealtime.xiff.data.archive.ListStanza;
	import org.igniterealtime.xiff.data.im.RosterItemVO;

	public class Test extends Sprite {
		public function Test() {
			var c:CommunicatorProvider = new CommunicatorProvider();
			trace(c.getCommunicator(new Message()))
			trace(c.getCommunicator(new RosterItemVO(null)));
		}
	}
}
