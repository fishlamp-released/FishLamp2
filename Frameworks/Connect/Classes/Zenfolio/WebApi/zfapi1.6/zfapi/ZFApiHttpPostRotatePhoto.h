//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostRotatePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Rotates a photo. <a href="/Zenfolio/help/api/ref/methods/rotatephoto">More ...</a>
*/



@class ZFRotatePhotoHttpPostIn;
@class ZFPhoto;

// --------------------------------------------------------------------
// ZFApiHttpPostRotatePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpPostRotatePhoto : NSObject{ 
@private
	ZFRotatePhotoHttpPostIn* _input;
	ZFPhoto* _output;
} 


@property (readwrite, retain, nonatomic) ZFRotatePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostRotatePhoto*) apiHttpPostRotatePhoto; 

@end

@interface ZFApiHttpPostRotatePhoto (ValueProperties) 
@end


@interface ZFApiHttpPostRotatePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFRotatePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

