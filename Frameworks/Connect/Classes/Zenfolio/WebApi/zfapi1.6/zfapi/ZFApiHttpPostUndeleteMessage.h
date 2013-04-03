//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostUndeleteMessage.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Marks the specified message as not deleted. The mailbox must be owned by the currently authenticated user. <A href="/Zenfolio/help/api/ref/methods/undeletemessage">More...</A>
*/



@class ZFUndeleteMessageHttpPostIn;
@class ZFUndeleteMessageHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostUndeleteMessage
// --------------------------------------------------------------------
@interface ZFApiHttpPostUndeleteMessage : NSObject{ 
@private
	ZFUndeleteMessageHttpPostIn* _input;
	ZFUndeleteMessageHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFUndeleteMessageHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUndeleteMessageHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostUndeleteMessage*) apiHttpPostUndeleteMessage; 

@end

@interface ZFApiHttpPostUndeleteMessage (ValueProperties) 
@end


@interface ZFApiHttpPostUndeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUndeleteMessageHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUndeleteMessageHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

