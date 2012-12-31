//
//  FLXmlCommentElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlComment.h"

@implementation FLXmlComment

//- (void) willBuildString:(FLPrettyString*) prettyString {
//    if(self.tokenCount > 0) {
//        [prettyString appendString:@"<--"];
//    }
//    [super willBuildString:prettyString];
//}
//
//- (void) didBuildString:(FLPrettyString*) prettyString {
//    if(self.tokenCount > 0) {
//        [prettyString appendString:@"<--"];
//    }
//    [super didBuildString:prettyString];
//}

+ (id) xmlComment {
    return FLAutorelease([[[self class] alloc] init]);
}


- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    if(![self hasLines]) {
        
        [prettyString appendLine:@"<--" withTabIndent:self.tabIndent];
        [prettyString indent];
        
        [super appendSelfToPrettyString:prettyString];
        
        [prettyString outdent];
        
        [prettyString appendLine:@"-->" withTabIndent:self.tabIndent];
    }
}                           

@end