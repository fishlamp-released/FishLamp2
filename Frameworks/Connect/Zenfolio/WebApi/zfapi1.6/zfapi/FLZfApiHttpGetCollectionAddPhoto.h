//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetCollectionAddPhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Adds a photo reference to the specified collection. <A href="/zf/help/api/ref/methods/collectionaddphoto">More...</A>
*/



@class FLZfCollectionAddPhotoHttpGetIn;
@class FLZfCollectionAddPhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetCollectionAddPhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpGetCollectionAddPhoto : NSObject{ 
@private
	FLZfCollectionAddPhotoHttpGetIn* _input;
	FLZfCollectionAddPhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCollectionAddPhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCollectionAddPhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetCollectionAddPhoto*) apiHttpGetCollectionAddPhoto; 

@end

@interface FLZfApiHttpGetCollectionAddPhoto (ValueProperties) 
@end


@interface FLZfApiHttpGetCollectionAddPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCollectionAddPhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCollectionAddPhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

