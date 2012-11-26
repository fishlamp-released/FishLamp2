//
//  FLBlockLinkedListElement.h
//  FishLampCore
//
//  Created by Mike Fullerton on 6/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLLinkedListElement.h"


@interface FLBlockLinkedListElement : FLLinkedListElement {
@private
    dispatch_block_t _block;
}

+ (FLBlockLinkedListElement*) blockLinkedListElement;

@property (readwrite, copy, nonatomic) dispatch_block_t block;
@end

