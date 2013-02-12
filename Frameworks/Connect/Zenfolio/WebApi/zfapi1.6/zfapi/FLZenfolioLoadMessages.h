//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadMessages.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadMessages
// --------------------------------------------------------------------
@interface FLZenfolioLoadMessages : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSDate* _postedSince;
	NSNumber* _includeDeleted;
} 


@property (readwrite, retain, nonatomic) NSNumber* includeDeleted;

@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSDate* postedSince;

+ (NSString*) includeDeletedKey;

+ (NSString*) mailboxIdKey;

+ (NSString*) postedSinceKey;

+ (FLZenfolioLoadMessages*) loadMessages; 

@end

@interface FLZenfolioLoadMessages (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL includeDeletedValue;
@end

