public class ellipticApiTest {
    public static String get_Signature(String secret, String time_of_request, String http_method, String http_path, String payload)
    {
      //Blob beforeblob = Blob.valueOf(secret);
        
      String salt = String.valueOf(Crypto.getRandomInteger());
      Blob data = crypto.generateMac('HmacSHA256',Blob.valueOf(salt), Blob.valueOf(secret));
	  String request_text = time_of_request + http_method + http_path.toLowerCase() + payload;
	  String ConcateData= request_text + data;
      system.debug('Concate Data = '+ConcateData);
      blob value = Blob.valueOf(ConcateData);
      system.debug('Encoding Signature  =>   '+EncodingUtil.base64Encode(value)); 
        
      return EncodingUtil.base64Encode(value);
    }
}