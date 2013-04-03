//
//	FLUserPreferences.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserPreferences.h"

#define kFileName @"prefs.plist"

@interface FLUserPreferences ()
@property (readwrite, strong, nonatomic) FLFolder* folder;
@end

@implementation FLUserPreferences

@synthesize folder = _folder;

+ (id) userPreferences {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) readFromFolder:(FLFolder*) folder {
    FLAssertNotNil(folder);
    
    FLUserPreferences* prefs = [folder readObjectFromFile:kFileName];
    if(!prefs) {
        prefs = [FLUserPreferences userPreferences];
        [prefs setDefaults];
    }

    prefs.folder = folder;
    return prefs;
}

- (void) writeToFile {
	[_folder writeObjectToFile:kFileName object:self];
}

- (id) initWithCoder:(NSCoder*) aDecoder {
	if((self = [super init])) {
	}
	
	return self;
}

- (void) setDefaults {
}

- (void) encodeWithCoder:(NSCoder*) aCoder {
}

#if FL_MRC
- (void) dealloc {
    [_folder release];
    [super dealloc];
}
#endif


@end
