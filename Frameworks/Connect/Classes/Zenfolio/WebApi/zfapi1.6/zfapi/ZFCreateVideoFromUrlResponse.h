//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateVideoFromUrlResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreateVideoFromUrlResponse
// --------------------------------------------------------------------
@interface ZFCreateVideoFromUrlResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreateVideoFromUrlResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreateVideoFromUrlResult;

+ (NSString*) CreateVideoFromUrlResultKey;

+ (ZFCreateVideoFromUrlResponse*) createVideoFromUrlResponse; 

@end

@interface ZFCreateVideoFromUrlResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreateVideoFromUrlResultValue;
@end

