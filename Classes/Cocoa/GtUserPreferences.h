//
//	GtUserPreferences.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtFolderFile.h"

@interface GtUserPreferences : GtFolderFile<NSCoding> {
}

- (void) setDefaults;

@end
