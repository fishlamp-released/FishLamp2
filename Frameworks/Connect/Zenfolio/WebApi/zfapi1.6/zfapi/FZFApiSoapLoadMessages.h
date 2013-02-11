//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapLoadMessages.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads messages from a mailbox. <A href="/Zenfolio/help/api/ref/methods/loadmessages">More...</A>
*/



@class FLZenfolioLoadMessages;
@class FLZenfolioLoadMessagesResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapLoadMessages
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapLoadMessages : NSObject{ 
@private
	FLZenfolioLoadMessages* _input;
	FLZenfolioLoadMessagesResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadMessages* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioLoadMessagesResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapLoadMessages*) apiSoapLoadMessages; 

@end

@interface FLZenfolioApiSoapLoadMessages (ValueProperties) 
@end


@interface FLZenfolioApiSoapLoadMessages (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadMessages* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioLoadMessagesResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

