//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadMessagesHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadMessagesHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioLoadMessagesHttpGetIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioLoadMessagesHttpGetIn*) loadMessagesHttpGetIn; 

@end

@interface FLZenfolioLoadMessagesHttpGetIn (ValueProperties) 
@end

