//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapRotatePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Rotates a photo. <a href="/zf/help/api/ref/methods/rotatephoto">More ...</a>
*/



@class FLZfRotatePhoto;
@class FLZfRotatePhotoResponse;

// --------------------------------------------------------------------
// FLZfApiSoapRotatePhoto
// --------------------------------------------------------------------
@interface FLZfApiSoapRotatePhoto : NSObject{ 
@private
	FLZfRotatePhoto* _input;
	FLZfRotatePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfRotatePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfRotatePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapRotatePhoto*) apiSoapRotatePhoto; 

@end

@interface FLZfApiSoapRotatePhoto (ValueProperties) 
@end


@interface FLZfApiSoapRotatePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfRotatePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfRotatePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

