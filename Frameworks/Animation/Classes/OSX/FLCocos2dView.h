//
//  FLCocos2dViw.h
//  FishLampAnimation
//
//  Created by Mike Fullerton on 4/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocos2d.h"

@protocol FLCocos2dViewDelegate;

@interface FLCocos2dView : CCGLView {
@private
    IBOutlet __unsafe_unretained id<FLCocos2dViewDelegate> _delegate;
}
@property (readwrite, nonatomic, assign) id<FLCocos2dViewDelegate> delegate;
@end

@protocol FLCocos2dViewDelegate <NSObject>
- (void) cocos2dViewDidMoveToWindow:(FLCocos2dView*) view;
@end

