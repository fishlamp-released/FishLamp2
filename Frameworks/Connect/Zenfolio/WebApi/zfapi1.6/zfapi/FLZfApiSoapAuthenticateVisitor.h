//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapAuthenticateVisitor.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Authenticates an anonymous visitor. <A href="/zf/help/api/ref/methods/authenticatevisitor">More...</A>
*/



@class FLZfAuthenticateVisitor;
@class FLZfAuthenticateVisitorResponse;

// --------------------------------------------------------------------
// FLZfApiSoapAuthenticateVisitor
// --------------------------------------------------------------------
@interface FLZfApiSoapAuthenticateVisitor : NSObject{ 
@private
	FLZfAuthenticateVisitor* _input;
	FLZfAuthenticateVisitorResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfAuthenticateVisitor* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfAuthenticateVisitorResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapAuthenticateVisitor*) apiSoapAuthenticateVisitor; 

@end

@interface FLZfApiSoapAuthenticateVisitor (ValueProperties) 
@end


@interface FLZfApiSoapAuthenticateVisitor (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfAuthenticateVisitor* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfAuthenticateVisitorResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

