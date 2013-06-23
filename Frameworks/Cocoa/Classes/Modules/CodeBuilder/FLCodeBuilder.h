//
//  FLCodeBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLDocumentBuilder.h"

@class FLCodeChunk;

@interface FLCodeBuilder : FLDocumentBuilder {
@private
}

+ (id) codeBuilder;

//- (void) addCodeChunk:(FLCodeChunk*) codeChunk;
//- (void) openCodeChunk:(FLCodeChunk*) codeChunk;
//- (void) closeCodeChunk;
@end

