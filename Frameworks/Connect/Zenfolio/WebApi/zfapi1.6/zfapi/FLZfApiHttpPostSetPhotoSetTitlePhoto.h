//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostSetPhotoSetTitlePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a photoset (gallery or collection). <A href="/zf/help/api/ref/methods/setphotosettitlephoto">More...</A>
*/



@class FLZfSetPhotoSetTitlePhotoHttpPostIn;
@class FLZfSetPhotoSetTitlePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpPostSetPhotoSetTitlePhoto : NSObject{ 
@private
	FLZfSetPhotoSetTitlePhotoHttpPostIn* _input;
	FLZfSetPhotoSetTitlePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSetPhotoSetTitlePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfSetPhotoSetTitlePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostSetPhotoSetTitlePhoto*) apiHttpPostSetPhotoSetTitlePhoto; 

@end

@interface FLZfApiHttpPostSetPhotoSetTitlePhoto (ValueProperties) 
@end


@interface FLZfApiHttpPostSetPhotoSetTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSetPhotoSetTitlePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfSetPhotoSetTitlePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

