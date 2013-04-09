//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadPhotoSetPhotos.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads a range of photos from the specified photoset. <A href="/Zenfolio/help/api/ref/methods/loadphotosetphotos">More...</A>
*/



@class ZFLoadPhotoSetPhotos;
@class ZFLoadPhotoSetPhotosResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadPhotoSetPhotos
// --------------------------------------------------------------------
@interface ZFApiSoapLoadPhotoSetPhotos : NSObject{ 
@private
	ZFLoadPhotoSetPhotos* _input;
	ZFLoadPhotoSetPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPhotoSetPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadPhotoSetPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadPhotoSetPhotos*) apiSoapLoadPhotoSetPhotos; 

@end

@interface ZFApiSoapLoadPhotoSetPhotos (ValueProperties) 
@end


@interface ZFApiSoapLoadPhotoSetPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPhotoSetPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadPhotoSetPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
