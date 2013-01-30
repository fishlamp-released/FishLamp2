//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetVideoPlaybackUrlResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetVideoPlaybackUrlResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetVideoPlaybackUrlResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetVideoPlaybackUrlResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetVideoPlaybackUrlResult;

+ (NSString*) GetVideoPlaybackUrlResultKey;

+ (FLZenfolioGetVideoPlaybackUrlResponse*) getVideoPlaybackUrlResponse; 

@end

@interface FLZenfolioGetVideoPlaybackUrlResponse (ValueProperties) 
@end

