//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCollectionAddPhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Adds a photo reference to the specified collection. <A href="/Zenfolio/help/api/ref/methods/collectionaddphoto">More...</A>
*/



@class FLZenfolioCollectionAddPhoto;
@class FLZenfolioCollectionAddPhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCollectionAddPhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCollectionAddPhoto : NSObject{ 
@private
	FLZenfolioCollectionAddPhoto* _input;
	FLZenfolioCollectionAddPhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCollectionAddPhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCollectionAddPhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCollectionAddPhoto*) apiSoapCollectionAddPhoto; 

@end

@interface FLZenfolioApiSoapCollectionAddPhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapCollectionAddPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCollectionAddPhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCollectionAddPhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

