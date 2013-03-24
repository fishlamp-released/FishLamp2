//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapSetPhotoSetFeaturedIndex.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Sets the position of a photoset among featured photosets of the current user. <A href="/Zenfolio/help/api/ref/methods/setphotosetfeaturedindex">More...</A>
*/



@class ZFSetPhotoSetFeaturedIndex;
@class ZFSetPhotoSetFeaturedIndexResponse;

// --------------------------------------------------------------------
// ZFApiSoapSetPhotoSetFeaturedIndex
// --------------------------------------------------------------------
@interface ZFApiSoapSetPhotoSetFeaturedIndex : NSObject{ 
@private
	ZFSetPhotoSetFeaturedIndex* _input;
	ZFSetPhotoSetFeaturedIndexResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFSetPhotoSetFeaturedIndex* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSetPhotoSetFeaturedIndexResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapSetPhotoSetFeaturedIndex*) apiSoapSetPhotoSetFeaturedIndex; 

@end

@interface ZFApiSoapSetPhotoSetFeaturedIndex (ValueProperties) 
@end


@interface ZFApiSoapSetPhotoSetFeaturedIndex (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSetPhotoSetFeaturedIndex* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSetPhotoSetFeaturedIndexResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

