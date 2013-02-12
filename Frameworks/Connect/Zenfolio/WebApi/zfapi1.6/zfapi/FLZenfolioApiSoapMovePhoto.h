//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapMovePhoto.h
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



@class FLZenfolioMovePhoto;
@class FLZenfolioMovePhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapMovePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapMovePhoto : NSObject{ 
@private
	FLZenfolioMovePhoto* _input;
	FLZenfolioMovePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMovePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapMovePhoto*) apiSoapMovePhoto; 

@end

@interface FLZenfolioApiSoapMovePhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapMovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMovePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

