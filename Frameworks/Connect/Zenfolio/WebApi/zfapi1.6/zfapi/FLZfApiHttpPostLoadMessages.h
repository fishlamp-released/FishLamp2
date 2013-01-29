//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostLoadMessages.h
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



@class FLZfLoadMessagesHttpPostIn;
@class FLZfMessage;

// --------------------------------------------------------------------
// FLZfApiHttpPostLoadMessages
// --------------------------------------------------------------------
@interface FLZfApiHttpPostLoadMessages : NSObject{ 
@private
	FLZfLoadMessagesHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadMessagesHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfMessage*, forKey: Message

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostLoadMessages*) apiHttpPostLoadMessages; 

@end

@interface FLZfApiHttpPostLoadMessages (ValueProperties) 
@end


@interface FLZfApiHttpPostLoadMessages (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadMessagesHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfMessage*, forKey: Message

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

