package database
{
  
  import flash.data.SQLConnection;
  import flash.data.SQLMode;
  import flash.data.SQLResult;
  import flash.data.SQLStatement;
  import flash.events.EventDispatcher;
  import flash.events.SQLErrorEvent;
  import flash.events.SQLEvent;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.net.Responder;
  
  public class Database
  {
    
    private var dbFile:File;
    public var aConn:SQLConnection;		
    private var sqlStatementFactory:SQLStatementFactory;
    
    public static const TABLES_CREATED:String = "TABLES_CREATED";
    
    private var const CREATE_TABLE_PODCASTS = "CREATE TABLE IF NOT EXISTS podcasts (id INTEGER PRIMARY KEY AUTOINCREMENT, podcasts TEXT, dropDate DATE NOT NULL )";
    
    public function Database()
    {
    }
  }
}