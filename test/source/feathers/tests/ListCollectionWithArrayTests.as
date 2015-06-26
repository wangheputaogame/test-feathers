package feathers.tests
{
	import feathers.data.ListCollection;
	import feathers.events.CollectionEventType;

	import org.flexunit.Assert;

	import starling.events.Event;

	public class ListCollectionWithArrayTests
	{
		private var _collection:ListCollection;

		[Before]
		public function prepare():void
		{
			this._collection = new ListCollection(
			[
				{ label: "One" },
				{ label: "Two" },
				{ label: "Three" },
			]);
		}

		[After]
		public function cleanup():void
		{
			this._collection = null;
		}

		[Test]
		public function testRemoveAll():void
		{
			var hasChanged:Boolean = false;
			this._collection.addEventListener(Event.CHANGE, function(event:Event):void
			{
				hasChanged = true;
			});
			var hasReset:Boolean = false;
			this._collection.addEventListener(CollectionEventType.RESET, function(event:Event):void
			{
				hasReset = true;
			});
			this._collection.removeAll();
			Assert.assertTrue("Event.CHANGE was not dispatched", hasChanged);
			Assert.assertTrue("CollectionEventType.RESET was not dispatched", hasReset);
			Assert.assertStrictlyEquals("The length property was not changed to 0",
				0, this._collection.length);
		}

		[Test]
		public function testRemoveItemAt():void
		{
			var itemToRemove:Object = this._collection.getItemAt(1);
			var originalLength:int = this._collection.length;
			var expectedIndex:int = 1;
			var hasChanged:Boolean = false;
			this._collection.addEventListener(Event.CHANGE, function(event:Event):void
			{
				hasChanged = true;
			});
			var hasRemovedItem:Boolean = false;
			var indexFromEvent:int = -1;
			this._collection.addEventListener(CollectionEventType.REMOVE_ITEM, function(event:Event, index:int):void
			{
				hasRemovedItem = true;
				indexFromEvent = index;
			});
			this._collection.removeItemAt(expectedIndex);
			Assert.assertTrue("Event.CHANGE was not dispatched", hasChanged);
			Assert.assertTrue("CollectionEventType.REMOVE_ITEM was not dispatched", hasRemovedItem);
			Assert.assertStrictlyEquals("The length property was not changed",
				originalLength - 1, this._collection.length);
			Assert.assertStrictlyEquals("The item was not removed",
				-1, this._collection.getItemIndex(itemToRemove));
			Assert.assertStrictlyEquals("The CollectionEventType.REMOVE_ITEM event data was not the correct index",
				expectedIndex, indexFromEvent);
		}

		[Test]
		public function testRemoveItem():void
		{
			var expectedIndex:int = 1;
			var itemToRemove:Object = this._collection.getItemAt(expectedIndex);
			var originalLength:int = this._collection.length;
			var hasChanged:Boolean = false;
			this._collection.addEventListener(Event.CHANGE, function(event:Event):void
			{
				hasChanged = true;
			});
			var hasRemovedItem:Boolean = false;
			var indexFromEvent:int = -1;
			this._collection.addEventListener(CollectionEventType.REMOVE_ITEM, function(event:Event, index:int):void
			{
				hasRemovedItem = true;
				indexFromEvent = index;
			});
			this._collection.removeItem(itemToRemove);
			Assert.assertTrue("Event.CHANGE was not dispatched", hasChanged);
			Assert.assertTrue("CollectionEventType.REMOVE_ITEM was not dispatched", hasRemovedItem);
			Assert.assertStrictlyEquals("The length property was not changed",
				originalLength - 1, this._collection.length);
			Assert.assertStrictlyEquals("The item was not removed",
				-1, this._collection.getItemIndex(itemToRemove));
			Assert.assertStrictlyEquals("The CollectionEventType.REMOVE_ITEM event data was not the correct index",
				expectedIndex, indexFromEvent);
		}

		[Test]
		public function testAddItem():void
		{
			var itemToAdd:Object = { label: "New Item" };
			var originalLength:int = this._collection.length;
			var expectedIndex:int = originalLength;
			var hasChanged:Boolean = false;
			this._collection.addEventListener(Event.CHANGE, function(event:Event):void
			{
				hasChanged = true;
			});
			var hasAddedItem:Boolean = false;
			var indexFromEvent:int = -1;
			this._collection.addEventListener(CollectionEventType.ADD_ITEM, function(event:Event, index:int):void
			{
				hasAddedItem = true;
				indexFromEvent = index;
			});
			this._collection.addItem(itemToAdd);
			Assert.assertTrue("Event.CHANGE was not dispatched", hasChanged);
			Assert.assertTrue("CollectionEventType.ADD_ITEM was not dispatched", hasAddedItem);
			Assert.assertStrictlyEquals("The length property was not changed",
				originalLength + 1, this._collection.length);
			Assert.assertStrictlyEquals("The item was not added at the correct index",
				expectedIndex, this._collection.getItemIndex(itemToAdd));
			Assert.assertStrictlyEquals("The CollectionEventType.ADD_ITEM event data was not the correct index",
				expectedIndex, indexFromEvent);
		}

		[Test]
		public function testAddItemAt():void
		{
			var itemToAdd:Object = { label: "New Item" };
			var expectedIndex:int = 1;
			var originalLength:int = this._collection.length;
			var hasChanged:Boolean = false;
			this._collection.addEventListener(Event.CHANGE, function(event:Event):void
			{
				hasChanged = true;
			});
			var hasAddedItem:Boolean = false;
			var indexFromEvent:int = -1;
			this._collection.addEventListener(CollectionEventType.ADD_ITEM, function(event:Event, index:int):void
			{
				hasAddedItem = true;
				indexFromEvent = index;
			});
			this._collection.addItemAt(itemToAdd, expectedIndex);
			Assert.assertTrue("Event.CHANGE was not dispatched", hasChanged);
			Assert.assertTrue("CollectionEventType.ADD_ITEM was not dispatched", hasAddedItem);
			Assert.assertStrictlyEquals("The length property was not changed",
				originalLength + 1, this._collection.length);
			Assert.assertStrictlyEquals("The item was not added at the correct index",
				expectedIndex, this._collection.getItemIndex(itemToAdd));
			Assert.assertStrictlyEquals("The CollectionEventType.ADD_ITEM event data was not the correct index",
				expectedIndex, indexFromEvent);
		}

		[Test]
		public function testSetItemAt():void
		{
			var itemToAdd:Object = { label: "New Item" };
			var expectedIndex:int = 1;
			var originalLength:int = this._collection.length;
			var hasChanged:Boolean = false;
			this._collection.addEventListener(Event.CHANGE, function(event:Event):void
			{
				hasChanged = true;
			});
			var hasAddedItem:Boolean = false;
			var indexFromEvent:int = -1;
			this._collection.addEventListener(CollectionEventType.REPLACE_ITEM, function(event:Event, index:int):void
			{
				hasAddedItem = true;
				indexFromEvent = index;
			});
			this._collection.setItemAt(itemToAdd, expectedIndex);
			Assert.assertTrue("Event.CHANGE was not dispatched", hasChanged);
			Assert.assertTrue("CollectionEventType.REPLACE_ITEM was not dispatched", hasAddedItem);
			Assert.assertStrictlyEquals("The length property was incorrectly changed",
				originalLength, this._collection.length);
			Assert.assertStrictlyEquals("The item was not added at the correct index",
				expectedIndex, this._collection.getItemIndex(itemToAdd));
			Assert.assertStrictlyEquals("The CollectionEventType.REPLACE_ITEM event data was not the correct index",
				expectedIndex, indexFromEvent);
		}

		[Test]
		public function testContainsWithItemInCollection():void
		{
			var item:Object = this._collection.getItemAt(1);
			Assert.assertStrictlyEquals("contains() incorrectly returned false",
				true, this._collection.contains(item));
		}

		[Test]
		public function testContainsWithItemNotInCollection():void
		{
			var item:Object = {};
			Assert.assertStrictlyEquals("contains() incorrectly returned true",
				false, this._collection.contains(item));
		}

		[Test]
		public function testGetItemIndexWithItemInCollection():void
		{
			var expectedIndex:int = 1;
			var item:Object = this._collection.getItemAt(expectedIndex);
			Assert.assertStrictlyEquals("getItemIndex() returned the incorrect value",
				expectedIndex, this._collection.getItemIndex(item));
		}

		[Test]
		public function testGetItemIndexWithItemNotInCollection():void
		{
			var item:Object = {};
			Assert.assertStrictlyEquals("getItemIndex() returned the incorrect value",
				-1, this._collection.getItemIndex(item));
		}
	}
}
