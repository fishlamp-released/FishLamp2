//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringGetUnlockedRealmsResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFKeyringGetUnlockedRealmsResponse
// --------------------------------------------------------------------
@interface ZFKeyringGetUnlockedRealmsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _KeyringGetUnlockedRealmsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* KeyringGetUnlockedRealmsResult;
// Type: NSNumber*, forKey: int

+ (NSString*) KeyringGetUnlockedRealmsResultKey;

+ (ZFKeyringGetUnlockedRealmsResponse*) keyringGetUnlockedRealmsResponse; 

@end

@interface ZFKeyringGetUnlockedRealmsResponse (ValueProperties) 
@end

