//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostCollectionRemovePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Removes a photo reference from the specified collection. <A href="/Zenfolio/help/api/ref/methods/collectionremovephoto">More...</A>
*/



@class FLZenfolioCollectionRemovePhotoHttpPostIn;
@class FLZenfolioCollectionRemovePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostCollectionRemovePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostCollectionRemovePhoto : NSObject{ 
@private
	FLZenfolioCollectionRemovePhotoHttpPostIn* _input;
	FLZenfolioCollectionRemovePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCollectionRemovePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCollectionRemovePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostCollectionRemovePhoto*) apiHttpPostCollectionRemovePhoto; 

@end

@interface FLZenfolioApiHttpPostCollectionRemovePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostCollectionRemovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCollectionRemovePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCollectionRemovePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
