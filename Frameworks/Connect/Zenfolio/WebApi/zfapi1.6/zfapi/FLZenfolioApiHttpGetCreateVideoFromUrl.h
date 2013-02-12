//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetCreateVideoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a video by downloading the specified URL. <A href="/Zenfolio/help/api/ref/methods/createvideofromurl">More...</A>
*/



@class FLZenfolioCreateVideoFromUrlHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetCreateVideoFromUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetCreateVideoFromUrl : NSObject{ 
@private
	FLZenfolioCreateVideoFromUrlHttpGetIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreateVideoFromUrlHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetCreateVideoFromUrl*) apiHttpGetCreateVideoFromUrl; 

@end

@interface FLZenfolioApiHttpGetCreateVideoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface FLZenfolioApiHttpGetCreateVideoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreateVideoFromUrlHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

