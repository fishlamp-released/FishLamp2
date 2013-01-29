//	This file was generated at 3/13/12 6:26 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPresentationModeOptions.h
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLDatabaseObject.h"
@class FLSlideshowOptions;
@class ZFBrowserViewOptions;

// --------------------------------------------------------------------
// ZFPresentationModeOptions
// --------------------------------------------------------------------
@interface ZFPresentationModeOptions : FLDatabaseObject<NSCopying, NSCoding>{ 
@private
	NSString* _pin;
	NSString* _name;
	FLSlideshowOptions* _slideshowOptions;
	ZFBrowserViewOptions* _browserViewOptions;
	NSNumber* _usePin;
} 


@property (readwrite, retain, nonatomic) ZFBrowserViewOptions* browserViewOptions;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSString* pin;

@property (readwrite, retain, nonatomic) FLSlideshowOptions* slideshowOptions;

@property (readwrite, retain, nonatomic) NSNumber* usePin;

+ (NSString*) browserViewOptionsKey;

+ (NSString*) nameKey;

+ (NSString*) pinKey;

+ (NSString*) slideshowOptionsKey;

+ (NSString*) usePinKey;

+ (ZFPresentationModeOptions*) presentationModeOptions; 

@end

@interface ZFPresentationModeOptions (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL usePinValue;
@end

