//
//  GtCellViewLayout.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/18/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCellViewLayout.h"

@implementation GtCellViewLayout

@synthesize delegate = m_delegate;

- (id) initWithDelegate:(id<GtCellViewLayoutDelegate>) delegate
{
    if((self = [super init]))
    {
        self.delegate = delegate;
    }
    
    return self;

}

@end
