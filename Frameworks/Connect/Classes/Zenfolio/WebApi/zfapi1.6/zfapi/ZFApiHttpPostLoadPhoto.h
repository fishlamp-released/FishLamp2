//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostLoadPhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified photo. <A href="/Zenfolio/help/api/ref/methods/loadphoto">More...</A>
*/



@class ZFLoadPhotoHttpPostIn;
@class ZFPhoto;

// --------------------------------------------------------------------
// ZFApiHttpPostLoadPhoto
// --------------------------------------------------------------------
@interface ZFApiHttpPostLoadPhoto : NSObject{ 
@private
	ZFLoadPhotoHttpPostIn* _input;
	ZFPhoto* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostLoadPhoto*) apiHttpPostLoadPhoto; 

@end

@interface ZFApiHttpPostLoadPhoto (ValueProperties) 
@end


@interface ZFApiHttpPostLoadPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

