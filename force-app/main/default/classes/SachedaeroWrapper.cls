public class SachedaeroWrapper {
    
    public String type;
    Public String id;
    Public String href;
    
    public static SachedaeroWrapper parse(String Json)
    {
        return (SachedaeroWrapper) system.JSON.deserialize(Json, SachedaeroWrapper.class);
    }


}