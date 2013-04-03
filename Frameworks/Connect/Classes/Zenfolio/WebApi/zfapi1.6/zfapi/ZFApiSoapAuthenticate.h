//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapAuthenticate.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Finalizes login sequence and generates a authentication token. <A href="/Zenfolio/help/api/ref/methods/authenticate">More...</A>
*/



@class ZFAuthenticate;
@class ZFAuthenticateResponse;

// --------------------------------------------------------------------
// ZFApiSoapAuthenticate
// --------------------------------------------------------------------
@interface ZFApiSoapAuthenticate : NSObject{ 
@private
	ZFAuthenticate* _input;
	ZFAuthenticateResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFAuthenticate* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAuthenticateResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapAuthenticate*) apiSoapAuthenticate; 

@end

@interface ZFApiSoapAuthenticate (ValueProperties) 
@end


@interface ZFApiSoapAuthenticate (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAuthenticate* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAuthenticateResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

