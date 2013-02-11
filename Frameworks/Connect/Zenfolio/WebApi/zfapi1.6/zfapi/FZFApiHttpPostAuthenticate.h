//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostAuthenticate.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Finalizes login sequence and generates a authentication token. <A href="/Zenfolio/help/api/ref/methods/authenticate">More...</A>
*/



@class FLZenfolioAuthenticateHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostAuthenticate
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostAuthenticate : NSObject{ 
@private
	FLZenfolioAuthenticateHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthenticateHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostAuthenticate*) apiHttpPostAuthenticate; 

@end

@interface FLZenfolioApiHttpPostAuthenticate (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostAuthenticate (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAuthenticateHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

