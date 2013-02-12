//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetAuthenticateVisitor.h
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



@class FLZenfolioAuthenticateVisitorHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetAuthenticateVisitor
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetAuthenticateVisitor : NSObject{ 
@private
	FLZenfolioAuthenticateVisitorHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAuthenticateVisitorHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetAuthenticateVisitor*) apiHttpGetAuthenticateVisitor; 

@end

@interface FLZenfolioApiHttpGetAuthenticateVisitor (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetAuthenticateVisitor (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioAuthenticateVisitorHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

