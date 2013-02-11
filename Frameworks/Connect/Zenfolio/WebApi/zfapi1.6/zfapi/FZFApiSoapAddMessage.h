//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapAddMessage.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Posts a message to a mailbox. The mailbox must be owned by the currently authenticated user. <A href="/Zenfolio/help/api/ref/methods/addmessage">More...</A>
*/



@class FLZenfolioAddMessage;
@class FLZenfolioAddMessageResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapAddMessage
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapAddMessage : NSObject{ 
@private
	FLZenfolioAddMessage* _input;
	FLZenfolioAddMessageResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAddMessage* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioAddMessageResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapAddMessage*) apiSoapAddMessage; 

@end

@interface FLZenfolioApiSoapAddMessage (ValueProperties) 
@end


@interface FLZenfolioApiSoapAddMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAddMessage* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioAddMessageResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

