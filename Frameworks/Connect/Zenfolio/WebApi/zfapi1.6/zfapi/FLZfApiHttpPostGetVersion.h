//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostGetVersion.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the API implementation version. <A href="/zf/help/api/ref/methods/getversion">More...</A>
*/



@class FLZfGetVersionHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostGetVersion
// --------------------------------------------------------------------
@interface FLZfApiHttpPostGetVersion : NSObject{ 
@private
	FLZfGetVersionHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetVersionHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostGetVersion*) apiHttpPostGetVersion; 

@end

@interface FLZfApiHttpPostGetVersion (ValueProperties) 
@end


@interface FLZfApiHttpPostGetVersion (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetVersionHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

