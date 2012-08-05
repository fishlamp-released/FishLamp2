//
//  FLTextGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/20/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewTextCell.h"
#import "FLGridViewController.h"

@implementation FLGridViewTextCell

@synthesize text = _text;

- (id) init {
    if((self = [super init])) {
        self.arrangeableInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}

- (void) dealloc {
    FLRelease(_label);
    FLRelease(_text);
    FLSuperDealloc();
}

- (void) cellWillAppearInSuperview:(UIView *)superview  viewController:(FLGridViewController*) viewController  {
    [viewController.objectCache uncacheObject:&_label reuseIdentifier:@"label" 
        createBlock:^{
            UILabel* label = FLReturnAutoreleased([[UILabel alloc] initWithFrame:self.frame]);
            label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [superview addSubview:label];
            return label;
        }];

    _label.hidden = NO;
    _label.text = _text;
}

- (void) cellDidDisappearFromSuperview:(UIView*) superview  viewController:(FLGridViewController*) viewController  {
    [viewController.objectCache cacheObject:&_label reuseIdentifier:@"label"];
}

- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableFillMode) fillMode {

    switch(fillMode) {
        case FLArrangeableFillModeGrowWidth:
            outSize->width = [self.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
                                            constrainedToSize:CGSizeMake( 2048, inSize.height)
                                            lineBreakMode:UILineBreakModeWordWrap].height;
        break;
        
        case FLArrangeableFillModeGrowHeight:
            outSize->height = [self.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
                                            constrainedToSize:CGSizeMake(inSize.width, 2048)
                                            lineBreakMode:UILineBreakModeWordWrap].height;
        break;

        case FLArrangeableFillModeNone:
        case FLArrangeableFillModeFlexibleWidth:
        break;

    
    }
}

@end