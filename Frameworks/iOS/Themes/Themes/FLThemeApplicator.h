//
//  FLThemeApplicator.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol FLThemeApplicator <NSObject>
- (void) applyThemeToObject:(id) object;
@end
