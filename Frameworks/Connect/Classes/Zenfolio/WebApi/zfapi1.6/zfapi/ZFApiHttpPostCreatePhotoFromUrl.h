//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostCreatePhotoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a photo by downloading the specified URL. <A href="/Zenfolio/help/api/ref/methods/createphotofromurl">More...</A>
*/



@class ZFCreatePhotoFromUrlHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface ZFApiHttpPostCreatePhotoFromUrl : NSObject{ 
@private
	ZFCreatePhotoFromUrlHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreatePhotoFromUrlHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostCreatePhotoFromUrl*) apiHttpPostCreatePhotoFromUrl; 

@end

@interface ZFApiHttpPostCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface ZFApiHttpPostCreatePhotoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreatePhotoFromUrlHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

