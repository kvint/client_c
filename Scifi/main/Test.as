/**
 * Created by kvint on 04.11.14.
 */
package {
	import flash.display.Sprite;

	import model.communicators.CommunicatorProvider;

	import org.igniterealtime.xiff.core.AbstractJID;
	import org.igniterealtime.xiff.core.EscapedJID;

	import org.igniterealtime.xiff.core.UnescapedJID;

	import org.igniterealtime.xiff.data.IQ;

	import org.igniterealtime.xiff.data.Message;
	import org.igniterealtime.xiff.data.archive.List;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.igniterealtime.xiff.data.rsm.Set;

	public class Test extends Sprite {
		public function Test() {
			var msg:Message = new Message();
			msg.id = "id1";
			msg.body = "blablabla";
			msg.receipt = Message.RECEIPT_REQUEST;
			trace(msg);
			msg.receipt = null;
			trace(msg);
		}
	}
}
