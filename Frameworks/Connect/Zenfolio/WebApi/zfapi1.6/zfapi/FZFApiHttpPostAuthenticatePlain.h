//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostAuthenticatePlain.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Performs plain-text authentication. HTTPS only. <A href="/Zenfolio/help/api/ref/methods/authenticateplain">More...</A>
*/



@class FLZenfolioAuthenticatePlainHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostAuthenticatePlain
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostAuthenticatePlain : NSObject{ 
@private
	FLZenfolioAuthenticatePlainHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthenticatePlainHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostAuthenticatePlain*) apiHttpPostAuthenticatePlain; 

@end

@interface FLZenfolioApiHttpPostAuthenticatePlain (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAuthenticatePlainHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

