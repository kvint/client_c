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
	import org.igniterealtime.xiff.data.rsm.Set;

	public class Test extends Sprite {
		public function Test() {
			var sett:Set = new Set();
			sett.max = 100;
			trace(sett);
		}
	}
}
