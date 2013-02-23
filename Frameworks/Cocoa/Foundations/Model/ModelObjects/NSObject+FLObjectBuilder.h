//
//  NSObject+FLObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObjectBuilder.h"
#import "FLObjectInflatorState.h"

@interface NSObject (FLObjectBuilder)

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLObjectInflatorState*) state;

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLObjectInflatorState*) state;

@end

