public with sharing class TwilioUtil {
    private static final String TWILIO_NAMED_CREDENTIAL = 'callout:TwilioMCAE';
    private static final TwilioMCAESetting__mdt TWILIO_CMT = TwilioMCAESetting__mdt.getInstance('default');

    public static Integer sendMessage(Map<String, String> payload) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(TWILIO_NAMED_CREDENTIAL);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            String body = urlEncode(payload);
            request.setBody(body);
            request.setCompressed(false);
            try {
              HttpResponse response = http.send(request);
              if (response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
                System.debug(response.getBody());
              }
              return response.getStatusCode();
            } catch (Exception e) {
              System.debug('There was an error sending the message');
              System.debug('Message: ' + e.getMessage() + '\n' +
                'Cause: ' + e.getCause() + '\n' +
                'Stack trace: ' + e.getStackTraceString());
                return null;
            }
          }

          @TestVisible
          private static String urlEncode(Map<String, String> inputMap) {
            String urlEncodedString = '';
            for(String key : inputMap.keySet()) {
                urlEncodedString += EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(inputMap.get(key), 'UTF-8') + '&';
            }
            return urlEncodedString.removeEnd('&');    
        }

        public static Map<String,String> getTwilioPayload(Map<String, String> initialPayload, String messageType, String mediaUrl) {
          Map<String,String> finalPayload = initialPayload.clone();
          String fromString = messageType == 'whatsapp' ? 'whatsapp:' + TWILIO_CMT.FromPhoneNumberWhatsApp__c : TWILIO_CMT.FromPhoneNumber__c;
          if(!String.isBlank(TWILIO_CMT.MessagingServiceSid__c)) {
            finalPayload.put('MessagingServiceSid', TWILIO_CMT.MessagingServiceSid__c);
          } else {
            finalPayload.put('From', fromString);
          }
          if(!String.isBlank(mediaUrl)) {
            finalPayload.put('MediaUrl', mediaUrl);
          }
          return finalPayload;
        }
}