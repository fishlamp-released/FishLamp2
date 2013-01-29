//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetMovePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Moves a photoset from one group to another. Destination group must belong to the caller. <A href="/zf/help/api/ref/methods/movephotoset">More...</A>
*/



@class FLZfMovePhotoSetHttpGetIn;
@class FLZfMovePhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetMovePhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpGetMovePhotoSet : NSObject{ 
@private
	FLZfMovePhotoSetHttpGetIn* _input;
	FLZfMovePhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfMovePhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfMovePhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetMovePhotoSet*) apiHttpGetMovePhotoSet; 

@end

@interface FLZfApiHttpGetMovePhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpGetMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfMovePhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfMovePhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

