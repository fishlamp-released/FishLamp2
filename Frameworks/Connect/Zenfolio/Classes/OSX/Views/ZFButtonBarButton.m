//
//  ZFButtonBarButton.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFButtonBarButton.h"

@implementation ZFButtonBarButton
- (void) setToZenfolioStyle {
    [self setFont:[NSFont zenfolioButtonBarButtonFont]];
    [self setBezelStyle:NSSmallSquareBezelStyle];
}
@end
