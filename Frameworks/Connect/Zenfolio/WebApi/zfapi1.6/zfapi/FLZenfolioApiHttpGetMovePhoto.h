//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetMovePhoto.h
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



@class FLZenfolioMovePhotoHttpGetIn;
@class FLZenfolioMovePhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetMovePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetMovePhoto : NSObject{ 
@private
	FLZenfolioMovePhotoHttpGetIn* _input;
	FLZenfolioMovePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetMovePhoto*) apiHttpGetMovePhoto; 

@end

@interface FLZenfolioApiHttpGetMovePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetMovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
