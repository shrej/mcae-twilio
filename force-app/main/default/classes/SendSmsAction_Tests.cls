@isTest
private class SendSmsAction_Tests {
    @isTest
    private static void testSendSmsActionSuccess() {
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            201,
            'Created',
            'Created',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        List <SendSmsAction.TwilioSmsRequest> requests = new List<SendSmsAction.TwilioSmsRequest>();
        SendSmsAction.TwilioSmsRequest request = new SendSmsAction.TwilioSmsRequest();
        request.toPhoneNumber = '+123456789';
        request.messageToSend = 'hi!';
        requests.add(request);
        List <SendSmsAction.TwilioSmsResponse> responses = SendSmsAction.sendTextMessages(requests);
        // Set mock callout class 
        System.assertEquals(responses.size(), 1, 'There should be exactly 1 response');
       System.assertEquals(responses.get(0).statusCode, 201, 'The status code should be 201');
    }

    @isTest
    private static void testSendSmsActionFailure() {
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            500,
            'Internal Server Error',
            '',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        List <SendSmsAction.TwilioSmsRequest> requests = new List<SendSmsAction.TwilioSmsRequest>();
        SendSmsAction.TwilioSmsRequest request = new SendSmsAction.TwilioSmsRequest();
        request.toPhoneNumber = '+123456789';
        request.messageToSend = 'hi!';
        requests.add(request);
        List <SendSmsAction.TwilioSmsResponse> responses = SendSmsAction.sendTextMessages(requests);
        // Set mock callout class 
        System.assertEquals(responses.size(), 1, 'There should be exactly 1 response');
       System.assertEquals(responses.get(0).statusCode, 500, 'The status code should be 500');
    }
}
