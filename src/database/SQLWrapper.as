package database
{
	import flash.data.SQLResult;
	import flash.data.SQLStatement;

	public class SQLWrapper
	{
		public var responder:DatabaseResponder;
		public var statement:SQLStatement;
		public var result:SQLResult;
		
		// Called when a query is executed successfully or unsuccessfully. Usually called to dispatch events
		public var onResult:Function;
		public var onError:Function;
		
		// Removes event listeners for the garbage collector  
		public var cleanUp:Function; 
		
		public function SQLWrapper()
		{
		}
	}
}