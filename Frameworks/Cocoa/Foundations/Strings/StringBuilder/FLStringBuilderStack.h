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

@interface FLStringBuilderStack : NSObject {
@private
    NSMutableArray* _stack;
}

@property (readonly, strong, nonatomic) NSArray* stack;
@property (readonly, strong, nonatomic) FLStringBuilder* bottom;
@property (readonly, strong, nonatomic) FLStringBuilder* top;

- (void) push:(FLStringBuilder*) scope;
- (FLStringBuilder*) pop;
@end

@interface FLStringBuilder (FLStringBuilderStack)
- (void) willMoveToStringBuilderStack:(FLStringBuilderStack*) stack;
- (void) didMoveToStringBuilderStack:(FLStringBuilderStack*) stack;
@end

@interface FLScopedStringBuilder : FLStringFormatter<FLStringFormatterDelegate, FLBuildableString> {
@private
    FLStringBuilderStack* _stack;
}
@property (readonly, strong, nonatomic) FLStringBuilderStack* stack;
@property (readonly, strong, nonatomic) FLStringBuilder* lines;
@end

