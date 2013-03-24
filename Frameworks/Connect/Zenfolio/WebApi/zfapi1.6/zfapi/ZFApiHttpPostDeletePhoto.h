//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostDeletePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a photo. <A href="/Zenfolio/help/api/ref/methods/deletephoto">More...</A>
*/



@class ZFDeletePhotoHttpPostIn;
@class ZFDeletePhotoHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostDeletePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpPostDeletePhoto : NSObject{ 
@private
	ZFDeletePhotoHttpPostIn* _input;
	ZFDeletePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeletePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeletePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostDeletePhoto*) apiHttpPostDeletePhoto; 

@end

@interface ZFApiHttpPostDeletePhoto (ValueProperties) 
@end


@interface ZFApiHttpPostDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeletePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeletePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

