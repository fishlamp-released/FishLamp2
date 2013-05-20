//
//	FLCameraExifViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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


