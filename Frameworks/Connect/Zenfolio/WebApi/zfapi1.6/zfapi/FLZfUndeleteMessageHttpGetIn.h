//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUndeleteMessageHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfUndeleteMessageHttpGetIn
// --------------------------------------------------------------------
@interface FLZfUndeleteMessageHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSString* _messageIndex;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSString* messageIndex;

+ (NSString*) mailboxIdKey;

+ (NSString*) messageIndexKey;

+ (FLZfUndeleteMessageHttpGetIn*) undeleteMessageHttpGetIn; 

@end

@interface FLZfUndeleteMessageHttpGetIn (ValueProperties) 
@end

