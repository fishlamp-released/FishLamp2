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

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    
//    FLPrettyString* temp = [FLPrettyString prettyString:prettyString.whitespace];
//    temp.tabIndent = prettyString.tabIndent;
//    [super appendSelfToPrettyString:temp];
//    
//    if(temp.length) {
//        [prettyString appendLine:@"<--"];
//
//        [prettyString indent:^{
//            [prettyString appendLine:temp.string];
//        }];
//        
//        [prettyString appendLine:@"-->"];
//    }
    
}                           

@end