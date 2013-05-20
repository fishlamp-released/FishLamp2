//
//  FLSplitterView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSplitterView.h"
#import "FLGradientWidget.h"
#import "FLColorRange.h"

@implementation FLSplitterView

@synthesize delegate = _splitterViewDelegate; 

- (id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.autoresizesSubviews = NO;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.userInteractionEnabled = YES;
    
        FLGradientWidget* background = [FLGradientWidget widget];
        background.contentMode = FLRectLayoutFill;
        [background setColorRange:[FLColorRange lightLightGrayGradientColorRange] forControlState:FLControlStateNormal];
        [self addWidget:background];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint newTouch = [touch locationInView:self.superview];
    self.frameOptimizedForLocation = FLRectCenterOnPointVertically(self.frame, newTouch);
    [self.delegate splitterViewWasMoved:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

#if FL_MRC
- (void) dealloc {
    FLSuperDealloc();   
}
#endif

@end
