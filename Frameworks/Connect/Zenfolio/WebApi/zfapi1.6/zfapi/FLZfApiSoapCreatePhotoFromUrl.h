//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapCreatePhotoFromUrl.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a photo by downloading the specified URL. <A href="/zf/help/api/ref/methods/createphotofromurl">More...</A>
*/



@class FLZfCreatePhotoFromUrl;
@class FLZfCreatePhotoFromUrlResponse;

// --------------------------------------------------------------------
// FLZfApiSoapCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface FLZfApiSoapCreatePhotoFromUrl : NSObject{ 
@private
	FLZfCreatePhotoFromUrl* _input;
	FLZfCreatePhotoFromUrlResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreatePhotoFromUrl* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCreatePhotoFromUrlResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapCreatePhotoFromUrl*) apiSoapCreatePhotoFromUrl; 

@end

@interface FLZfApiSoapCreatePhotoFromUrl (ValueProperties) 
@end


@interface FLZfApiSoapCreatePhotoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreatePhotoFromUrl* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCreatePhotoFromUrlResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

