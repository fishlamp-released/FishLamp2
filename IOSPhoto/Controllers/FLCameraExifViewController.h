//
//	FLCameraExifViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEditObjectViewController.h"
#import "FLCameraExifTableViewBuilder.h"

@interface FLCameraExifViewController : FLEditObjectViewController {
@private
	FLCameraExifTableViewBuilder* _exifBuilder;
}

@property (readonly, retain, nonatomic) FLCameraExifTableViewBuilder* exifBuilder;
@end


