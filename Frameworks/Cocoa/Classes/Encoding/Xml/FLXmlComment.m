//
//  FLXmlCommentElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlComment.h"

@implementation FLXmlComment

+ (id) xmlComment {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {
    
    BOOL hasLines = self.lines.count > 0;
    if(hasLines) {
        [stringFormatter appendLine:@"<--"];

        [stringFormatter indent:^{
            [super buildStringIntoStringFormatter:stringFormatter];
        }];
        
        [stringFormatter appendLine:@"-->"];
    }
    
}                           

@end


