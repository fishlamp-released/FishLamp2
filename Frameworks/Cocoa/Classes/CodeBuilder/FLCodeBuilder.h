//
//  FLCodeBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLPrettyString.h"
#import "FLDocumentBuilder.h"

@interface FLCodeChunk : FLDocumentSection {
@private
    NSString* _openScopeString;
    NSString* _closeScopeString;
}
+ (id) codeChunk;

@property (readwrite, strong, nonatomic) NSString* openScopeString;
@property (readwrite, strong, nonatomic) NSString* closeScopeString;
@end

@interface FLCodeBuilder : FLDocumentBuilder {
@private
}

+ (id) codeBuilder;

- (void) addCodeChunk:(FLCodeChunk*) codeChunk;
- (void) openCodeChunk:(FLCodeChunk*) codeChunk;
- (void) closeCodeChunk;
@end

