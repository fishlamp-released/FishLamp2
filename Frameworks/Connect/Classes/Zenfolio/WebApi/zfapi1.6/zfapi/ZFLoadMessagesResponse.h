//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadMessagesResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFMessage;

// --------------------------------------------------------------------
// ZFLoadMessagesResponse
// --------------------------------------------------------------------
@interface ZFLoadMessagesResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadMessagesResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadMessagesResult;
// Type: ZFMessage*, forKey: Message

+ (NSString*) LoadMessagesResultKey;

+ (ZFLoadMessagesResponse*) loadMessagesResponse; 

@end

@interface ZFLoadMessagesResponse (ValueProperties) 
@end

