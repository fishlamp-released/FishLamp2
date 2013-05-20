//
//	GtCameraExifTableViewBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtTableViewLayoutBuilder.h"
#import "GtEditObjectViewController.h"
#import "GtPhotoMapViewController.h"

#define GtCameraExifExtrasDataSourceKey @"exifExtras"
#define GtCameraExifDimensionsExifKeyPath @"exifExtras.dimensions"

@interface GtCameraExifTableViewBuilder : NSObject {
@private
	GtTableViewLayoutBuilder* m_builder;
	NSMutableDictionary* m_masterExif;
	NSMutableDictionary* m_extras;
	NSMutableDictionary* m_overrides;
	BOOL m_enableMapForGps;
}

@property (readwrite, assign, nonatomic) BOOL enableMapForGps;
@property (readwrite, retain, nonatomic) NSDictionary* masterExif;

- (void) setExifOverride:(id) value keyPath:(NSString*) keyPath;

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder;
- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager;

@end

