//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapMovePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Moves a photoset from one group to another. Destination group must belong to the caller. <A href="/zf/help/api/ref/methods/movephotoset">More...</A>
*/



@class ZFMovePhotoSet;
@class ZFMovePhotoSetResponse;

// --------------------------------------------------------------------
// ZFApiSoapMovePhotoSet
// --------------------------------------------------------------------
@interface ZFApiSoapMovePhotoSet : NSObject{ 
@private
	ZFMovePhotoSet* _input;
	ZFMovePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFMovePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFMovePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapMovePhotoSet*) apiSoapMovePhotoSet; 

@end

@interface ZFApiSoapMovePhotoSet (ValueProperties) 
@end


@interface ZFApiSoapMovePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFMovePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFMovePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

