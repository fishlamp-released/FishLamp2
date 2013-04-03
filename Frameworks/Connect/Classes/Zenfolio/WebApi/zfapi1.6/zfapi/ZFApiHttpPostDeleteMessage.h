//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostDeleteMessage.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Marks the specified message as deleted. The mailbox must be owned by the currently authenticated user. <A href="/Zenfolio/help/api/ref/methods/deletemessage">More...</A>
*/



@class ZFDeleteMessageHttpPostIn;
@class ZFDeleteMessageHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostDeleteMessage
// --------------------------------------------------------------------
@interface ZFApiHttpPostDeleteMessage : NSObject{ 
@private
	ZFDeleteMessageHttpPostIn* _input;
	ZFDeleteMessageHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeleteMessageHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeleteMessageHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostDeleteMessage*) apiHttpPostDeleteMessage; 

@end

@interface ZFApiHttpPostDeleteMessage (ValueProperties) 
@end


@interface ZFApiHttpPostDeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeleteMessageHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeleteMessageHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

