//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetAuthenticatePlain.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Performs plain-text authentication. HTTPS only. <A href="/Zenfolio/help/api/ref/methods/authenticateplain">More...</A>
*/



@class ZFAuthenticatePlainHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetAuthenticatePlain
// --------------------------------------------------------------------
@interface ZFApiHttpGetAuthenticatePlain : NSObject{ 
@private
	ZFAuthenticatePlainHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFAuthenticatePlainHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetAuthenticatePlain*) apiHttpGetAuthenticatePlain; 

@end

@interface ZFApiHttpGetAuthenticatePlain (ValueProperties) 
@end


@interface ZFApiHttpGetAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAuthenticatePlainHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

