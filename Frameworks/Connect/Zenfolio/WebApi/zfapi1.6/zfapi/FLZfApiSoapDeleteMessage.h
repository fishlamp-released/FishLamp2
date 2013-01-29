//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapDeleteMessage.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Marks the specified message as deleted. The mailbox must be owned by the currently authenticated user. <A href="/zf/help/api/ref/methods/deletemessage">More...</A>
*/



@class FLZfDeleteMessage;
@class FLZfDeleteMessageResponse;

// --------------------------------------------------------------------
// FLZfApiSoapDeleteMessage
// --------------------------------------------------------------------
@interface FLZfApiSoapDeleteMessage : NSObject{ 
@private
	FLZfDeleteMessage* _input;
	FLZfDeleteMessageResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeleteMessage* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeleteMessageResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapDeleteMessage*) apiSoapDeleteMessage; 

@end

@interface FLZfApiSoapDeleteMessage (ValueProperties) 
@end


@interface FLZfApiSoapDeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeleteMessage* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeleteMessageResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

