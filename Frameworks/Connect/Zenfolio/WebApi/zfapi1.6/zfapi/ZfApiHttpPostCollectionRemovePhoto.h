//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostCollectionRemovePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Removes a photo reference from the specified collection. <A href="/zf/help/api/ref/methods/collectionremovephoto">More...</A>
*/



@class ZFCollectionRemovePhotoHttpPostIn;
@class ZFCollectionRemovePhotoHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostCollectionRemovePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpPostCollectionRemovePhoto : NSObject{ 
@private
	ZFCollectionRemovePhotoHttpPostIn* _input;
	ZFCollectionRemovePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFCollectionRemovePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCollectionRemovePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostCollectionRemovePhoto*) apiHttpPostCollectionRemovePhoto; 

@end

@interface ZFApiHttpPostCollectionRemovePhoto (ValueProperties) 
@end


@interface ZFApiHttpPostCollectionRemovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCollectionRemovePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCollectionRemovePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

