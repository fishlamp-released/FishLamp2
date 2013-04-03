//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetSetPhotoSetTitlePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a photoset (gallery or collection). <A href="/Zenfolio/help/api/ref/methods/setphotosettitlephoto">More...</A>
*/



@class ZFSetPhotoSetTitlePhotoHttpGetIn;
@class ZFSetPhotoSetTitlePhotoHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpGetSetPhotoSetTitlePhoto : NSObject{ 
@private
	ZFSetPhotoSetTitlePhotoHttpGetIn* _input;
	ZFSetPhotoSetTitlePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFSetPhotoSetTitlePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSetPhotoSetTitlePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetSetPhotoSetTitlePhoto*) apiHttpGetSetPhotoSetTitlePhoto; 

@end

@interface ZFApiHttpGetSetPhotoSetTitlePhoto (ValueProperties) 
@end


@interface ZFApiHttpGetSetPhotoSetTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSetPhotoSetTitlePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSetPhotoSetTitlePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

