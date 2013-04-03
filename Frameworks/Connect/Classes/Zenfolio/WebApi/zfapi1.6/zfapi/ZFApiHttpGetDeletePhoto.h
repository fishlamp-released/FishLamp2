//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetDeletePhoto.h
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



@class ZFDeletePhotoHttpGetIn;
@class ZFDeletePhotoHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetDeletePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpGetDeletePhoto : NSObject{ 
@private
	ZFDeletePhotoHttpGetIn* _input;
	ZFDeletePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeletePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeletePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetDeletePhoto*) apiHttpGetDeletePhoto; 

@end

@interface ZFApiHttpGetDeletePhoto (ValueProperties) 
@end


@interface ZFApiHttpGetDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeletePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeletePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

