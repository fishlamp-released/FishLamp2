//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetVersion.h
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



@class ZFGetVersionHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostGetVersion
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetVersion : NSObject{ 
@private
	ZFGetVersionHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVersionHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetVersion*) apiHttpPostGetVersion; 

@end

@interface ZFApiHttpPostGetVersion (ValueProperties) 
@end


@interface ZFApiHttpPostGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVersionHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

