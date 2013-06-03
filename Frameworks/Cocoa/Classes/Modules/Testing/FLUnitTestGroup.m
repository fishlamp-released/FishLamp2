//
//  FLUnitTestGroup.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnitTestGroup.h"

@interface FLUnitTestGroup ()
@property (readwrite, strong) NSString* groupName;
@property (readwrite, assign) int32_t groupPriority;
@end

@implementation FLUnitTestGroup

@synthesize groupName = _groupName;
@synthesize groupPriority = _groupPriority;

- (id) initWithGroupName:(NSString*) name priority:(int32_t) priority {
    self = [super init];
    if(self) {
        self.groupName = name;
        self.groupPriority = priority;
    }
    return self;
}

+ (id) unitTestGroup:(NSString*) name priority:(int32_t) priority {
    return FLAutorelease([[[self class] alloc] initWithGroupName:name priority:priority]);
}

#if FL_MRC
- (void) dealloc {
    [_groupName release];
    [super dealloc];
}
#endif

- (BOOL)isEqual:(id)object {
    return  object == self ||
            [self.groupName isEqual:[object groupName]];
}

- (id) copyWithZone:(NSZone*) zone {
    return FLRetain(self);
}

- (NSUInteger)hash {
    return [self.groupName hash];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { name=%@, priority=%d }", [super description], self.groupName, [self groupPriority]];
}

@end
