//
//  FLBotError.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBotError.h"
#import "FLBot.h"

@interface FLBotError ()
@property (readwrite, strong) NSError* error;
@property (readwrite, strong) FLBot* bot;
@end

@implementation FLBotError

@synthesize error = _error;
@synthesize bot = _bot;

- (id) initWithBot:(FLBot*) bot
             error:(NSError*) error {

    self = [super init];
    if(self) {
        self.bot = bot;
        self.error = error;
    }
    
    return self;
}

+ (id) botErrorMessage:(FLBot*) bot
    error:(NSError*) error {
    return FLReturnAutoreleased([[[self class] alloc] initWithBot:bot error:error]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_error release];
    [_bot release];
    [super dealloc];
}
#endif


@end
