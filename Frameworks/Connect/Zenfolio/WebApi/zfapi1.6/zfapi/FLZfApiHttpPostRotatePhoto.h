//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostRotatePhoto.h
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



@class FLZfRotatePhotoHttpPostIn;
@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfApiHttpPostRotatePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpPostRotatePhoto : NSObject{ 
@private
	FLZfRotatePhotoHttpPostIn* _input;
	FLZfPhoto* _output;
} 


@property (readwrite, retain, nonatomic) FLZfRotatePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostRotatePhoto*) apiHttpPostRotatePhoto; 

@end

@interface FLZfApiHttpPostRotatePhoto (ValueProperties) 
@end


@interface FLZfApiHttpPostRotatePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfRotatePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

