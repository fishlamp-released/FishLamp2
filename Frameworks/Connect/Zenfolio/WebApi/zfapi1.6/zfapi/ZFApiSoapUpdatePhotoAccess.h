//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdatePhotoAccess.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates photo access descriptor. <A href="/Zenfolio/help/api/ref/methods/updatephotoaccess">More...</A>
*/



@class ZFUpdatePhotoAccess;
@class ZFUpdatePhotoAccessResponse;

// --------------------------------------------------------------------
// ZFApiSoapUpdatePhotoAccess
// --------------------------------------------------------------------
@interface ZFApiSoapUpdatePhotoAccess : NSObject{ 
@private
	ZFUpdatePhotoAccess* _input;
	ZFUpdatePhotoAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUpdatePhotoAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUpdatePhotoAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUpdatePhotoAccess*) apiSoapUpdatePhotoAccess; 

@end

@interface ZFApiSoapUpdatePhotoAccess (ValueProperties) 
@end


@interface ZFApiSoapUpdatePhotoAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUpdatePhotoAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUpdatePhotoAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

