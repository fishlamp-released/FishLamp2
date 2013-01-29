//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostGetPopularPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves photos in order of popularity (most viewed at the top). <A href="/zf/help/api/ref/methods/getpopularphotos">More...</A>
*/



@class FLZfGetPopularPhotosHttpPostIn;
@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfApiHttpPostGetPopularPhotos
// --------------------------------------------------------------------
@interface FLZfApiHttpPostGetPopularPhotos : NSObject{ 
@private
	FLZfGetPopularPhotosHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetPopularPhotosHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfPhoto*, forKey: Photo

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostGetPopularPhotos*) apiHttpPostGetPopularPhotos; 

@end

@interface FLZfApiHttpPostGetPopularPhotos (ValueProperties) 
@end


@interface FLZfApiHttpPostGetPopularPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetPopularPhotosHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfPhoto*, forKey: Photo

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

