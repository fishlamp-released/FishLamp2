//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostGetVersion.h
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



@class FLZenfolioGetVersionHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostGetVersion
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostGetVersion : NSObject{ 
@private
	FLZenfolioGetVersionHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVersionHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostGetVersion*) apiHttpPostGetVersion; 

@end

@interface FLZenfolioApiHttpPostGetVersion (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVersionHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

