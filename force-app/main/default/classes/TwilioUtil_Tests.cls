@isTest
private class TwilioUtil_Tests {
    private static final Map<String,String> PAYLOAD = new Map<String, String>{
        'To' => '+123456789',
        'Body' => '+1987654321'
    }; 

     @isTest 
     private static void testSendMessageWhenSuccess() {
        // Set mock callout class 
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            201,
            'Created',
            'Created',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        
        Integer responseStatusCode = TwilioUtil.sendMessage(PAYLOAD);
        
        // Verify response received contains fake values
        System.assertEquals(201, responseStatusCode, 'The response status code returned was not expected' );
    }

    @isTest 
    private static void testSendMessageWhenFailure() {
       // Set mock callout class 
       HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
           500,
           'Internal Server Error',
           '',
           new Map<String, String>()
       );
       Test.setMock(HttpCalloutMock.class, mock);
       
       Integer responseStatusCode = TwilioUtil.sendMessage(PAYLOAD);
       
        // Verify response received contains fake values
        System.assertEquals(500, responseStatusCode, 'The response status code returned was not expected' );
   }

   @isTest 
   private static void testUrlEncode() {
      String encodedString = TwilioUtil.urlEncode(PAYLOAD);
      System.assertEquals('To=%2B123456789&Body=%2B1987654321', encodedString, 'The response status code returned was not expected' );
  }

  @isTest 
  private static void testGetTwilioPayloadWhenMediaUrlIsProvided() {
    Map<String, String> finalPayload = TwilioUtil.getTwilioPayload(PAYLOAD, 'text', 'https://example.com/media');
    System.assertEquals('https://example.com/media', finalPayload.get('MediaUrl'), 'The media url was not found in transformed payload');
 }

}