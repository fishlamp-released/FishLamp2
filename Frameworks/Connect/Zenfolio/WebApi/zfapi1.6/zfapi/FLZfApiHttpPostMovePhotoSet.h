//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostMovePhotoSet.h
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



@class FLZfMovePhotoSetHttpPostIn;
@class FLZfMovePhotoSetHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostMovePhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpPostMovePhotoSet : NSObject{ 
@private
	FLZfMovePhotoSetHttpPostIn* _input;
	FLZfMovePhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfMovePhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfMovePhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostMovePhotoSet*) apiHttpPostMovePhotoSet; 

@end

@interface FLZfApiHttpPostMovePhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpPostMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfMovePhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfMovePhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

