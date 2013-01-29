//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadPhotoSetPhotos.h
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



@class FLZfLoadPhotoSetPhotos;
@class FLZfLoadPhotoSetPhotosResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadPhotoSetPhotos : NSObject{ 
@private
	FLZfLoadPhotoSetPhotos* _input;
	FLZfLoadPhotoSetPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPhotoSetPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadPhotoSetPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadPhotoSetPhotos*) apiSoapLoadPhotoSetPhotos; 

@end

@interface FLZfApiSoapLoadPhotoSetPhotos (ValueProperties) 
@end


@interface FLZfApiSoapLoadPhotoSetPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPhotoSetPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadPhotoSetPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

