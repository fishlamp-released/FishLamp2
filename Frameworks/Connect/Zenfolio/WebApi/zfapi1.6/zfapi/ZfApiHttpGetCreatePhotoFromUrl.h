//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetCreatePhotoFromUrl.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a photo by downloading the specified URL. <A href="/zf/help/api/ref/methods/createphotofromurl">More...</A>
*/



@class ZFCreatePhotoFromUrlHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface ZFApiHttpGetCreatePhotoFromUrl : NSObject{ 
@private
	ZFCreatePhotoFromUrlHttpGetIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreatePhotoFromUrlHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetCreatePhotoFromUrl*) apiHttpGetCreatePhotoFromUrl; 

@end

@interface ZFApiHttpGetCreatePhotoFromUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface ZFApiHttpGetCreatePhotoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreatePhotoFromUrlHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

