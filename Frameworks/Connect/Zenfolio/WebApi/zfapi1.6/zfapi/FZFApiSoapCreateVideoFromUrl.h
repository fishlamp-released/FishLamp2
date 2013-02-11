//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCreateVideoFromUrl.h
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



@class FLZenfolioCreateVideoFromUrl;
@class FLZenfolioCreateVideoFromUrlResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCreateVideoFromUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCreateVideoFromUrl : NSObject{ 
@private
	FLZenfolioCreateVideoFromUrl* _input;
	FLZenfolioCreateVideoFromUrlResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreateVideoFromUrl* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCreateVideoFromUrlResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCreateVideoFromUrl*) apiSoapCreateVideoFromUrl; 

@end

@interface FLZenfolioApiSoapCreateVideoFromUrl (ValueProperties) 
@end


@interface FLZenfolioApiSoapCreateVideoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreateVideoFromUrl* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCreateVideoFromUrlResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

