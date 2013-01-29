//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetDeletePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a photo. <A href="/zf/help/api/ref/methods/deletephoto">More...</A>
*/



@class FLZfDeletePhotoHttpGetIn;
@class FLZfDeletePhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetDeletePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpGetDeletePhoto : NSObject{ 
@private
	FLZfDeletePhotoHttpGetIn* _input;
	FLZfDeletePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeletePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeletePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetDeletePhoto*) apiHttpGetDeletePhoto; 

@end

@interface FLZfApiHttpGetDeletePhoto (ValueProperties) 
@end


@interface FLZfApiHttpGetDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeletePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeletePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

