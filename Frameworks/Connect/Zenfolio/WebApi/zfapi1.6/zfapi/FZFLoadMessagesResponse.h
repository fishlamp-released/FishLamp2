//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadMessagesResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioMessage;

// --------------------------------------------------------------------
// FLZenfolioLoadMessagesResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadMessagesResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadMessagesResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadMessagesResult;
// Type: FLZenfolioMessage*, forKey: Message

+ (NSString*) LoadMessagesResultKey;

+ (FLZenfolioLoadMessagesResponse*) loadMessagesResponse; 

@end

@interface FLZenfolioLoadMessagesResponse (ValueProperties) 
@end

