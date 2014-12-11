/**
 * Created by AlexanderSla on 05.12.2014.
 */
package feathers.data {
	import com.chat.events.CItemCollectionEvent;
	import com.chat.model.data.collections.ICItemCollection;

	import feathers.events.CollectionEventType;

	import starling.events.Event;

	public class CItemListCollection extends ListCollection {

		public function CItemListCollection(data:ICItemCollection) {
			super(data);
		}

		override public function set data(value:Object):void
		{
			removeCollectionListeners();
			super.data = value;
			if(_data is ICItemCollection)
			{
				this.dataDescriptor = new CItemCollectionDescriptor();
			}
			addCollectionListeners();
		}

		override public function set dataDescriptor(value:IListCollectionDataDescriptor):void {
			super.dataDescriptor = value;
		}

		private function addCollectionListeners():void {
			_data.addEventListener(CItemCollectionEvent.CHANGE, redispatchFlashEventLikeStarlingEvent);
			_data.addEventListener(CItemCollectionEvent.ADD_ITEM, redispatchFlashEventLikeStarlingEvent);
			_data.addEventListener(CItemCollectionEvent.RESET, redispatchFlashEventLikeStarlingEvent);
			_data.addEventListener(CItemCollectionEvent.REMOVE_ITEM, redispatchFlashEventLikeStarlingEvent);
			_data.addEventListener(CItemCollectionEvent.REPLACE_ITEM, redispatchFlashEventLikeStarlingEvent);
			_data.addEventListener(CItemCollectionEvent.UPDATE_ITEM, redispatchFlashEventLikeStarlingEvent);
		}

		private function removeCollectionListeners():void {
			if(_data){
				_data.removeEventListener(CItemCollectionEvent.CHANGE, redispatchFlashEventLikeStarlingEvent);
				_data.removeEventListener(CItemCollectionEvent.ADD_ITEM, redispatchFlashEventLikeStarlingEvent);
				_data.removeEventListener(CItemCollectionEvent.RESET, redispatchFlashEventLikeStarlingEvent);
				_data.removeEventListener(CItemCollectionEvent.REMOVE_ITEM, redispatchFlashEventLikeStarlingEvent);
				_data.removeEventListener(CItemCollectionEvent.REPLACE_ITEM, redispatchFlashEventLikeStarlingEvent);
				_data.removeEventListener(CItemCollectionEvent.UPDATE_ITEM, redispatchFlashEventLikeStarlingEvent);
			}
		}

		private function redispatchFlashEventLikeStarlingEvent(e:CItemCollectionEvent):void {
			dispatchEvent(new Event(e.type, e.bubbles, e.data));
		}
		override public function addItemAt(item:Object, index:int):void
		{
			this._dataDescriptor.addItemAt(this._data, item, index);
			//this.dispatchEventWith(Event.CHANGE);
			//this.dispatchEventWith(CollectionEventType.ADD_ITEM, false, index);
		}
		override public function removeItemAt(index:int):Object
		{
			var item:Object = this._dataDescriptor.removeItemAt(this._data, index);
			//this.dispatchEventWith(Event.CHANGE);
			//this.dispatchEventWith(CollectionEventType.REMOVE_ITEM, false, index);
			return item;
		}

		override public function removeAll():void
		{
			if(this.length == 0)
			{
				return;
			}
			this._dataDescriptor.removeAll(this._data);
			//this.dispatchEventWith(Event.CHANGE);
			//this.dispatchEventWith(CollectionEventType.RESET, false);
		}

		override public function setItemAt(item:Object, index:int):void
		{
			this._dataDescriptor.setItemAt(this._data, item, index);
			//this.dispatchEventWith(Event.CHANGE);
			//this.dispatchEventWith(CollectionEventType.REPLACE_ITEM, false, index);
		}
	}
}
