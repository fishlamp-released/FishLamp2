//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAddMessage.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioMessageUpdater;

// --------------------------------------------------------------------
// FLZenfolioAddMessage
// --------------------------------------------------------------------
@interface FLZenfolioAddMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	FLZenfolioMessageUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) FLZenfolioMessageUpdater* updater;

+ (NSString*) mailboxIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioAddMessage*) addMessage; 

@end

@interface FLZenfolioAddMessage (ValueProperties) 
@end

