//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostSetPhotoSetFeaturedIndex.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Sets the position of a photoset among featured photosets of the current user. <A href="/zf/help/api/ref/methods/setphotosetfeaturedindex">More...</A>
*/



@class FLZfSetPhotoSetFeaturedIndexHttpPostIn;
@class FLZfSetPhotoSetFeaturedIndexHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostSetPhotoSetFeaturedIndex
// --------------------------------------------------------------------
@interface FLZfApiHttpPostSetPhotoSetFeaturedIndex : NSObject{ 
@private
	FLZfSetPhotoSetFeaturedIndexHttpPostIn* _input;
	FLZfSetPhotoSetFeaturedIndexHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSetPhotoSetFeaturedIndexHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfSetPhotoSetFeaturedIndexHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostSetPhotoSetFeaturedIndex*) apiHttpPostSetPhotoSetFeaturedIndex; 

@end

@interface FLZfApiHttpPostSetPhotoSetFeaturedIndex (ValueProperties) 
@end


@interface FLZfApiHttpPostSetPhotoSetFeaturedIndex (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSetPhotoSetFeaturedIndexHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfSetPhotoSetFeaturedIndexHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

