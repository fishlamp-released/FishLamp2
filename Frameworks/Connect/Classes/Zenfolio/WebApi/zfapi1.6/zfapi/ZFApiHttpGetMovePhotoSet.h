//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetMovePhotoSet.h
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



@class ZFMovePhotoSetHttpGetIn;
@class ZFMovePhotoSetHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetMovePhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpGetMovePhotoSet : NSObject{ 
@private
	ZFMovePhotoSetHttpGetIn* _input;
	ZFMovePhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFMovePhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFMovePhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetMovePhotoSet*) apiHttpGetMovePhotoSet; 

@end

@interface ZFApiHttpGetMovePhotoSet (ValueProperties) 
@end


@interface ZFApiHttpGetMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFMovePhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFMovePhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

