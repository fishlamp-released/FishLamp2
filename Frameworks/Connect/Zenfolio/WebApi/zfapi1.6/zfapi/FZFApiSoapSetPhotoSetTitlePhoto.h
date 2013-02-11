//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapSetPhotoSetTitlePhoto.h
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



@class FLZenfolioSetPhotoSetTitlePhoto;
@class FLZenfolioSetPhotoSetTitlePhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapSetPhotoSetTitlePhoto : NSObject{ 
@private
	FLZenfolioSetPhotoSetTitlePhoto* _input;
	FLZenfolioSetPhotoSetTitlePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapSetPhotoSetTitlePhoto*) apiSoapSetPhotoSetTitlePhoto; 

@end

@interface FLZenfolioApiSoapSetPhotoSetTitlePhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapSetPhotoSetTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetTitlePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

