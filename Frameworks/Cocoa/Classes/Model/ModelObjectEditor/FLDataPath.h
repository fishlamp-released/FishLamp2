//
//  FLDataKey.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#define FLDefaultDataSource @"."

@interface FLDataPath : NSObject {
@private

// TODO: would like to figure out a way to not use a dynamically allocated array
    NSArray* _keys;
}

@property (readonly, nonatomic, assign) BOOL isEmpty;

@property (readonly, nonatomic, assign) NSUInteger keyCount;

@property (readonly, nonatomic, retain) id lastKey;

- (id) keyAtIndex:(NSUInteger) theIndex;

- (id) initWithPath:(NSString*) path;

+ (FLDataPath*) dataKeyWithPath:(NSString*) path;

@end

@interface NSObject (FLDataPath)
//+ (NSString*) keyPathWithDataKey:(NSString*) location;
+ (NSString*) dataSourceKey;
@end

