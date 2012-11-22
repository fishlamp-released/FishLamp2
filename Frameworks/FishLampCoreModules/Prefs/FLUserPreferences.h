//
//	FLUserPreferences.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFolderFile.h"

@interface FLUserPreferences : FLFolderFile<NSCoding> {
}

- (id) initWithFolder:(FLFolder*) folder;

- (void) setDefaults;

@end
