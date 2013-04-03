//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCollectionRemovePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Removes a photo reference from the specified collection. <A href="/Zenfolio/help/api/ref/methods/collectionremovephoto">More...</A>
*/



@class ZFCollectionRemovePhoto;
@class ZFCollectionRemovePhotoResponse;

// --------------------------------------------------------------------
// ZFApiSoapCollectionRemovePhoto
// --------------------------------------------------------------------
@interface ZFApiSoapCollectionRemovePhoto : NSObject{ 
@private
	ZFCollectionRemovePhoto* _input;
	ZFCollectionRemovePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCollectionRemovePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCollectionRemovePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCollectionRemovePhoto*) apiSoapCollectionRemovePhoto; 

@end

@interface ZFApiSoapCollectionRemovePhoto (ValueProperties) 
@end


@interface ZFApiSoapCollectionRemovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCollectionRemovePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCollectionRemovePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

