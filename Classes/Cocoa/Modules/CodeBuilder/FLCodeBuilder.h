//
//  FLCodeBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

