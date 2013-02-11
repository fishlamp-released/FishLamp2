//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapMovePhotoSet.h
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



@class FLZenfolioMovePhotoSet;
@class FLZenfolioMovePhotoSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapMovePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapMovePhotoSet : NSObject{ 
@private
	FLZenfolioMovePhotoSet* _input;
	FLZenfolioMovePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioMovePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapMovePhotoSet*) apiSoapMovePhotoSet; 

@end

@interface FLZenfolioApiSoapMovePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioMovePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

