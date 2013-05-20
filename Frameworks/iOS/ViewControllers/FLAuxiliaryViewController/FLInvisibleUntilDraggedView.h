//
//  FLInvisibleUntilDraggedView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface FLInvisibleUntilDraggedView : UIView {
@private
    BOOL _visible;
}
@property (readwrite, assign, nonatomic) CGFloat visibleAlpha;

@end