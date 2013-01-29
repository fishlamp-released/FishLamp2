//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostAuthenticatePlain.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Performs plain-text authentication. HTTPS only. <A href="/zf/help/api/ref/methods/authenticateplain">More...</A>
*/



@class FLZfAuthenticatePlainHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostAuthenticatePlain
// --------------------------------------------------------------------
@interface FLZfApiHttpPostAuthenticatePlain : NSObject{ 
@private
	FLZfAuthenticatePlainHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfAuthenticatePlainHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostAuthenticatePlain*) apiHttpPostAuthenticatePlain; 

@end

@interface FLZfApiHttpPostAuthenticatePlain (ValueProperties) 
@end


@interface FLZfApiHttpPostAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfAuthenticatePlainHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

