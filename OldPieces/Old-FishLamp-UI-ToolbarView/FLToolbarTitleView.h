//
//  FLToolbarTitleView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

