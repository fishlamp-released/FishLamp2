//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetSetPhotoSetTitlePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a photoset (gallery or collection). <A href="/Zenfolio/help/api/ref/methods/setphotosettitlephoto">More...</A>
*/



@class FLZenfolioSetPhotoSetTitlePhotoHttpGetIn;
@class FLZenfolioSetPhotoSetTitlePhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetSetPhotoSetTitlePhoto : NSObject{ 
@private
	FLZenfolioSetPhotoSetTitlePhotoHttpGetIn* _input;
	FLZenfolioSetPhotoSetTitlePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetSetPhotoSetTitlePhoto*) apiHttpGetSetPhotoSetTitlePhoto; 

@end

@interface FLZenfolioApiHttpGetSetPhotoSetTitlePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetSetPhotoSetTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

