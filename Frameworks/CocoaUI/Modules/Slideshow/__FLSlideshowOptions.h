// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSlideshowOptions.h
// Project: FishLamp Mobile
// Schema: SlideShowObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLModelObject.h"

// --------------------------------------------------------------------
// FLSlideshowOptions
// --------------------------------------------------------------------
@interface FLSlideshowOptions : FLModelObject { 
@private
    NSNumber* __speed;
    NSNumber* __repeat;
    NSNumber* __autoStart;
    NSNumber* __autoShowCaptions;
    NSNumber* __random;
    NSNumber* __playMusic;
    NSMutableArray* __mediaItemList;
} 


@property (readwrite, strong, nonatomic) NSNumber* autoShowCaptions;

@property (readwrite, strong, nonatomic) NSNumber* autoStart;

@property (readwrite, strong, nonatomic) NSMutableArray* mediaItemList;

@property (readwrite, strong, nonatomic) NSNumber* playMusic;

@property (readwrite, strong, nonatomic) NSNumber* random;

@property (readwrite, strong, nonatomic) NSNumber* repeat;

@property (readwrite, strong, nonatomic) NSNumber* speed;

+ (NSString*) autoShowCaptionsKey;

+ (NSString*) autoStartKey;

+ (NSString*) mediaItemListKey;

+ (NSString*) playMusicKey;

+ (NSString*) randomKey;

+ (NSString*) repeatKey;

+ (NSString*) speedKey;

+ (FLSlideshowOptions*) slideshowOptions; 

@end

@interface FLSlideshowOptions (ValueProperties) 

@property (readwrite, assign, nonatomic) float speedValue;

@property (readwrite, assign, nonatomic) BOOL repeatValue;

@property (readwrite, assign, nonatomic) BOOL autoStartValue;

@property (readwrite, assign, nonatomic) BOOL autoShowCaptionsValue;

@property (readwrite, assign, nonatomic) BOOL randomValue;

@property (readwrite, assign, nonatomic) BOOL playMusicValue;
@end

// [/Generated]
