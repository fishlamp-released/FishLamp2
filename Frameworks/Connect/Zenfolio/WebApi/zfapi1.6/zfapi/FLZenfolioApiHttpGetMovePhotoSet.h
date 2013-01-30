//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetMovePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Moves a photoset from one group to another. Destination group must belong to the caller. <A href="/Zenfolio/help/api/ref/methods/movephotoset">More...</A>
*/



@class FLZenfolioMovePhotoSetHttpGetIn;
@class FLZenfolioMovePhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetMovePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetMovePhotoSet : NSObject{ 
@private
	FLZenfolioMovePhotoSetHttpGetIn* _input;
	FLZenfolioMovePhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetMovePhotoSet*) apiHttpGetMovePhotoSet; 

@end

@interface FLZenfolioApiHttpGetMovePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

