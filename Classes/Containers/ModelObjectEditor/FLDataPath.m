//
//  FLDataKey.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDataPath.h"

@interface FLDataPath ()
@property (readwrite, strong, nonatomic) NSArray* keys;
@end

@implementation FLDataPath

@synthesize keys = _keys;

- (id) initWithPath:(NSString*) path {
    self = [super init];
    if(self) {
        self.keys = [path componentsSeparatedByString:@"/"];
    }
    return self;
}

+ (FLDataPath*) dataKeyWithPath:(NSString*) path {
    return FLReturnAutoreleased([[FLDataPath alloc] initWithPath:path]);
}

- (NSUInteger) keyCount {
    return _keys.count;
}

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (id) lastKey {
    return [_keys lastObject];
}

- (BOOL) isEmpty {
    return _keys.count == 0;
}

- (id) keyAtIndex:(NSUInteger) theIndex {
    return [_keys objectAtIndex:theIndex];
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_keys);
    FLSuperDealloc();
}
#endif

@end

@implementation NSObject (FLDataPath)
+ (NSString*) dataSourceKey {
	return NSStringFromClass([self class]);
}
@end