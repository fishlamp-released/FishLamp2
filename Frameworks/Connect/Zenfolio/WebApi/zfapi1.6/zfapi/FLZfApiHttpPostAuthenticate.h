//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostAuthenticate.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Finalizes login sequence and generates a authentication token. <A href="/zf/help/api/ref/methods/authenticate">More...</A>
*/



@class FLZfAuthenticateHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostAuthenticate
// --------------------------------------------------------------------
@interface FLZfApiHttpPostAuthenticate : NSObject{ 
@private
	FLZfAuthenticateHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfAuthenticateHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostAuthenticate*) apiHttpPostAuthenticate; 

@end

@interface FLZfApiHttpPostAuthenticate (ValueProperties) 
@end


@interface FLZfApiHttpPostAuthenticate (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfAuthenticateHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

