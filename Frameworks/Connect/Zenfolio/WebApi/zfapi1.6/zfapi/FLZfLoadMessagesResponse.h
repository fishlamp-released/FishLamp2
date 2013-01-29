//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadMessagesResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfMessage;

// --------------------------------------------------------------------
// FLZfLoadMessagesResponse
// --------------------------------------------------------------------
@interface FLZfLoadMessagesResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadMessagesResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadMessagesResult;
// Type: FLZfMessage*, forKey: Message

+ (NSString*) LoadMessagesResultKey;

+ (FLZfLoadMessagesResponse*) loadMessagesResponse; 

@end

@interface FLZfLoadMessagesResponse (ValueProperties) 
@end

