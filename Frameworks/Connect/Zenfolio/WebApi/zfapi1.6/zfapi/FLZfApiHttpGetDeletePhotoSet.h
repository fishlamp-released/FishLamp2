//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a photoset. <A href="/zf/help/api/ref/methods/deletephotoset">More...</A>
*/



@class FLZfDeletePhotoSetHttpGetIn;
@class FLZfDeletePhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpGetDeletePhotoSet : NSObject{ 
@private
	FLZfDeletePhotoSetHttpGetIn* _input;
	FLZfDeletePhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeletePhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeletePhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetDeletePhotoSet*) apiHttpGetDeletePhotoSet; 

@end

@interface FLZfApiHttpGetDeletePhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpGetDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeletePhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeletePhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

