//
//  GtBlockLinkedListElement.h
//  FishLampCore
//
//  Created by Mike Fullerton on 6/14/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampMinimum.h"

#import "GtLinkedListElement.h"


@interface GtBlockLinkedListElement : GtLinkedListElement {
@private
    GtGenericBlock _block;
}

+ (GtBlockLinkedListElement*) blockLinkedListElement;

@property (readwrite, copy, nonatomic) GtGenericBlock block;
@end

