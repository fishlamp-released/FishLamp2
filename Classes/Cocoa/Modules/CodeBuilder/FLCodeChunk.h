//
//  FLCodeChunk.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDocumentSection.h"

@interface FLCodeChunk : FLDocumentSection {
@private
    NSString* _openScopeString;
    NSString* _closeScopeString;
}
+ (id) codeChunk;

@property (readwrite, strong, nonatomic) NSString* openScopeString;
@property (readwrite, strong, nonatomic) NSString* closeScopeString;
@end