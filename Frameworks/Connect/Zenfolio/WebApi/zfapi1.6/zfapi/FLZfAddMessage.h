//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAddMessage.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfMessageUpdater;

// --------------------------------------------------------------------
// FLZfAddMessage
// --------------------------------------------------------------------
@interface FLZfAddMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	FLZfMessageUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) FLZfMessageUpdater* updater;

+ (NSString*) mailboxIdKey;

+ (NSString*) updaterKey;

+ (FLZfAddMessage*) addMessage; 

@end

@interface FLZfAddMessage (ValueProperties) 
@end

