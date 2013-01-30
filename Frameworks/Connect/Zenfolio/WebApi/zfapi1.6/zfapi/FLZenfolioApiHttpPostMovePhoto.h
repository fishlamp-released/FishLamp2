//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostMovePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Moves a photograph from one photoset to another. Both photosets should have the same type and belong to the caller. Can be used to move a photo within the same photoset. <A href="/Zenfolio/help/api/ref/methods/movephoto">More...</A>
*/



@class FLZenfolioMovePhotoHttpPostIn;
@class FLZenfolioMovePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostMovePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostMovePhoto : NSObject{ 
@private
	FLZenfolioMovePhotoHttpPostIn* _input;
	FLZenfolioMovePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostMovePhoto*) apiHttpPostMovePhoto; 

@end

@interface FLZenfolioApiHttpPostMovePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostMovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

