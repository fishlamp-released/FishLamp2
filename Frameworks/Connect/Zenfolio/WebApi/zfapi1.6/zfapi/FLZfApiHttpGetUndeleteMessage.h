//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetUndeleteMessage.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Marks the specified message as not deleted. The mailbox must be owned by the currently authenticated user. <A href="/zf/help/api/ref/methods/undeletemessage">More...</A>
*/



@class FLZfUndeleteMessageHttpGetIn;
@class FLZfUndeleteMessageHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetUndeleteMessage
// --------------------------------------------------------------------
@interface FLZfApiHttpGetUndeleteMessage : NSObject{ 
@private
	FLZfUndeleteMessageHttpGetIn* _input;
	FLZfUndeleteMessageHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfUndeleteMessageHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUndeleteMessageHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetUndeleteMessage*) apiHttpGetUndeleteMessage; 

@end

@interface FLZfApiHttpGetUndeleteMessage (ValueProperties) 
@end


@interface FLZfApiHttpGetUndeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfUndeleteMessageHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUndeleteMessageHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

