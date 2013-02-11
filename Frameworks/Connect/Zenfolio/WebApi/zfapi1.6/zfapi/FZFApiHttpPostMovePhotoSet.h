//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostMovePhotoSet.h
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



@class FLZenfolioMovePhotoSetHttpPostIn;
@class FLZenfolioMovePhotoSetHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostMovePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostMovePhotoSet : NSObject{ 
@private
	FLZenfolioMovePhotoSetHttpPostIn* _input;
	FLZenfolioMovePhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostMovePhotoSet*) apiHttpPostMovePhotoSet; 

@end

@interface FLZenfolioApiHttpPostMovePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

