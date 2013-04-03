//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdatePhotoSetAccess.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates photoset access descriptor. <A href="/Zenfolio/help/api/ref/methods/updatephotosetaccess">More...</A>
*/



@class ZFUpdatePhotoSetAccess;
@class ZFUpdatePhotoSetAccessResponse;

// --------------------------------------------------------------------
// ZFApiSoapUpdatePhotoSetAccess
// --------------------------------------------------------------------
@interface ZFApiSoapUpdatePhotoSetAccess : NSObject{ 
@private
	ZFUpdatePhotoSetAccess* _input;
	ZFUpdatePhotoSetAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUpdatePhotoSetAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUpdatePhotoSetAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUpdatePhotoSetAccess*) apiSoapUpdatePhotoSetAccess; 

@end

@interface ZFApiSoapUpdatePhotoSetAccess (ValueProperties) 
@end


@interface ZFApiSoapUpdatePhotoSetAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUpdatePhotoSetAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUpdatePhotoSetAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

