//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCollectionAddPhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Adds a photo reference to the specified collection. <A href="/zf/help/api/ref/methods/collectionaddphoto">More...</A>
*/



@class ZFCollectionAddPhoto;
@class ZFCollectionAddPhotoResponse;

// --------------------------------------------------------------------
// ZFApiSoapCollectionAddPhoto
// --------------------------------------------------------------------
@interface ZFApiSoapCollectionAddPhoto : NSObject{ 
@private
	ZFCollectionAddPhoto* _input;
	ZFCollectionAddPhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCollectionAddPhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCollectionAddPhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCollectionAddPhoto*) apiSoapCollectionAddPhoto; 

@end

@interface ZFApiSoapCollectionAddPhoto (ValueProperties) 
@end


@interface ZFApiSoapCollectionAddPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCollectionAddPhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCollectionAddPhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

