//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapAddMessage.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Posts a message to a mailbox. The mailbox must be owned by the currently authenticated user. <A href="/zf/help/api/ref/methods/addmessage">More...</A>
*/



@class ZFAddMessage;
@class ZFAddMessageResponse;

// --------------------------------------------------------------------
// ZFApiSoapAddMessage
// --------------------------------------------------------------------
@interface ZFApiSoapAddMessage : NSObject{ 
@private
	ZFAddMessage* _input;
	ZFAddMessageResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFAddMessage* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAddMessageResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapAddMessage*) apiSoapAddMessage; 

@end

@interface ZFApiSoapAddMessage (ValueProperties) 
@end


@interface ZFApiSoapAddMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAddMessage* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAddMessageResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

