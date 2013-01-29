//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetCheckPrivilege.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Checks if the the specified user is granted a privilege. <A href="/zf/help/api/ref/methods/checkprivilege">More...</A>
*/



@class FLZfCheckPrivilegeHttpGetIn;

// --------------------------------------------------------------------
// FLZfApiHttpGetCheckPrivilege
// --------------------------------------------------------------------
@interface FLZfApiHttpGetCheckPrivilege : NSObject{ 
@private
	FLZfCheckPrivilegeHttpGetIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCheckPrivilegeHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetCheckPrivilege*) apiHttpGetCheckPrivilege; 

@end

@interface FLZfApiHttpGetCheckPrivilege (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL outputValue;
@end


@interface FLZfApiHttpGetCheckPrivilege (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCheckPrivilegeHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

