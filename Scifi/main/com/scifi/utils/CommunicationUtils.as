/**
 * Created by kuts on 8/28/14.
 */
package com.scifi.utils {

public class CommunicationUtils {

	/*public static function getLogMessage(base64:String):LogMessage
	{
		var b64:Base64Decoder = new Base64Decoder();
		b64.decode(base64);
		return DataHelper.fromByteArray(new LogMessage(), b64.toByteArray()) as LogMessage;
	}

	public static function getChatMessage(base64:String):ChatMessage
	{
		var b64:Base64Decoder = new Base64Decoder();
		b64.decode(base64);
		return DataHelper.fromByteArray(new ChatMessage(), b64.toByteArray()) as ChatMessage;
	}

	public static function getChatSubUsername(identity:String, sender:String):String
	{
		identity += ".";
		var ln:int = sender.length - identity.length + 1;
		return sender.substr(identity.length, ln);
	}

	public static function getChatRoomName(prexif:String, id:Object, identity:String, domain:String):String
	{
		return new StringBuffer().append(prexif).append(".").append(id).append("@")
			.append(identity).append(".").append(domain).toString();
	}

	public static function getChatUsername(identity:String, name:String):String
	{
		return new StringBuffer().append(identity).append(".").append(name).toString();
	}

	public static function eventOrderedInsert(events:Object, target:CommunicationEvent):int
	{
		var i:int = events.length;

		while (i > 0 && target.timestamp < (events[i-1] as CommunicationEvent).timestamp)
		{
			events[i] = events[i-1];
			i = i - 1;
		}

		events[i] = target;

		return i;
	}*/

}
}
