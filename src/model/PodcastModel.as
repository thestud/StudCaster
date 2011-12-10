package model
{
  import mx.collections.ArrayCollection;
  
  [Bindable]	
  public class PodcastModel
  {
    public function PodcastModel()
    {
    }
    
    public var podcastCollection:ArrayCollection = new ArrayCollection();
    
    private static var instance:PodcastModel;
    
    public static function getInstance():PodcastModel
    {
      if(!instance)
        instance = new PodcastModel();
      
      return instance;
    }
    
  }
}