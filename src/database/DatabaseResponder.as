package database
{
	import flash.events.EventDispatcher;

	public class DatabaseResponder extends EventDispatcher
	{
		[Event(name="errorEvent",  type="database.DatabaseEvent")]
		[Event(name="resultEvent", type="database.DatabaseEvent")]
		
		public function DatabaseResponder()
		{
		}
	}
}