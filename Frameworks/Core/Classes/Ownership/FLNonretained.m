//
//  FLNonretained.m
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNonretained.h"
#import "FLAssertions.h"

@implementation FLNonretained

- (id) init {	
	return [self initWithRepresentedObject:nil];
}

- (id) initWithRepresentedObject:(id) representedObject {
    FLAssertNotNil(representedObject);

    // assigned, not retained!
    _representedObject = representedObject;
	return self;
}

+ (id) nonretained:(id) object {
	return FLAutorelease([[FLNonretained alloc] initWithRepresentedObject:object]);
}

@end

@implementation NSObject (FLNonretained)
- (id) nonretained_fl {
    return [FLNonretained nonretained:self];
}
@end

