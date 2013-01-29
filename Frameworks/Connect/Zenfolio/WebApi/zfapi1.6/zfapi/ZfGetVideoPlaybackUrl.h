//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetVideoPlaybackUrl.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"

// --------------------------------------------------------------------
// ZFGetVideoPlaybackUrl
// --------------------------------------------------------------------
@interface ZFGetVideoPlaybackUrl : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	NSString* _mode;
	NSNumber* _width;
	NSNumber* _height;
} 


@property (readwrite, retain, nonatomic) NSNumber* height;

@property (readwrite, retain, nonatomic) NSString* mode;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) NSNumber* width;

+ (NSString*) heightKey;

+ (NSString*) modeKey;

+ (NSString*) photoIdKey;

+ (NSString*) widthKey;

+ (ZFGetVideoPlaybackUrl*) getVideoPlaybackUrl; 

@end

@interface ZFGetVideoPlaybackUrl (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;

@property (readwrite, assign, nonatomic) ZFVideoPlaybackMode modeValue;

@property (readwrite, assign, nonatomic) int widthValue;

@property (readwrite, assign, nonatomic) int heightValue;
@end

