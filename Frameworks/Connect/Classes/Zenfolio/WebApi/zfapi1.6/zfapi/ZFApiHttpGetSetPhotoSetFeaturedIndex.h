//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetSetPhotoSetFeaturedIndex.h
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



@class ZFSetPhotoSetFeaturedIndexHttpGetIn;
@class ZFSetPhotoSetFeaturedIndexHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetSetPhotoSetFeaturedIndex
// --------------------------------------------------------------------
@interface ZFApiHttpGetSetPhotoSetFeaturedIndex : NSObject{ 
@private
	ZFSetPhotoSetFeaturedIndexHttpGetIn* _input;
	ZFSetPhotoSetFeaturedIndexHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetSetPhotoSetFeaturedIndex*) apiHttpGetSetPhotoSetFeaturedIndex; 

@end

@interface ZFApiHttpGetSetPhotoSetFeaturedIndex (ValueProperties) 
@end


@interface ZFApiHttpGetSetPhotoSetFeaturedIndex (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSetPhotoSetFeaturedIndexHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

