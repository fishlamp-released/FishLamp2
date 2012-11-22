//
//  FLInvisibleUntilDraggedView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLInvisibleUntilDraggedView : UIView {
@private
    BOOL _visible;
}
@property (readwrite, assign, nonatomic) CGFloat visibleAlpha;

@end