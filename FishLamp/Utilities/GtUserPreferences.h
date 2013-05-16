//
//  GtUserPreferences.h
//  MyZen
//
//  Created by Mike Fullerton on 11/4/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtObject.h"

@interface GtUserPreferences : GtObject {

}

- (void) setDefaults;
- (BOOL) save;
- (BOOL) load;
- (BOOL) delete;


@end
