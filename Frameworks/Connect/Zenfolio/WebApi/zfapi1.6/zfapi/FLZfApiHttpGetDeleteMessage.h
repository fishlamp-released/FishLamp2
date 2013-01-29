//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetDeleteMessage.h
//	Project: myZenfolio WebAPI
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



@class FLZfDeleteMessageHttpGetIn;
@class FLZfDeleteMessageHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetDeleteMessage
// --------------------------------------------------------------------
@interface FLZfApiHttpGetDeleteMessage : NSObject{ 
@private
	FLZfDeleteMessageHttpGetIn* _input;
	FLZfDeleteMessageHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeleteMessageHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeleteMessageHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetDeleteMessage*) apiHttpGetDeleteMessage; 

@end

@interface FLZfApiHttpGetDeleteMessage (ValueProperties) 
@end


@interface FLZfApiHttpGetDeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeleteMessageHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeleteMessageHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

