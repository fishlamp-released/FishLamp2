//
//  GtTextGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/20/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewTextCell.h"
#import "GtGridViewController.h"

@implementation GtGridViewTextCell

@synthesize text = m_text;

- (id) init
{
    if((self = [super init]))
    {
        self.viewLayoutBehavior = [GtViewLayoutBehavior viewLayoutBehavior];
        self.viewLayoutBehavior.margins = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}

- (void) dealloc
{
    GtRelease(m_label);
    GtRelease(m_text);
    GtSuperDealloc();
}

- (void) cellWillAppearInSuperview:(UIView *)superview  viewController:(GtGridViewController*) viewController 
{
    [viewController.objectCache uncacheObject:&m_label reuseIdentifier:@"label" 
        createBlock:^{
            UILabel* label = GtReturnAutoreleased([[UILabel alloc] initWithFrame:self.frame]);
            label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [superview addSubview:label];
            return label;
        }];

    m_label.hidden = NO;
    m_label.text = m_text;
}

- (void) cellDidDisappearFromSuperview:(UIView*) superview  viewController:(GtGridViewController*) viewController 
{
    [viewController.objectCache cacheObject:&m_label reuseIdentifier:@"label"];
}

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint)hint
{

    hint.size.height = [self.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
									constrainedToSize:CGSizeMake(hint.size.width, 2048)
									lineBreakMode:UILineBreakModeWordWrap].height;

    return hint.size;
}

@end