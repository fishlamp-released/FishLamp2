//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadMessages.h
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



@class ZFLoadMessages;
@class ZFLoadMessagesResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadMessages
// --------------------------------------------------------------------
@interface ZFApiSoapLoadMessages : NSObject{ 
@private
	ZFLoadMessages* _input;
	ZFLoadMessagesResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadMessages* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadMessagesResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadMessages*) apiSoapLoadMessages; 

@end

@interface ZFApiSoapLoadMessages (ValueProperties) 
@end


@interface ZFApiSoapLoadMessages (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadMessages* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadMessagesResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

