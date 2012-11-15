//
//  FLCommandLineArgument.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCommandLineArgument.h"

@interface FLCommandLineArgument ()
@property (readwrite, strong, nonatomic) NSString* key;
@property (readwrite, strong, nonatomic) NSArray* values;
@end

@implementation FLCommandLineArgument

synthesize_(values);
synthesize_(key);

- (id) initWithKey:(NSString*) key {
    self = [super init];
    if(self) {
        self.key = key;
    }
    return self;
}

+ (id) commandLineArgument:(NSString*) key {
    return autorelease_([[[self class] alloc] initWithKey:key]);
}

dealloc_(
    [_parameters release];
)

- (void) addValue:(NSString*) param {
    if(!_parameters) {
        _parameters = [[NSMutableArray alloc] init];
    }
    [_parameters addObject:param];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { key=%@, values=%@", [super description], self.key, [self.values description]];
}

@end

