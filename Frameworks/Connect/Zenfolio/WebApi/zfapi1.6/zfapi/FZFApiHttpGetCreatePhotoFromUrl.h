//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetCreatePhotoFromUrl.h
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



@class FLZenfolioCreatePhotoFromUrlHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetCreatePhotoFromUrl : NSObject{ 
@private
	FLZenfolioCreatePhotoFromUrlHttpGetIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreatePhotoFromUrlHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetCreatePhotoFromUrl*) apiHttpGetCreatePhotoFromUrl; 

@end

@interface FLZenfolioApiHttpGetCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface FLZenfolioApiHttpGetCreatePhotoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreatePhotoFromUrlHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

