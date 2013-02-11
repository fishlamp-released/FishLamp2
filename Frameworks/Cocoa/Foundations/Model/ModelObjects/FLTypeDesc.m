//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@interface FLTypeDesc ()
@property (readwrite, strong, nonatomic) NSString* name;
@end

@implementation FLTypeDesc

@synthesize name = _name;

static NSMutableDictionary* s_typeRegistry = nil;

#if FL_MRC
- (void) dealloc {
    [_name release];
    [super dealloc];
}
#endif

+ (void) initialize {
    if(!s_typeRegistry) {
        s_typeRegistry = [[NSMutableDictionary alloc] init];
    }
}

+ (FLTypeDesc*) registeredTypeForName:(NSString*) string {
    @synchronized(s_typeRegistry) {
        return [s_typeRegistry objectForKey:string];
    }
}

+ (void) registerTypeDesc:(FLTypeDesc*) desc {
    @synchronized(s_typeRegistry) {
        [s_typeRegistry setObject:desc forKey:desc.name];
    }
}

- (void) registerSelf {
    [FLTypeDesc registerTypeDesc:self];
}

- (id) initWithName:(NSString*) name {
    self = [super init];
    if(self) {
        self.name = name;
        [self registerSelf];
    }
    return self;
}

- (BOOL) isNumber {
    return NO;
}

- (BOOL) isObject {
    return NO;
}

- (Class) classForType {
    return nil;
}

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return nil;
}

- (id) stringToObject:(NSString*) object withDecoder:(id) decoder {
    return nil;
}


@end


