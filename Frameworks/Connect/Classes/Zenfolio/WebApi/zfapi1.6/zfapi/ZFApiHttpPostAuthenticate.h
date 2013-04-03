//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostAuthenticate.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Finalizes login sequence and generates a authentication token. <A href="/Zenfolio/help/api/ref/methods/authenticate">More...</A>
*/



@class ZFAuthenticateHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostAuthenticate
// --------------------------------------------------------------------
@interface ZFApiHttpPostAuthenticate : NSObject{ 
@private
	ZFAuthenticateHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFAuthenticateHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostAuthenticate*) apiHttpPostAuthenticate; 

@end

@interface ZFApiHttpPostAuthenticate (ValueProperties) 
@end


@interface ZFApiHttpPostAuthenticate (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAuthenticateHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

