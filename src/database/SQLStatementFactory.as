package database
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	
	import mx.core.IFactory;
	
	public class SQLStatementFactory
	{
		private var aConn:SQLConnection;
		
		public function SQLStatementFactory(aConn:SQLConnection)
		{
			this.aConn = aConn;
		}
		
		/**
		 * This factory avoids duplication of event handlers.
		 * It creates and returns an SQLWrapper Object, which contains a number of properties the calling funnction will find useful.
		 * The two, optional callback functions are useful for controlling asycnhronous program flow.
		 * The callback functions must accept one non-null Array argument, with args[0] being the responder 
		 * 
		 * @param responder Will dispatch DatabaseEvents on success or failure 
		 * @param sqlQuery A query in plaintext. Assumes it's sanitized!		 
		 * @param onResultCallback Optional callback function, in addition to dispatching a DatabaseEvent.RESULT_EVENT through the responder. 
		 * @param onErrorCallback Optional callback function, in addition to dispatching a DatabaseEvent.ERROR_EVENT through the responder.		 
		 * 
		 * @returns SQLWrapper
		 **/
		public function newInstance(responder:DatabaseResponder, sqlQuery:String, onResultCallback:Function = null, onErrorCallback:Function = null):SQLWrapper
		{
			if ( !this.aConn || !this.aConn.connected ) return null;

			var wrapper:SQLWrapper = new SQLWrapper();
			wrapper.responder = responder;	
			
			wrapper.statement = new SQLStatement();
			wrapper.statement.sqlConnection = this.aConn;
			wrapper.statement.text = sqlQuery;		
			
			wrapper.onResult = function onResult(se:SQLEvent):void
				{
					// trace("SQLStatement result event. SQLStatementFactory:0001");
												
					var de:DatabaseEvent = new DatabaseEvent(DatabaseEvent.RESULT_EVENT);
					de.data = wrapper.statement.getResult().data;
					wrapper.responder.dispatchEvent(de);
					// Is there a callback function specified?
					if ( onResultCallback != null )
					{
						var args:Array = [responder];
						onResultCallback(args);
					}							
					wrapper.cleanUp();
				}
						
			wrapper.onError = function onError(see:SQLErrorEvent):void
				{
					// trace("SQLStatement error event. SQLStatementFactory:0002");
						
					var de:DatabaseEvent = new DatabaseEvent(DatabaseEvent.ERROR_EVENT);
					de.data = see.error;
					wrapper.responder.dispatchEvent(de);
					// Callback function?
					if ( onErrorCallback != null ) 
					{								
						var args:Array = [responder];
						onErrorCallback(args);
					}
					wrapper.cleanUp();
				}	
				
			wrapper.statement.addEventListener(SQLEvent.RESULT,wrapper.onResult);
			wrapper.statement.addEventListener(SQLErrorEvent.ERROR,wrapper.onError);
				
			wrapper.cleanUp = function cleanUp():void
			{
				wrapper.statement.removeEventListener(SQLEvent.RESULT, wrapper.onResult);
				wrapper.statement.removeEventListener(SQLErrorEvent.ERROR, wrapper.onError);
			}
						
			return wrapper;
		}
	}
}