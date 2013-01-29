//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringGetUnlockedRealmsHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfKeyringGetUnlockedRealmsHttpGetIn
// --------------------------------------------------------------------
@interface FLZfKeyringGetUnlockedRealmsHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

+ (NSString*) keyringKey;

+ (FLZfKeyringGetUnlockedRealmsHttpGetIn*) keyringGetUnlockedRealmsHttpGetIn; 

@end

@interface FLZfKeyringGetUnlockedRealmsHttpGetIn (ValueProperties) 
@end

