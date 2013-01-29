//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeleteMessage.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFDeleteMessage
// --------------------------------------------------------------------
@interface ZFDeleteMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSNumber* _messageIndex;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSNumber* messageIndex;

+ (NSString*) mailboxIdKey;

+ (NSString*) messageIndexKey;

+ (ZFDeleteMessage*) deleteMessage; 

@end

@interface ZFDeleteMessage (ValueProperties) 

@property (readwrite, assign, nonatomic) int messageIndexValue;
@end

