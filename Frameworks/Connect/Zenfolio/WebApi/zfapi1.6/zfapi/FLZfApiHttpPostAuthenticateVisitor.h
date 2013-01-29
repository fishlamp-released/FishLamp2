//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostAuthenticateVisitor.h
//	Project: myZenfolio WebAPI
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



@class FLZfAuthenticateVisitorHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostAuthenticateVisitor
// --------------------------------------------------------------------
@interface FLZfApiHttpPostAuthenticateVisitor : NSObject{ 
@private
	FLZfAuthenticateVisitorHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfAuthenticateVisitorHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostAuthenticateVisitor*) apiHttpPostAuthenticateVisitor; 

@end

@interface FLZfApiHttpPostAuthenticateVisitor (ValueProperties) 
@end


@interface FLZfApiHttpPostAuthenticateVisitor (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfAuthenticateVisitorHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

