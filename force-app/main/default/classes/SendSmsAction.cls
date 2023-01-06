/**
 * @description Send SMS with Twilio Invocable Action
 */
global with sharing class SendSmsAction {
  /**
   * @description Send SMS Invocable Action with twilio
   * @param messages A list of Twilio SMS requests
   **/
  @InvocableMethod(
    callout=true
    label='Send an SMS with Twilio'
    description='Send an SMS with Twilio.'
  )
  global static List<TwilioSmsResponse> sendTextMessages(
    List<TwilioSmsRequest> messages
  ) {
    List<TwilioSmsResponse> responses = new List<TwilioSmsResponse>();
    for (TwilioSmsRequest message : messages) {
      TwilioSmsResponse response = new TwilioSmsResponse();
      Map<String, String> initialPayload = new Map<String, String>{
        'To' => message.toPhoneNumber,
        'Body' => message.messageToSend
      };
      Map<String, String> payload = TwilioUtil.getTwilioPayload(
        initialPayload,
        'text',
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
  global class TwilioSmsRequest {
    @InvocableVariable(
      required=true
      label='To Phone Number'
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
  global class TwilioSmsResponse {
    @InvocableVariable(
      label='Response Status Code'
      description='The response code from Twilio. 201 status code means that the request to twilio was successful.'
    )
    global Integer statusCode;
  }
}
