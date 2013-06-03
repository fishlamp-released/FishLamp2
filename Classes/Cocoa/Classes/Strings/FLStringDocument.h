//
//  FLStringBuilderContents.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLWhitespace.h"
#import "FLStringFormatter.h"
#import "FLDocumentSection.h"
#import "FLPrettyString.h"

@interface FLStringDocument : NSObject {
@private
    NSMutableArray* _stack;
}

@property (readonly, strong, nonatomic) NSArray* openedStringBuilders;

@property (readonly, strong, nonatomic) id<FLStringFormatter, FLBuildableString> rootStringBuilder;

@property (readonly, strong, nonatomic) id<FLStringFormatter, FLBuildableString> openedStringBuilder;

- (void) appendStringFormatter:(id<FLStringFormatter, FLBuildableString>) stringBuilder;

- (void) openStringBuilder:(id<FLStringFormatter, FLBuildableString>) stringBuilder;

- (id<FLStringFormatter, FLBuildableString>) closeStringBuilder;

- (void) closeAllStringBuilders;

- (void) deleteAllStringBuilders;

@end


