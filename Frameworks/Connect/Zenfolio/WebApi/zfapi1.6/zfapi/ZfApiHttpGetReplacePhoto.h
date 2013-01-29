//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetReplacePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Replaces a photo with other existing photo. <A href="/zf/help/api/ref/methods/replacephoto">More...</A>
*/



@class ZFReplacePhotoHttpGetIn;
@class ZFReplacePhotoHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetReplacePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpGetReplacePhoto : NSObject{ 
@private
	ZFReplacePhotoHttpGetIn* _input;
	ZFReplacePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFReplacePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFReplacePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetReplacePhoto*) apiHttpGetReplacePhoto; 

@end

@interface ZFApiHttpGetReplacePhoto (ValueProperties) 
@end


@interface ZFApiHttpGetReplacePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFReplacePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFReplacePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

