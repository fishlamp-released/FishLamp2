//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Sets the position of a photoset among featured photosets of the current user. <A href="/Zenfolio/help/api/ref/methods/setphotosetfeaturedindex">More...</A>
*/



@class FLZenfolioSetPhotoSetFeaturedIndexHttpPostIn;
@class FLZenfolioSetPhotoSetFeaturedIndexHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex : NSObject{ 
@private
	FLZenfolioSetPhotoSetFeaturedIndexHttpPostIn* _input;
	FLZenfolioSetPhotoSetFeaturedIndexHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetFeaturedIndexHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSetPhotoSetFeaturedIndexHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex*) apiHttpPostSetPhotoSetFeaturedIndex; 

@end

@interface FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetFeaturedIndexHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSetPhotoSetFeaturedIndexHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

