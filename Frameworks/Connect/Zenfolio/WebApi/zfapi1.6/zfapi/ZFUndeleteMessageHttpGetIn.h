//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUndeleteMessageHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFUndeleteMessageHttpGetIn
// --------------------------------------------------------------------
@interface ZFUndeleteMessageHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSString* _messageIndex;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSString* messageIndex;

+ (NSString*) mailboxIdKey;

+ (NSString*) messageIndexKey;

+ (ZFUndeleteMessageHttpGetIn*) undeleteMessageHttpGetIn; 

@end

@interface ZFUndeleteMessageHttpGetIn (ValueProperties) 
@end

