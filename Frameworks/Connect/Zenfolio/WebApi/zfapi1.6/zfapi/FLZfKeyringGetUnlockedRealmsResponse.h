//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringGetUnlockedRealmsResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfKeyringGetUnlockedRealmsResponse
// --------------------------------------------------------------------
@interface FLZfKeyringGetUnlockedRealmsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _KeyringGetUnlockedRealmsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* KeyringGetUnlockedRealmsResult;
// Type: NSNumber*, forKey: int

+ (NSString*) KeyringGetUnlockedRealmsResultKey;

+ (FLZfKeyringGetUnlockedRealmsResponse*) keyringGetUnlockedRealmsResponse; 

@end

@interface FLZfKeyringGetUnlockedRealmsResponse (ValueProperties) 
@end

