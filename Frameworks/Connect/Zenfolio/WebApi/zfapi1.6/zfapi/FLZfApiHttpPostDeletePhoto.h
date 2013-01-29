//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostDeletePhoto.h
//	Project: FishLamp WebAPI
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



@class FLZfDeletePhotoHttpPostIn;
@class FLZfDeletePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostDeletePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpPostDeletePhoto : NSObject{ 
@private
	FLZfDeletePhotoHttpPostIn* _input;
	FLZfDeletePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeletePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeletePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostDeletePhoto*) apiHttpPostDeletePhoto; 

@end

@interface FLZfApiHttpPostDeletePhoto (ValueProperties) 
@end


@interface FLZfApiHttpPostDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeletePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeletePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

