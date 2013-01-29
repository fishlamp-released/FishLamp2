//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadPhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the specified photo. <A href="/zf/help/api/ref/methods/loadphoto">More...</A>
*/



@class ZFLoadPhotoHttpGetIn;
@class ZFPhoto;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadPhoto
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadPhoto : NSObject{ 
@private
	ZFLoadPhotoHttpGetIn* _input;
	ZFPhoto* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadPhoto*) apiHttpGetLoadPhoto; 

@end

@interface ZFApiHttpGetLoadPhoto (ValueProperties) 
@end


@interface ZFApiHttpGetLoadPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

