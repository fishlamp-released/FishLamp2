//
//  FLPullFromSideView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPullFromSideView.h"

@implementation FLTugboatView

@synthesize delegate = _delegate;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES;
    
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.3f;
    }
    
    return self;
}

- (void) dealloc
{
    FLSuperDealloc();
}

- (void) finishTouching:(CGPoint) touch delta:(CGPoint) delta
{
}

- (void) touchesDidBegin:(CGPoint) touch
{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.superview];
}

- (void) touchesDidMove:(CGPoint) touch delta:(CGPoint) delta
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];

    CGPoint pt = [touch locationInView:self.superview];
        
    if(!CGPointEqualToPoint(CGPointZero, _lastPoint))
    {   
        CGPoint delta = CGPointMake(
            pt.x - _lastPoint.x,
            pt.y - _lastPoint.y);
            
        [self touchesDidMove:pt delta:delta];
    }
    
    _lastPoint = pt;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.superview];
    CGPoint delta = CGPointMake(
        pt.x - _lastPoint.x,
        pt.y - _lastPoint.y);
    
    [self finishTouching:pt delta:delta];
    _lastPoint = CGPointZero;
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void) setLeft:(CGFloat) left
{
    self.frame = FLRectSetLeft(self.frame, left);
}

@end

@implementation FLPullFromSideView

- (id) initWithSide:(FLPullFromSide) side
{
    if((self = [super initWithFrame:CGRectMake(0,0,20,480)]))
    {
        _side = side;
        self.autoresizingMask = 
            UIViewAutoresizingFlexibleLeftMargin | 
            UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleHeight |
            UIViewAutoresizingFlexibleBottomMargin;
    }
    
    return self;
}

- (void) resetView
{
    switch(_side)
    {
        case FLPullFromLeftSide:
            self.frame = CGRectMake(0,0,self.frame.size.width, self.superview.frame.size.height);
            break;
            
        case FLPullFromRightSide:
            self.frame = CGRectMake(self.superview.frame.size.width - self.frame.size.width,
                0, 
                self.frame.size.width, 
                self.superview.frame.size.height);
            break;
    }
}

- (void) didMoveToSuperview
{
    [super didMoveToSuperview];
    [self resetView];
}

- (void) touchesDidMove:(CGPoint)touch delta:(CGPoint)delta
{
    [self setLeft:self.frame.origin.x + delta.x];
    [self.delegate tugboatView:self dragViewsBy:CGPointMake(delta.x, 0)];
}

- (void) animateLeft
{
    [UIView animateWithDuration:0.3f 
        animations:^{ 
            [self setLeft:0]; 
            } 
        completion:^(BOOL finished) {
            [self resetView];
            [self.delegate tugboatViewDidFinishAnimating:self];
            }];
    
}

- (void) animateRight
{
    [UIView animateWithDuration:0.3f 
        animations:^{ 
            [self setLeft:self.superview.frame.size.width];
            } 
        completion:^(BOOL finished) {
            [self resetView];
            [self.delegate tugboatViewDidFinishAnimating:self];
            }];
}

- (void) finishTouching:(CGPoint)touch delta:(CGPoint)delta
{
    switch(_side)
    {
        case FLPullFromLeftSide:
            
            if(touch.x > (self.superview.frame.size.width * 0.33))
            {
                [self animateRight];
            }
            else
            {
                [self animateLeft];
            }
        
        
        break;
        
        case FLPullFromRightSide:

            if(touch.x < (self.superview.frame.size.width * 0.66))
            {
                [self animateLeft];
            }
            else
            {
                [self animateRight];
            }

        
        break;
    }




}


@end
