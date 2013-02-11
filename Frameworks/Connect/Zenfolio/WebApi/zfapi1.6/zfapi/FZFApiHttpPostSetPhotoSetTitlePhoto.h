//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostSetPhotoSetTitlePhoto.h
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



@class FLZenfolioSetPhotoSetTitlePhotoHttpPostIn;
@class FLZenfolioSetPhotoSetTitlePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostSetPhotoSetTitlePhoto : NSObject{ 
@private
	FLZenfolioSetPhotoSetTitlePhotoHttpPostIn* _input;
	FLZenfolioSetPhotoSetTitlePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostSetPhotoSetTitlePhoto*) apiHttpPostSetPhotoSetTitlePhoto; 

@end

@interface FLZenfolioApiHttpPostSetPhotoSetTitlePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostSetPhotoSetTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

