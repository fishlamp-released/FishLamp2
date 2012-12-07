//
//  FLTextGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/20/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLLabelGridCell.h"
#import "FLGridViewController.h"

@implementation FLLabelGridCell

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
    super_dealloc_();
}

//- (void) cellWillAppearInSuperview:(UIView *)superview  viewController:(FLGridViewController*) viewController  {
//    _[viewController.objectCache uncacheObject:&_label reuseIdentifier:@"label"
//        createBlock:^{
//            UILabel* label = FLAutorelease([[UILabel alloc] initWithFrame:self.frame]);
//            label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
//            label.textColor = [UIColor whiteColor];
//            label.backgroundColor = [UIColor clearColor];
//            [superview addSubview:label];
//            return label;
//        }];
//
//    _label.hidden = NO;
//    _label.text = _text;
//}
//
//- (void) cellDidDisappearFromSuperview:(UIView*) superview  viewController:(FLGridViewController*) viewController  {
//    [viewController.objectCache cacheObject:&_label reuseIdentifier:@"label"];
//}

- (void) calculateArrangementSize:(FLSize*) outSize
                           inSize:(FLSize) inSize
                         fillMode:(FLArrangeableGrowMode) fillMode {

    switch(fillMode) {
        case FLArrangeableGrowModeGrowWidth:
            outSize->width = [self.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
                                            constrainedToSize:FLSizeMake( 2048, inSize.height)
                                            lineBreakMode:UILineBreakModeWordWrap].height;
        break;
        
        case FLArrangeableGrowModeGrowHeight:
            outSize->height = [self.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
                                            constrainedToSize:FLSizeMake(inSize.width, 2048)
                                            lineBreakMode:UILineBreakModeWordWrap].height;
        break;

        case FLArrangeableGrowModeNone:
        case FLArrangeableGrowModeFlexibleWidth:
        break;

    
    }
}

@end