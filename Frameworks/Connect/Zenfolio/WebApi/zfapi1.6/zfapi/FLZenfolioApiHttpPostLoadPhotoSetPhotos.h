//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadPhotoSetPhotos.h
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



@class FLZenfolioLoadPhotoSetPhotosHttpPostIn;
@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadPhotoSetPhotos : NSObject{ 
@private
	FLZenfolioLoadPhotoSetPhotosHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoSetPhotosHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZenfolioPhoto*, forKey: Photo

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadPhotoSetPhotos*) apiHttpPostLoadPhotoSetPhotos; 

@end

@interface FLZenfolioApiHttpPostLoadPhotoSetPhotos (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadPhotoSetPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoSetPhotosHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZenfolioPhoto*, forKey: Photo

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
