//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetLoadPhotoSetPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads a range of photos from the specified photoset. <A href="/zf/help/api/ref/methods/loadphotosetphotos">More...</A>
*/



@class FLZfLoadPhotoSetPhotosHttpGetIn;
@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfApiHttpGetLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface FLZfApiHttpGetLoadPhotoSetPhotos : NSObject{ 
@private
	FLZfLoadPhotoSetPhotosHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPhotoSetPhotosHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfPhoto*, forKey: Photo

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetLoadPhotoSetPhotos*) apiHttpGetLoadPhotoSetPhotos; 

@end

@interface FLZfApiHttpGetLoadPhotoSetPhotos (ValueProperties) 
@end


@interface FLZfApiHttpGetLoadPhotoSetPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPhotoSetPhotosHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfPhoto*, forKey: Photo

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

