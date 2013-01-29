//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostSetGroupTitlePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a group. <A href="/zf/help/api/ref/methods/setgrouptitlephoto">More...</A>
*/



@class FLZfSetGroupTitlePhotoHttpPostIn;
@class FLZfSetGroupTitlePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpPostSetGroupTitlePhoto : NSObject{ 
@private
	FLZfSetGroupTitlePhotoHttpPostIn* _input;
	FLZfSetGroupTitlePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSetGroupTitlePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfSetGroupTitlePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostSetGroupTitlePhoto*) apiHttpPostSetGroupTitlePhoto; 

@end

@interface FLZfApiHttpPostSetGroupTitlePhoto (ValueProperties) 
@end


@interface FLZfApiHttpPostSetGroupTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSetGroupTitlePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfSetGroupTitlePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

