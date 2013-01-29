//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetLoadMessages.h
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



@class FLZfLoadMessagesHttpGetIn;
@class FLZfMessage;

// --------------------------------------------------------------------
// FLZfApiHttpGetLoadMessages
// --------------------------------------------------------------------
@interface FLZfApiHttpGetLoadMessages : NSObject{ 
@private
	FLZfLoadMessagesHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadMessagesHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfMessage*, forKey: Message

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetLoadMessages*) apiHttpGetLoadMessages; 

@end

@interface FLZfApiHttpGetLoadMessages (ValueProperties) 
@end


@interface FLZfApiHttpGetLoadMessages (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadMessagesHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfMessage*, forKey: Message

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

