//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapDeleteMessage.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Marks the specified message as deleted. The mailbox must be owned by the currently authenticated user. <A href="/zf/help/api/ref/methods/deletemessage">More...</A>
*/



@class ZFDeleteMessage;
@class ZFDeleteMessageResponse;

// --------------------------------------------------------------------
// ZFApiSoapDeleteMessage
// --------------------------------------------------------------------
@interface ZFApiSoapDeleteMessage : NSObject{ 
@private
	ZFDeleteMessage* _input;
	ZFDeleteMessageResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeleteMessage* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeleteMessageResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapDeleteMessage*) apiSoapDeleteMessage; 

@end

@interface ZFApiSoapDeleteMessage (ValueProperties) 
@end


@interface ZFApiSoapDeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeleteMessage* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeleteMessageResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

