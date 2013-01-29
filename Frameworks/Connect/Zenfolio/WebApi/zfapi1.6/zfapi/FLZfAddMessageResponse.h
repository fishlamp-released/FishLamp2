//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAddMessageResponse.h
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
// FLZfAddMessageResponse
// --------------------------------------------------------------------
@interface FLZfAddMessageResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfMessage* _AddMessageResult;
} 


@property (readwrite, retain, nonatomic) FLZfMessage* AddMessageResult;

+ (NSString*) AddMessageResultKey;

+ (FLZfAddMessageResponse*) addMessageResponse; 

@end

@interface FLZfAddMessageResponse (ValueProperties) 
@end

