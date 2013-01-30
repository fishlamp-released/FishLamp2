//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostReplacePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Replaces a photo with other existing photo. <A href="/Zenfolio/help/api/ref/methods/replacephoto">More...</A>
*/



@class FLZenfolioReplacePhotoHttpPostIn;
@class FLZenfolioReplacePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostReplacePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostReplacePhoto : NSObject{ 
@private
	FLZenfolioReplacePhotoHttpPostIn* _input;
	FLZenfolioReplacePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioReplacePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioReplacePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostReplacePhoto*) apiHttpPostReplacePhoto; 

@end

@interface FLZenfolioApiHttpPostReplacePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostReplacePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioReplacePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioReplacePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

