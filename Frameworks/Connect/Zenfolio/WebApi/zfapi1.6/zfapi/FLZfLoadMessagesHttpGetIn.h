//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadMessagesHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadMessagesHttpGetIn
// --------------------------------------------------------------------
@interface FLZfLoadMessagesHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSString* _postedSince;
	NSString* _includeDeleted;
} 


@property (readwrite, retain, nonatomic) NSString* includeDeleted;

@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSString* postedSince;

+ (NSString*) includeDeletedKey;

+ (NSString*) mailboxIdKey;

+ (NSString*) postedSinceKey;

+ (FLZfLoadMessagesHttpGetIn*) loadMessagesHttpGetIn; 

@end

@interface FLZfLoadMessagesHttpGetIn (ValueProperties) 
@end

