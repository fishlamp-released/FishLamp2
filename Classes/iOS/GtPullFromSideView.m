//
//  GtPullFromSideView.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPullFromSideView.h"

@implementation GtTugboatView

@synthesize delegate = m_delegate;

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
    GtSuperDealloc();
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
    m_lastPoint = [touch locationInView:self.superview];
}

- (void) touchesDidMove:(CGPoint) touch delta:(CGPoint) delta
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];

    CGPoint pt = [touch locationInView:self.superview];
        
    if(!CGPointEqualToPoint(CGPointZero, m_lastPoint))
    {   
        CGPoint delta = CGPointMake(
            pt.x - m_lastPoint.x,
            pt.y - m_lastPoint.y);
            
        [self touchesDidMove:pt delta:delta];
    }
    
    m_lastPoint = pt;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.superview];
    CGPoint delta = CGPointMake(
        pt.x - m_lastPoint.x,
        pt.y - m_lastPoint.y);
    
    [self finishTouching:pt delta:delta];
    m_lastPoint = CGPointZero;
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void) setLeft:(CGFloat) left
{
    self.frame = GtRectSetLeft(self.frame, left);
}

@end

@implementation GtPullFromSideView

- (id) initWithSide:(GtPullFromSide) side
{
    if((self = [super initWithFrame:CGRectMake(0,0,20,480)]))
    {
        m_side = side;
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
    switch(m_side)
    {
        case GtPullFromLeftSide:
            self.frame = CGRectMake(0,0,self.frame.size.width, self.superview.frame.size.height);
            break;
            
        case GtPullFromRightSide:
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
    switch(m_side)
    {
        case GtPullFromLeftSide:
            
            if(touch.x > (self.superview.frame.size.width * 0.33))
            {
                [self animateRight];
            }
            else
            {
                [self animateLeft];
            }
        
        
        break;
        
        case GtPullFromRightSide:

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
