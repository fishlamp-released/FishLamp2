//
//  FLStorableObject.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@protocol FLStorableObject <NSObject>

@property (readonly, assign, nonatomic) BOOL canWriteToStorage;
@property (readonly, assign, nonatomic) BOOL canDeleteFromStorage;
@property (readonly, assign, nonatomic) BOOL existsInStorage;
@property (readonly, assign, nonatomic) unsigned long long sizeInStorage;

- (NSInputStream*) createReadStream;
- (void) readFromStorage;
- (void) writeToStorage;
- (void) deleteFromStorage; // will throw if not exists!
@end
