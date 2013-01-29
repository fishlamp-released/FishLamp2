//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostCheckPrivilege.h
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



@class FLZfCheckPrivilegeHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostCheckPrivilege
// --------------------------------------------------------------------
@interface FLZfApiHttpPostCheckPrivilege : NSObject{ 
@private
	FLZfCheckPrivilegeHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCheckPrivilegeHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostCheckPrivilege*) apiHttpPostCheckPrivilege; 

@end

@interface FLZfApiHttpPostCheckPrivilege (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL outputValue;
@end


@interface FLZfApiHttpPostCheckPrivilege (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCheckPrivilegeHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

