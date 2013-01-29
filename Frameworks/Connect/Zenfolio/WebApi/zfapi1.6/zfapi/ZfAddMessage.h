//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAddMessage.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFMessageUpdater;

// --------------------------------------------------------------------
// ZFAddMessage
// --------------------------------------------------------------------
@interface ZFAddMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	ZFMessageUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) ZFMessageUpdater* updater;

+ (NSString*) mailboxIdKey;

+ (NSString*) updaterKey;

+ (ZFAddMessage*) addMessage; 

@end

@interface ZFAddMessage (ValueProperties) 
@end

