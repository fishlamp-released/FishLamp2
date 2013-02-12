//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapAuthenticateVisitor.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Authenticates an anonymous visitor. <A href="/Zenfolio/help/api/ref/methods/authenticatevisitor">More...</A>
*/



@class FLZenfolioAuthenticateVisitor;
@class FLZenfolioAuthenticateVisitorResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapAuthenticateVisitor
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapAuthenticateVisitor : NSObject{ 
@private
	FLZenfolioAuthenticateVisitor* _input;
	FLZenfolioAuthenticateVisitorResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthenticateVisitor* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioAuthenticateVisitorResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapAuthenticateVisitor*) apiSoapAuthenticateVisitor; 

@end

@interface FLZenfolioApiSoapAuthenticateVisitor (ValueProperties) 
@end


@interface FLZenfolioApiSoapAuthenticateVisitor (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAuthenticateVisitor* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioAuthenticateVisitorResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

