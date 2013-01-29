//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringGetUnlockedRealms.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfKeyringGetUnlockedRealms
// --------------------------------------------------------------------
@interface FLZfKeyringGetUnlockedRealms : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

+ (NSString*) keyringKey;

+ (FLZfKeyringGetUnlockedRealms*) keyringGetUnlockedRealms; 

@end

@interface FLZfKeyringGetUnlockedRealms (ValueProperties) 
@end

