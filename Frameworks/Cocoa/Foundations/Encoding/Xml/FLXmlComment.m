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

- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {
    
    BOOL hasLines = self.lines.count > 0;
    if(hasLines) {
        [prettyString appendLine:@"<--"];

        [prettyString indent:^{
            [super appendLinesToPrettyString:prettyString];
        }];
        
        [prettyString appendLine:@"-->"];
    }
    
}                           

@end


