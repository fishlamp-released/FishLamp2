//
//  FLToolbarTitleView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLToolbarItemView.h"

@interface FLToolbarTitleView : FLToolbarItemView {
@private
    UILabel* _textLabel;
}

+ (FLToolbarTitleView*) toolbarTitleView;
@property (readwrite, retain, nonatomic) UILabel* textLabel;
- (void) setGrayText;
@end

