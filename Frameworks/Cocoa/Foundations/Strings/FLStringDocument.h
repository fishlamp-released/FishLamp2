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
#import "FLDocumentSection.h"
#import "FLPrettyString.h"

@interface FLStringDocument : NSObject {
@private
    NSMutableArray* _stack;
}

@property (readonly, strong, nonatomic) NSArray* openedStringBuilders;

@property (readonly, strong, nonatomic) FLDocumentSection* rootStringBuilder;

@property (readonly, strong, nonatomic) FLDocumentSection* openedStringBuilder;

- (void) addStringBuilder:(FLDocumentSection*) stringBuilder;

- (void) openStringBuilder:(FLDocumentSection*) stringBuilder;

- (FLDocumentSection*) closeStringBuilder;

- (void) closeAllStringBuilders;

- (void) deleteAllStringBuilders;

@end


