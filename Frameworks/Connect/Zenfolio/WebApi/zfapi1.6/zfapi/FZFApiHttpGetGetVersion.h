//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetVersion.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the API implementation version. <A href="/Zenfolio/help/api/ref/methods/getversion">More...</A>
*/



@class FLZenfolioGetVersionHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetVersion
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetVersion : NSObject{ 
@private
	FLZenfolioGetVersionHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVersionHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetVersion*) apiHttpGetGetVersion; 

@end

@interface FLZenfolioApiHttpGetGetVersion (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVersionHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

