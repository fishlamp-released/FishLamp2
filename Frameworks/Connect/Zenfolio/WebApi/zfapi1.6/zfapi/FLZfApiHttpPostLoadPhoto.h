//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostLoadPhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the specified photo. <A href="/zf/help/api/ref/methods/loadphoto">More...</A>
*/



@class FLZfLoadPhotoHttpPostIn;
@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfApiHttpPostLoadPhoto
// --------------------------------------------------------------------
@interface FLZfApiHttpPostLoadPhoto : NSObject{ 
@private
	FLZfLoadPhotoHttpPostIn* _input;
	FLZfPhoto* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostLoadPhoto*) apiHttpPostLoadPhoto; 

@end

@interface FLZfApiHttpPostLoadPhoto (ValueProperties) 
@end


@interface FLZfApiHttpPostLoadPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

