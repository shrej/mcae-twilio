@isTest
private class SendWhatsAppMessageAction_Tests {
    @isTest
    private static void testSendWhatsAppMessageActionSuccess() {
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            201,
            'Created',
            'Created',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        List <SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest> requests = new List<SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest>();
        SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest request = new SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest();
        request.toPhoneNumber = '+123456789';
        request.messageToSend = 'hi!';
        requests.add(request);
        List <SendWhatsAppMessageAction.TwilioWhatsAppMessageResponse> responses = SendWhatsAppMessageAction.sendWhatsAppMessages(requests);
        // Set mock callout class 
        System.assertEquals(responses.size(), 1, 'There should be exactly 1 response');
       System.assertEquals(responses.get(0).statusCode, 201, 'The status code should be 201');
    }

    @isTest
    private static void testSendWhatsAppMessageActionFailure() {
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            500,
            'Internal Server Error',
            '',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        List <SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest> requests = new List<SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest>();
        SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest request = new SendWhatsAppMessageAction.TwilioWhatsAppMessageRequest();
        request.toPhoneNumber = '+123456789';
        request.messageToSend = 'hi!';
        requests.add(request);
        List <SendWhatsAppMessageAction.TwilioWhatsAppMessageResponse> responses = SendWhatsAppMessageAction.sendWhatsAppMessages(requests);
        // Set mock callout class 
        System.assertEquals(responses.size(), 1, 'There should be exactly 1 response');
       System.assertEquals(responses.get(0).statusCode, 500, 'The status code should be 500');
    }
}
