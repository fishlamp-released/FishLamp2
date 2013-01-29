//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetCollectionRemovePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Removes a photo reference from the specified collection. <A href="/zf/help/api/ref/methods/collectionremovephoto">More...</A>
*/



@class FLZfCollectionRemovePhotoHttpGetIn;
@class FLZfCollectionRemovePhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetCollectionRemovePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpGetCollectionRemovePhoto : NSObject{ 
@private
	FLZfCollectionRemovePhotoHttpGetIn* _input;
	FLZfCollectionRemovePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCollectionRemovePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCollectionRemovePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetCollectionRemovePhoto*) apiHttpGetCollectionRemovePhoto; 

@end

@interface FLZfApiHttpGetCollectionRemovePhoto (ValueProperties) 
@end


@interface FLZfApiHttpGetCollectionRemovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCollectionRemovePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCollectionRemovePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

