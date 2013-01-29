//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeleteMessage.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeleteMessage
// --------------------------------------------------------------------
@interface FLZfDeleteMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSNumber* _messageIndex;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSNumber* messageIndex;

+ (NSString*) mailboxIdKey;

+ (NSString*) messageIndexKey;

+ (FLZfDeleteMessage*) deleteMessage; 

@end

@interface FLZfDeleteMessage (ValueProperties) 

@property (readwrite, assign, nonatomic) int messageIndexValue;
@end

