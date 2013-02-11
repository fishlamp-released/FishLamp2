//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetVideoPlaybackUrlHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetVideoPlaybackUrlHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioGetVideoPlaybackUrlHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
	NSString* _mode;
	NSString* _width;
	NSString* _height;
} 


@property (readwrite, retain, nonatomic) NSString* height;

@property (readwrite, retain, nonatomic) NSString* mode;

@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* width;

+ (NSString*) heightKey;

+ (NSString*) modeKey;

+ (NSString*) photoIdKey;

+ (NSString*) widthKey;

+ (FLZenfolioGetVideoPlaybackUrlHttpPostIn*) getVideoPlaybackUrlHttpPostIn; 

@end

@interface FLZenfolioGetVideoPlaybackUrlHttpPostIn (ValueProperties) 
@end

