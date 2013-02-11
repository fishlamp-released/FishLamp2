//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetRotatePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Rotates a photo. <a href="/Zenfolio/help/api/ref/methods/rotatephoto">More ...</a>
*/



@class FLZenfolioRotatePhotoHttpGetIn;
@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetRotatePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetRotatePhoto : NSObject{ 
@private
	FLZenfolioRotatePhotoHttpGetIn* _input;
	FLZenfolioPhoto* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioRotatePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetRotatePhoto*) apiHttpGetRotatePhoto; 

@end

@interface FLZenfolioApiHttpGetRotatePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetRotatePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioRotatePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

