//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetPopularPhotos.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves photos in order of popularity (most viewed at the top). <A href="/Zenfolio/help/api/ref/methods/getpopularphotos">More...</A>
*/



@class ZFGetPopularPhotos;
@class ZFGetPopularPhotosResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetPopularPhotos
// --------------------------------------------------------------------
@interface ZFApiSoapGetPopularPhotos : NSObject{ 
@private
	ZFGetPopularPhotos* _input;
	ZFGetPopularPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetPopularPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetPopularPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetPopularPhotos*) apiSoapGetPopularPhotos; 

@end

@interface ZFApiSoapGetPopularPhotos (ValueProperties) 
@end


@interface ZFApiSoapGetPopularPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetPopularPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetPopularPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

