//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadPhoto.h
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



@class ZFLoadPhoto;
@class ZFLoadPhotoResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadPhoto
// --------------------------------------------------------------------
@interface ZFApiSoapLoadPhoto : NSObject{ 
@private
	ZFLoadPhoto* _input;
	ZFLoadPhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadPhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadPhoto*) apiSoapLoadPhoto; 

@end

@interface ZFApiSoapLoadPhoto (ValueProperties) 
@end


@interface ZFApiSoapLoadPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadPhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

