//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAddMessageResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFMessage;

// --------------------------------------------------------------------
// ZFAddMessageResponse
// --------------------------------------------------------------------
@interface ZFAddMessageResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFMessage* _AddMessageResult;
} 


@property (readwrite, retain, nonatomic) ZFMessage* AddMessageResult;

+ (NSString*) AddMessageResultKey;

+ (ZFAddMessageResponse*) addMessageResponse; 

@end

@interface ZFAddMessageResponse (ValueProperties) 
@end

