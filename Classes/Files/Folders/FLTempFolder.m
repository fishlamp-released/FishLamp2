//
//  FLTempFolder.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTempFolder.h"
#import "NSString+GUID.h"

@implementation FLTempFolder

- (id) init {
    NSString* tempFolder = NSTemporaryDirectory();
    self = [super initWithPath:[tempFolder stringByAppendingPathComponent:[NSString guidString]]];
    if(self) {
    }
    return self;
}

+ (FLTempFolder*) tempFolder {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}


@end
