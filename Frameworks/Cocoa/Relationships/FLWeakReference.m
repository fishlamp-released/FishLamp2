//
//	FLWeakReference.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FLWeakReference.h"
#import "FLDeallocNotifier.h"
#import "FLWeaklyReferenced.h"

@interface FLWeakReference ()
@property (readwrite, weak) id object_ref;
@property (readwrite, assign) NSUInteger hash;
@end

@implementation FLWeakReference

@synthesize hash = _hash;
@synthesize object_ref = _object;

- (id) object {
    return self.object_ref;
}

- (void) setObject:(FLWeaklyReferencedObject) object {

    id prev = self.object_ref;
    if(prev) {
        [prev removeDeallocNotifier:self];
    }
    
    self.hash = [object hash];
    self.object_ref = object;
    
    if(object) {
        [((id)object) addDeallocNotifier:self];
    }
}

- (id) initWithObject:(FLWeaklyReferencedObject) object {
    self = [super init];
	if(self) {
        self.object = object;
    }
	
	return self;
}

- (void) setObjectToNil {   
    self.object = nil;
}

- (void) receiveNotification:(id) sender {
    self.object_ref = nil;
}

+ (id) weakReference:(FLWeaklyReferencedObject) object {
	return FLAutorelease([[[self class] alloc] initWithObject:object]);
}

+ (id) weakReference {
	return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) description {
    id obj = self.object_ref;
	return [NSString stringWithFormat:@"FLWeakReference: %@", [obj description]];
}

- (BOOL) isNil {
	return self.object_ref == nil;
}

- (BOOL) isEqual:(id) object {
    id obj = self.object_ref;
    return self == object || obj == object || [obj isEqual:object];
}

@end






