//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapLoadPhotoSetPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads a range of photos from the specified photoset. <A href="/Zenfolio/help/api/ref/methods/loadphotosetphotos">More...</A>
*/



@class FLZenfolioLoadPhotoSetPhotos;
@class FLZenfolioLoadPhotoSetPhotosResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapLoadPhotoSetPhotos : NSObject{ 
@private
	FLZenfolioLoadPhotoSetPhotos* _input;
	FLZenfolioLoadPhotoSetPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoSetPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoSetPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapLoadPhotoSetPhotos*) apiSoapLoadPhotoSetPhotos; 

@end

@interface FLZenfolioApiSoapLoadPhotoSetPhotos (ValueProperties) 
@end


@interface FLZenfolioApiSoapLoadPhotoSetPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoSetPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoSetPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

