//
//  FLStorableObject.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLBlocks.h"

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
