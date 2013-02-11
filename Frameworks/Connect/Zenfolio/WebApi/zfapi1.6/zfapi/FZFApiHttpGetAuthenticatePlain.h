//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetAuthenticatePlain.h
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



@class FLZenfolioAuthenticatePlainHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetAuthenticatePlain
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetAuthenticatePlain : NSObject{ 
@private
	FLZenfolioAuthenticatePlainHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthenticatePlainHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetAuthenticatePlain*) apiHttpGetAuthenticatePlain; 

@end

@interface FLZenfolioApiHttpGetAuthenticatePlain (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAuthenticatePlainHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

