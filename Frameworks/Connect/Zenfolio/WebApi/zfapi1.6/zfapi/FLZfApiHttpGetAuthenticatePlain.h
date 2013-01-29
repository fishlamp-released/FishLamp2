//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetAuthenticatePlain.h
//	Project: FishLamp WebAPI
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



@class FLZfAuthenticatePlainHttpGetIn;

// --------------------------------------------------------------------
// FLZfApiHttpGetAuthenticatePlain
// --------------------------------------------------------------------
@interface FLZfApiHttpGetAuthenticatePlain : NSObject{ 
@private
	FLZfAuthenticatePlainHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfAuthenticatePlainHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetAuthenticatePlain*) apiHttpGetAuthenticatePlain; 

@end

@interface FLZfApiHttpGetAuthenticatePlain (ValueProperties) 
@end


@interface FLZfApiHttpGetAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfAuthenticatePlainHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

