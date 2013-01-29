//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostKeyringGetUnlockedRealms.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns a list of realms unlocked by this keyring. <A href="/zf/help/api/ref/methods/keyringgetunlockedrealms">More...</A>
*/



@class FLZfKeyringGetUnlockedRealmsHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostKeyringGetUnlockedRealms
// --------------------------------------------------------------------
@interface FLZfApiHttpPostKeyringGetUnlockedRealms : NSObject{ 
@private
	FLZfKeyringGetUnlockedRealmsHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfKeyringGetUnlockedRealmsHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: NSNumber*, forKey: int

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostKeyringGetUnlockedRealms*) apiHttpPostKeyringGetUnlockedRealms; 

@end

@interface FLZfApiHttpPostKeyringGetUnlockedRealms (ValueProperties) 
@end


@interface FLZfApiHttpPostKeyringGetUnlockedRealms (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfKeyringGetUnlockedRealmsHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: NSNumber*, forKey: int

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

