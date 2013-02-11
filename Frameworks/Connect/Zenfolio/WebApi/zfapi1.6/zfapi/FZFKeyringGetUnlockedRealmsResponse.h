//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioKeyringGetUnlockedRealmsResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioKeyringGetUnlockedRealmsResponse
// --------------------------------------------------------------------
@interface FLZenfolioKeyringGetUnlockedRealmsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _KeyringGetUnlockedRealmsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* KeyringGetUnlockedRealmsResult;
// Type: NSNumber*, forKey: int

+ (NSString*) KeyringGetUnlockedRealmsResultKey;

+ (FLZenfolioKeyringGetUnlockedRealmsResponse*) keyringGetUnlockedRealmsResponse; 

@end

@interface FLZenfolioKeyringGetUnlockedRealmsResponse (ValueProperties) 
@end

