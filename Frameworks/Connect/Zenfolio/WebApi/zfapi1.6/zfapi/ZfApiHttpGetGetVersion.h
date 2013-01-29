//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetGetVersion.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the API implementation version. <A href="/zf/help/api/ref/methods/getversion">More...</A>
*/



@class ZFGetVersionHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetGetVersion
// --------------------------------------------------------------------
@interface ZFApiHttpGetGetVersion : NSObject{ 
@private
	ZFGetVersionHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVersionHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetGetVersion*) apiHttpGetGetVersion; 

@end

@interface ZFApiHttpGetGetVersion (ValueProperties) 
@end


@interface ZFApiHttpGetGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVersionHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

