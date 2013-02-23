//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetPopularPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves photos in order of popularity (most viewed at the top). <A href="/Zenfolio/help/api/ref/methods/getpopularphotos">More...</A>
*/



@class FLZenfolioGetPopularPhotosHttpGetIn;
@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetPopularPhotos
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetPopularPhotos : NSObject{ 
@private
	FLZenfolioGetPopularPhotosHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetPopularPhotosHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZenfolioPhoto*, forKey: Photo

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetPopularPhotos*) apiHttpGetGetPopularPhotos; 

@end

@interface FLZenfolioApiHttpGetGetPopularPhotos (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetPopularPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetPopularPhotosHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZenfolioPhoto*, forKey: Photo

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
