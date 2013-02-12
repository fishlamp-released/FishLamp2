//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioDeleteMessage.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioDeleteMessage
// --------------------------------------------------------------------
@interface FLZenfolioDeleteMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSNumber* _messageIndex;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSNumber* messageIndex;

+ (NSString*) mailboxIdKey;

+ (NSString*) messageIndexKey;

+ (FLZenfolioDeleteMessage*) deleteMessage; 

@end

@interface FLZenfolioDeleteMessage (ValueProperties) 

@property (readwrite, assign, nonatomic) int messageIndexValue;
@end

