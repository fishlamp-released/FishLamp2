//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostReplacePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Replaces a photo with other existing photo. <A href="/zf/help/api/ref/methods/replacephoto">More...</A>
*/



@class FLZfReplacePhotoHttpPostIn;
@class FLZfReplacePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostReplacePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpPostReplacePhoto : NSObject{ 
@private
	FLZfReplacePhotoHttpPostIn* _input;
	FLZfReplacePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfReplacePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfReplacePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostReplacePhoto*) apiHttpPostReplacePhoto; 

@end

@interface FLZfApiHttpPostReplacePhoto (ValueProperties) 
@end


@interface FLZfApiHttpPostReplacePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfReplacePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfReplacePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

