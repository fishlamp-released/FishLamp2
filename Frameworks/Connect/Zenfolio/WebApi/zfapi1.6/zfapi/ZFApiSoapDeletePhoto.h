//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapDeletePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a photo. <A href="/Zenfolio/help/api/ref/methods/deletephoto">More...</A>
*/



@class ZFDeletePhoto;
@class ZFDeletePhotoResponse;

// --------------------------------------------------------------------
// ZFApiSoapDeletePhoto
// --------------------------------------------------------------------
@interface ZFApiSoapDeletePhoto : NSObject{ 
@private
	ZFDeletePhoto* _input;
	ZFDeletePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeletePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeletePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapDeletePhoto*) apiSoapDeletePhoto; 

@end

@interface ZFApiSoapDeletePhoto (ValueProperties) 
@end


@interface ZFApiSoapDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeletePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeletePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

