//
//  NSObject+FLObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObjectBuilder.h"
#import "FLPropertyInflator.h"
#import "FLTypeDesc.h"
#import "FLCoreTypes.h"

@interface NSObject (FLObjectBuilder)

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLPropertyInflator*) state;

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLPropertyInflator*) state;

@end

