//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadMessages.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads messages from a mailbox. <A href="/zf/help/api/ref/methods/loadmessages">More...</A>
*/



@class FLZfLoadMessages;
@class FLZfLoadMessagesResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadMessages
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadMessages : NSObject{ 
@private
	FLZfLoadMessages* _input;
	FLZfLoadMessagesResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadMessages* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadMessagesResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadMessages*) apiSoapLoadMessages; 

@end

@interface FLZfApiSoapLoadMessages (ValueProperties) 
@end


@interface FLZfApiSoapLoadMessages (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadMessages* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadMessagesResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

