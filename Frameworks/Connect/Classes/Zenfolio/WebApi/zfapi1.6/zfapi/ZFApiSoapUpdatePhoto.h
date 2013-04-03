//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdatePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates a photo. <A href="/Zenfolio/help/api/ref/methods/updatephoto">More...</A>
*/



@class ZFUpdatePhoto;
@class ZFUpdatePhotoResponse;

// --------------------------------------------------------------------
// ZFApiSoapUpdatePhoto
// --------------------------------------------------------------------
@interface ZFApiSoapUpdatePhoto : NSObject{ 
@private
	ZFUpdatePhoto* _input;
	ZFUpdatePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUpdatePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUpdatePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUpdatePhoto*) apiSoapUpdatePhoto; 

@end

@interface ZFApiSoapUpdatePhoto (ValueProperties) 
@end


@interface ZFApiSoapUpdatePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUpdatePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUpdatePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

