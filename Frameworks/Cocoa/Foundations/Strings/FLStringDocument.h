//
//  FLStringBuilderContents.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLWhitespace.h"
#import "FLStringFormatter.h"
#import "FLStringBuilder.h"
#import "FLPrettyString.h"

@interface FLStringDocument : NSObject {
@private
    NSMutableArray* _stack;
}

@property (readonly, strong, nonatomic) NSArray* openedStringBuilders;

@property (readonly, strong, nonatomic) FLStringBuilder* rootStringBuilder;

@property (readonly, strong, nonatomic) FLStringBuilder* openedStringBuilder;

- (void) addStringBuilder:(FLStringBuilder*) stringBuilder;

- (void) openStringBuilder:(FLStringBuilder*) stringBuilder;

- (FLStringBuilder*) closeStringBuilder;

- (void) closeAllStringBuilders;

- (void) deleteAllStringBuilders;

@end


