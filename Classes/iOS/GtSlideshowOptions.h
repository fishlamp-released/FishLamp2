//	This file was generated at 7/3/11 1:03 PM by PackMule. DO NOT MODIFY!!
//
//	GtSlideshowOptions.h
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtDatabaseObject.h"

// --------------------------------------------------------------------
// GtSlideshowOptions
// --------------------------------------------------------------------
@interface GtSlideshowOptions : GtDatabaseObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_speed;
	NSNumber* m_repeat;
	NSNumber* m_autoStart;
	NSNumber* m_autoShowCaptions;
	NSNumber* m_random;
	NSNumber* m_playMusic;
	NSMutableArray* m_mediaItemList;
} 


@property (readwrite, retain, nonatomic) NSNumber* autoShowCaptions;

@property (readwrite, retain, nonatomic) NSNumber* autoStart;

@property (readwrite, retain, nonatomic) NSMutableArray* mediaItemList;

@property (readwrite, retain, nonatomic) NSNumber* playMusic;

@property (readwrite, retain, nonatomic) NSNumber* random;

@property (readwrite, retain, nonatomic) NSNumber* repeat;

@property (readwrite, retain, nonatomic) NSNumber* speed;

+ (NSString*) autoShowCaptionsKey;

+ (NSString*) autoStartKey;

+ (NSString*) mediaItemListKey;

+ (NSString*) playMusicKey;

+ (NSString*) randomKey;

+ (NSString*) repeatKey;

+ (NSString*) speedKey;

+ (GtSlideshowOptions*) slideshowOptions; 

@end

@interface GtSlideshowOptions (ValueProperties) 

@property (readwrite, assign, nonatomic) float speedValue;

@property (readwrite, assign, nonatomic) BOOL repeatValue;

@property (readwrite, assign, nonatomic) BOOL autoStartValue;

@property (readwrite, assign, nonatomic) BOOL autoShowCaptionsValue;

@property (readwrite, assign, nonatomic) BOOL randomValue;

@property (readwrite, assign, nonatomic) BOOL playMusicValue;
@end

