//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostSetPhotoSetFeaturedIndex.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Sets the position of a photoset among featured photosets of the current user. <A href="/zf/help/api/ref/methods/setphotosetfeaturedindex">More...</A>
*/



@class ZFSetPhotoSetFeaturedIndexHttpPostIn;
@class ZFSetPhotoSetFeaturedIndexHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostSetPhotoSetFeaturedIndex
// --------------------------------------------------------------------
@interface ZFApiHttpPostSetPhotoSetFeaturedIndex : NSObject{ 
@private
	ZFSetPhotoSetFeaturedIndexHttpPostIn* _input;
	ZFSetPhotoSetFeaturedIndexHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostSetPhotoSetFeaturedIndex*) apiHttpPostSetPhotoSetFeaturedIndex; 

@end

@interface ZFApiHttpPostSetPhotoSetFeaturedIndex (ValueProperties) 
@end


@interface ZFApiHttpPostSetPhotoSetFeaturedIndex (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

