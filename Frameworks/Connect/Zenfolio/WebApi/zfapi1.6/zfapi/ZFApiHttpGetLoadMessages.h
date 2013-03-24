//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadMessages.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads messages from a mailbox. <A href="/Zenfolio/help/api/ref/methods/loadmessages">More...</A>
*/



@class ZFLoadMessagesHttpGetIn;
@class ZFMessage;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadMessages
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadMessages : NSObject{ 
@private
	ZFLoadMessagesHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadMessagesHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: ZFMessage*, forKey: Message

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadMessages*) apiHttpGetLoadMessages; 

@end

@interface ZFApiHttpGetLoadMessages (ValueProperties) 
@end


@interface ZFApiHttpGetLoadMessages (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadMessagesHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: ZFMessage*, forKey: Message

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

