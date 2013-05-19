//
//  NSObject+FLObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/23/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import <Foundation/Foundation.h>
#import "FLObjectBuilder.h"
#import "FLPropertyInflator.h"
#import "FLType.h"

@interface NSObject (FLObjectBuilder)

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLPropertyInflator*) state;

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLPropertyInflator*) state;

@end

#endif