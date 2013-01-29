//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadMessagesHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadMessagesHttpGetIn
// --------------------------------------------------------------------
@interface ZFLoadMessagesHttpGetIn : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFLoadMessagesHttpGetIn*) loadMessagesHttpGetIn; 

@end

@interface ZFLoadMessagesHttpGetIn (ValueProperties) 
@end

