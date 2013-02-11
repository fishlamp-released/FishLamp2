//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioKeyringGetUnlockedRealms.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioKeyringGetUnlockedRealms
// --------------------------------------------------------------------
@interface FLZenfolioKeyringGetUnlockedRealms : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _keyring;
} 


@property (readwrite, retain, nonatomic) NSString* keyring;

+ (NSString*) keyringKey;

+ (FLZenfolioKeyringGetUnlockedRealms*) keyringGetUnlockedRealms; 

@end

@interface FLZenfolioKeyringGetUnlockedRealms (ValueProperties) 
@end

