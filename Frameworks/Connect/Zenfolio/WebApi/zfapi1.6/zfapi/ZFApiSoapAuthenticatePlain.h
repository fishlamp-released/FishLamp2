//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapAuthenticatePlain.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Performs plain-text authentication. HTTPS only. <A href="/Zenfolio/help/api/ref/methods/authenticateplain">More...</A>
*/



@class ZFAuthenticatePlain;
@class ZFAuthenticatePlainResponse;

// --------------------------------------------------------------------
// ZFApiSoapAuthenticatePlain
// --------------------------------------------------------------------
@interface ZFApiSoapAuthenticatePlain : NSObject{ 
@private
	ZFAuthenticatePlain* _input;
	ZFAuthenticatePlainResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFAuthenticatePlain* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAuthenticatePlainResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapAuthenticatePlain*) apiSoapAuthenticatePlain; 

@end

@interface ZFApiSoapAuthenticatePlain (ValueProperties) 
@end


@interface ZFApiSoapAuthenticatePlain (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAuthenticatePlain* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAuthenticatePlainResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
