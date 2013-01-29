//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreateVideoFromUrlResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCreateVideoFromUrlResponse
// --------------------------------------------------------------------
@interface FLZfCreateVideoFromUrlResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreateVideoFromUrlResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreateVideoFromUrlResult;

+ (NSString*) CreateVideoFromUrlResultKey;

+ (FLZfCreateVideoFromUrlResponse*) createVideoFromUrlResponse; 

@end

@interface FLZfCreateVideoFromUrlResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreateVideoFromUrlResultValue;
@end

