//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostUndeleteMessage.h
//	Project: myZenfolio WebAPI
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



@class FLZfUndeleteMessageHttpPostIn;
@class FLZfUndeleteMessageHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostUndeleteMessage
// --------------------------------------------------------------------
@interface FLZfApiHttpPostUndeleteMessage : NSObject{ 
@private
	FLZfUndeleteMessageHttpPostIn* _input;
	FLZfUndeleteMessageHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfUndeleteMessageHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUndeleteMessageHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostUndeleteMessage*) apiHttpPostUndeleteMessage; 

@end

@interface FLZfApiHttpPostUndeleteMessage (ValueProperties) 
@end


@interface FLZfApiHttpPostUndeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfUndeleteMessageHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUndeleteMessageHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

