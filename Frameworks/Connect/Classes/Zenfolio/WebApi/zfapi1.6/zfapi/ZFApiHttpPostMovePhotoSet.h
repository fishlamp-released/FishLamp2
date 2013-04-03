//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostMovePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Moves a photoset from one group to another. Destination group must belong to the caller. <A href="/Zenfolio/help/api/ref/methods/movephotoset">More...</A>
*/



@class ZFMovePhotoSetHttpPostIn;
@class ZFMovePhotoSetHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostMovePhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpPostMovePhotoSet : NSObject{ 
@private
	ZFMovePhotoSetHttpPostIn* _input;
	ZFMovePhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFMovePhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFMovePhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostMovePhotoSet*) apiHttpPostMovePhotoSet; 

@end

@interface ZFApiHttpPostMovePhotoSet (ValueProperties) 
@end


@interface ZFApiHttpPostMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFMovePhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFMovePhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

