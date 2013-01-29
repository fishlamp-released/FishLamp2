//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostCreateVideoFromUrl.h
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



@class FLZfCreateVideoFromUrlHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostCreateVideoFromUrl
// --------------------------------------------------------------------
@interface FLZfApiHttpPostCreateVideoFromUrl : NSObject{ 
@private
	FLZfCreateVideoFromUrlHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreateVideoFromUrlHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostCreateVideoFromUrl*) apiHttpPostCreateVideoFromUrl; 

@end

@interface FLZfApiHttpPostCreateVideoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface FLZfApiHttpPostCreateVideoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreateVideoFromUrlHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

