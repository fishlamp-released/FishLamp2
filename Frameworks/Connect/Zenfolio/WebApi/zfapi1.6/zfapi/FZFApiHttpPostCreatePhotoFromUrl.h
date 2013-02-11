//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostCreatePhotoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a photo by downloading the specified URL. <A href="/Zenfolio/help/api/ref/methods/createphotofromurl">More...</A>
*/



@class FLZenfolioCreatePhotoFromUrlHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostCreatePhotoFromUrl : NSObject{ 
@private
	FLZenfolioCreatePhotoFromUrlHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreatePhotoFromUrlHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostCreatePhotoFromUrl*) apiHttpPostCreatePhotoFromUrl; 

@end

@interface FLZenfolioApiHttpPostCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface FLZenfolioApiHttpPostCreatePhotoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreatePhotoFromUrlHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

