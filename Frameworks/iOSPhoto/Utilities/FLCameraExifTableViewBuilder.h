//
//	FLCameraExifTableViewBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTableViewLayoutBuilder.h"
#import "FLEditObjectViewController.h"
#import "FLPhotoMapViewController.h"

#define FLCameraExifExtrasDataSourceKey @"exifExtras"
#define FLCameraExifDimensionsExifKeyPath @"exifExtras.dimensions"

@interface FLCameraExifTableViewBuilder : NSObject {
@private
	FLTableViewLayoutBuilder* _builder;
	NSMutableDictionary* _masterExif;
	NSMutableDictionary* _extras;
	NSMutableDictionary* _overrides;
	BOOL _enableMapForGps;
}

@property (readwrite, assign, nonatomic) BOOL enableMapForGps;
@property (readwrite, retain, nonatomic) NSDictionary* masterExif;

- (void) setExifOverride:(id) value keyPath:(NSString*) keyPath;

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder;
- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager;

@end
