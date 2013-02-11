//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAddMessageResponse.h
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
// FLZenfolioAddMessageResponse
// --------------------------------------------------------------------
@interface FLZenfolioAddMessageResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioMessage* _AddMessageResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioMessage* AddMessageResult;

+ (NSString*) AddMessageResultKey;

+ (FLZenfolioAddMessageResponse*) addMessageResponse; 

@end

@interface FLZenfolioAddMessageResponse (ValueProperties) 
@end

