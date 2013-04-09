//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostAuthenticateVisitor.h
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



@class ZFAuthenticateVisitorHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostAuthenticateVisitor
// --------------------------------------------------------------------
@interface ZFApiHttpPostAuthenticateVisitor : NSObject{ 
@private
	ZFAuthenticateVisitorHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFAuthenticateVisitorHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostAuthenticateVisitor*) apiHttpPostAuthenticateVisitor; 

@end

@interface ZFApiHttpPostAuthenticateVisitor (ValueProperties) 
@end


@interface ZFApiHttpPostAuthenticateVisitor (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFAuthenticateVisitorHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end
