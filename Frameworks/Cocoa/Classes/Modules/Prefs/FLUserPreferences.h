//
//	FLUserPreferences.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
