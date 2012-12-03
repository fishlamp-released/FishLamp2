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


#if FL_MRC
- (void) dealloc {

    [_values release];
    [super dealloc];
}
#endif

- (void) addValue:(NSString*) param {
    if(!_values) {
        _values = [[NSMutableArray alloc] init];
    }
    [_values addObject:param];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { key=%@, values=%@", [super description], self.key, [self.values description]];
}

- (NSString*) parameterString {
    NSMutableString* string = [NSMutableString stringWithString:self.key];
    
    for(NSString* value in _values) {
        [string appendFormat:@" %@", value];
    }
    
    return string;
}

@end

