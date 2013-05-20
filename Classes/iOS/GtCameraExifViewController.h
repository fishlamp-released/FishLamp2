//
//	GtCameraExifViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectViewController.h"
#import "GtCameraExifTableViewBuilder.h"

@interface GtCameraExifViewController : GtEditObjectViewController {
@private
	GtCameraExifTableViewBuilder* m_exifBuilder;
}

@property (readonly, retain, nonatomic) GtCameraExifTableViewBuilder* exifBuilder;
@end


