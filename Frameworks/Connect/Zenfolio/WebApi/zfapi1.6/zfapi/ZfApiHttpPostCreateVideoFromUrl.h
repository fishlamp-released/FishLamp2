//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostCreateVideoFromUrl.h
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



@class ZFCreateVideoFromUrlHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostCreateVideoFromUrl
// --------------------------------------------------------------------
@interface ZFApiHttpPostCreateVideoFromUrl : NSObject{ 
@private
	ZFCreateVideoFromUrlHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreateVideoFromUrlHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostCreateVideoFromUrl*) apiHttpPostCreateVideoFromUrl; 

@end

@interface ZFApiHttpPostCreateVideoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface ZFApiHttpPostCreateVideoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreateVideoFromUrlHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

