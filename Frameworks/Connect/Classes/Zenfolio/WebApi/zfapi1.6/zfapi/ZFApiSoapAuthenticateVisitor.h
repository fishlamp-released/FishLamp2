//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapAuthenticateVisitor.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Authenticates an anonymous visitor. <A href="/Zenfolio/help/api/ref/methods/authenticatevisitor">More...</A>
*/



@class ZFAuthenticateVisitor;
@class ZFAuthenticateVisitorResponse;

// --------------------------------------------------------------------
// ZFApiSoapAuthenticateVisitor
// --------------------------------------------------------------------
@interface ZFApiSoapAuthenticateVisitor : NSObject{ 
@private
	ZFAuthenticateVisitor* _input;
	ZFAuthenticateVisitorResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFAuthenticateVisitor* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAuthenticateVisitorResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapAuthenticateVisitor*) apiSoapAuthenticateVisitor; 

@end

@interface ZFApiSoapAuthenticateVisitor (ValueProperties) 
@end


@interface ZFApiSoapAuthenticateVisitor (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAuthenticateVisitor* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAuthenticateVisitorResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

