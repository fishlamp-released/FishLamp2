//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringGetUnlockedRealmsHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFKeyringGetUnlockedRealmsHttpPostIn
// --------------------------------------------------------------------
@interface ZFKeyringGetUnlockedRealmsHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

+ (NSString*) keyringKey;

+ (ZFKeyringGetUnlockedRealmsHttpPostIn*) keyringGetUnlockedRealmsHttpPostIn; 

@end

@interface ZFKeyringGetUnlockedRealmsHttpPostIn (ValueProperties) 
@end

