//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapMovePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Moves a photograph from one photoset to another. Both photosets should have the same type and belong to the caller. Can be used to move a photo within the same photoset. <A href="/zf/help/api/ref/methods/movephoto">More...</A>
*/



@class FLZfMovePhoto;
@class FLZfMovePhotoResponse;

// --------------------------------------------------------------------
// FLZfApiSoapMovePhoto
// --------------------------------------------------------------------
@interface FLZfApiSoapMovePhoto : NSObject{ 
@private
	FLZfMovePhoto* _input;
	FLZfMovePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfMovePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfMovePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapMovePhoto*) apiSoapMovePhoto; 

@end

@interface FLZfApiSoapMovePhoto (ValueProperties) 
@end


@interface FLZfApiSoapMovePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfMovePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfMovePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

