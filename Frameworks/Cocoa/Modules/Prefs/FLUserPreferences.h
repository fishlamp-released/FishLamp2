//
//	FLUserPreferences.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFolder.h"

@interface FLUserPreferences : NSObject<NSCoding> {
@private
    FLFolder* _folder;
}

+ (id) userPreferences;
+ (id) readFromFolder:(FLFolder*) folder;

- (void) setDefaults;
- (void) writeToFile;



@end
