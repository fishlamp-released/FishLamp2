//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringGetUnlockedRealmsHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFKeyringGetUnlockedRealmsHttpGetIn
// --------------------------------------------------------------------
@interface ZFKeyringGetUnlockedRealmsHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

+ (NSString*) keyringKey;

+ (ZFKeyringGetUnlockedRealmsHttpGetIn*) keyringGetUnlockedRealmsHttpGetIn; 

@end

@interface ZFKeyringGetUnlockedRealmsHttpGetIn (ValueProperties) 
@end

