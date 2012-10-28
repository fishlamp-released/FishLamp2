//
//  FLBotError.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLBot;

@interface FLBotError : NSObject {
@private
    NSError* _error;
    FLBot* _bot;
}

@property (readonly, strong) NSError* error;
@property (readonly, strong) FLBot* bot;

- (id) initWithBot:(FLBot*) bot
             error:(NSError*) error;

+ (id) botErrorMessage:(FLBot*) bot
                 error:(NSError*) error;


@end

