//
//  GtStorableObject.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

typedef void (^GtGetSizeBlock)(NSError* error, unsigned long long size);

@protocol GtStorableObject <NSObject>

@property (readonly, assign, nonatomic) BOOL canWriteToStorage;
@property (readonly, assign, nonatomic) BOOL canDeleteFromStorage;
@property (readonly, assign, nonatomic) BOOL existsInStorage;
@property (readonly, assign, nonatomic) unsigned long long sizeInStorage;

- (NSInputStream*) createReadStream;

- (void) beginLoadingRepresentation:(GtErrorCallback) completionBlock;

- (void) beginReadFromStorage:(GtErrorCallback) completionBlock;
- (void) beginWriteToStorage:(GtErrorCallback) completionBlock;
- (void) beginDeleteFromStorage:(GtErrorCallback) completionBlock;

- (void) readFromStorage;
- (void) writeToStorage;
- (void) deleteFromStorage; // will throw if not exists!


@end
