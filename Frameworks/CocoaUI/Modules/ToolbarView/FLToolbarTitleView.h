//
//  FLToolbarTitleView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#import "FLToolbarItemView.h"

@interface FLToolbarTitleView : FLToolbarItemView {
@private
    SDKLabel* _textLabel;
}

+ (FLToolbarTitleView*) toolbarTitleView;
@property (readwrite, retain, nonatomic) SDKLabel* textLabel;
- (void) setGrayText;
@end

