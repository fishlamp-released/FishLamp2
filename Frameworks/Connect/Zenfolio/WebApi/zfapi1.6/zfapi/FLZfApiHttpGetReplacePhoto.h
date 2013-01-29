//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetReplacePhoto.h
//	Project: myZenfolio WebAPI
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



@class FLZfReplacePhotoHttpGetIn;
@class FLZfReplacePhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetReplacePhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpGetReplacePhoto : NSObject{ 
@private
	FLZfReplacePhotoHttpGetIn* _input;
	FLZfReplacePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfReplacePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfReplacePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetReplacePhoto*) apiHttpGetReplacePhoto; 

@end

@interface FLZfApiHttpGetReplacePhoto (ValueProperties) 
@end


@interface FLZfApiHttpGetReplacePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfReplacePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfReplacePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

