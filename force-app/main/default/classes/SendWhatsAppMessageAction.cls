/**
 * @description Send Whatsapp message with Twilio Invocable Action
 */
global with sharing class SendWhatsAppMessageAction {
  /**
   * @description Send Whatsapp message Invocable Action with twilio
   * @param messages A list of Twilio Whatsapp message requests
   **/
  @InvocableMethod(
    callout=true
    label='Send a Whatsapp message with Twilio'
    description='Send Whatspp message with Twilio.'
  )
  global static List<TwilioWhatsAppMessageResponse> sendWhatsAppMessages(
    List<TwilioWhatsAppMessageRequest> messages
  ) {
    List<TwilioWhatsAppMessageResponse> responses = new List<TwilioWhatsAppMessageResponse>();
    for (TwilioWhatsAppMessageRequest message : messages) {
      TwilioWhatsAppMessageResponse response = new TwilioWhatsAppMessageResponse();
      Map<String, String> intialPayload = new Map<String, String>{
        'To' => 'whatsapp:' + message.toPhoneNumber,
        'Body' => message.messageToSend
      };
      Map<String, String> payload = TwilioUtil.getTwilioPayload(
        intialPayload,
        'whatsapp',
        message.mediaUrl
      );
      response.statusCode = TwilioUtil.sendMessage(payload);
      responses.add(response);
    }
    return responses;
  }

  /**
   * @description Input Type for the invocable action
   */
  global class TwilioWhatsAppMessageRequest {
    @InvocableVariable(
      required=true
      label='To WhatsApp Phone Number'
      description='The Destination Phone Number with country code'
    )
    global String toPhoneNumber;
    @InvocableVariable(
      required=true
      label='Your Message'
      description='The message that you would like to send. You can also include emojis 😊'
    )
    global String messageToSend;
    @InvocableVariable(
      label='Media URL'
      description='Optional. Please only add publicly accessible media urls.'
    )
    global String mediaUrl;
  }

  /**
   * @description Output Type for the invocable action
   */
  global class TwilioWhatsAppMessageResponse {
    @InvocableVariable(
      label='Response Status Code'
      description='The response code from Twilio. 201 status code means that the request to twilio was successful.'
    )
    global Integer statusCode;
  }
}
