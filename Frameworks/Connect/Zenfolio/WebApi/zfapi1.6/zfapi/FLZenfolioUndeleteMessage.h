//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUndeleteMessage.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioUndeleteMessage
// --------------------------------------------------------------------
@interface FLZenfolioUndeleteMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _mailboxId;
	NSNumber* _messageIndex;
} 


@property (readwrite, retain, nonatomic) NSString* mailboxId;

@property (readwrite, retain, nonatomic) NSNumber* messageIndex;

+ (NSString*) mailboxIdKey;

+ (NSString*) messageIndexKey;

+ (FLZenfolioUndeleteMessage*) undeleteMessage; 

@end

@interface FLZenfolioUndeleteMessage (ValueProperties) 

@property (readwrite, assign, nonatomic) int messageIndexValue;
@end

