//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapCreateVideoFromUrl.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a video by downloading the specified URL. <A href="/zf/help/api/ref/methods/createvideofromurl">More...</A>
*/



@class FLZfCreateVideoFromUrl;
@class FLZfCreateVideoFromUrlResponse;

// --------------------------------------------------------------------
// FLZfApiSoapCreateVideoFromUrl
// --------------------------------------------------------------------
@interface FLZfApiSoapCreateVideoFromUrl : NSObject{ 
@private
	FLZfCreateVideoFromUrl* _input;
	FLZfCreateVideoFromUrlResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreateVideoFromUrl* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCreateVideoFromUrlResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapCreateVideoFromUrl*) apiSoapCreateVideoFromUrl; 

@end

@interface FLZfApiSoapCreateVideoFromUrl (ValueProperties) 
@end


@interface FLZfApiSoapCreateVideoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreateVideoFromUrl* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCreateVideoFromUrlResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

