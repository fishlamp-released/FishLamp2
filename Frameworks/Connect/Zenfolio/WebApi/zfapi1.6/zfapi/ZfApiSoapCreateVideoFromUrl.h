//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCreateVideoFromUrl.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a video by downloading the specified URL. <A href="/zf/help/api/ref/methods/createvideofromurl">More...</A>
*/



@class ZFCreateVideoFromUrl;
@class ZFCreateVideoFromUrlResponse;

// --------------------------------------------------------------------
// ZFApiSoapCreateVideoFromUrl
// --------------------------------------------------------------------
@interface ZFApiSoapCreateVideoFromUrl : NSObject{ 
@private
	ZFCreateVideoFromUrl* _input;
	ZFCreateVideoFromUrlResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreateVideoFromUrl* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCreateVideoFromUrlResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCreateVideoFromUrl*) apiSoapCreateVideoFromUrl; 

@end

@interface ZFApiSoapCreateVideoFromUrl (ValueProperties) 
@end


@interface ZFApiSoapCreateVideoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreateVideoFromUrl* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCreateVideoFromUrlResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

