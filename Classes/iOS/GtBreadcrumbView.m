//
//  GtBreadcrumbView.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/1/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBreadcrumbView.h"

@implementation GtBreadcrumbView

@synthesize itemCount = m_itemCount;
@synthesize selectedItem = m_selectedItem;
@synthesize circleSize = m_circleSize;

@synthesize delegate = m_delegate;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        m_circleSize = 4.0f;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void) layoutSubviews 
{
    [self setNeedsDisplay];
    [super layoutSubviews];
}

- (void) setItemCount:(NSInteger) itemCount
{
    m_itemCount = itemCount;
    [self setNeedsDisplay];
}

- (void) setSelectedItem:(NSInteger) selectedItem
{
    m_selectedItem = selectedItem;
    [self setNeedsDisplay];
}

#define kBuffer 20.0f

- (void) drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSaveGState(c);
	
    CGRect circle = CGRectMake(10,10,m_circleSize, m_circleSize);
    circle = GtRectCenterRectInRectVertically(self.bounds, circle);
    
    CGFloat size = (m_circleSize * m_itemCount) + ((m_itemCount - 1) * kBuffer);
    circle.origin.x = (self.bounds.size.width / 2.0f) - (size / 2.0f);
    
//    float           myColorValues[] = {1, 0, 0, 1};// 3
//    CGColorSpaceRef myColorSpace = CGColorSpaceCreateDeviceRGB ();// 9
//    CGColorRef myColor = CGColorCreate (myColorSpace, myColorValues);// 10
//    CGContextSetShadow (c, CGSizeZero, 50); 
    
    for(int i = 0; i < m_itemCount; i++)
    {
           
        if(i == m_selectedItem)
        {
//            CGContextSetShadowWithColor(c, CGSizeMake(0,0), 5.0f, myColor);
//            [[UIColor clearColor] setFill];
//            
//            CGRect bigRect = GtRectScale(circle, 2.0f);
//            bigRect = GtRectCenterOnPoint(bigRect, GtRectGetCenter(circle));
//            CGContextFillEllipseInRect(c, bigRect);
            
//            CGContextSetShadowWithColor(c, CGSizeZero, 0, nil);
            CGContextSetRGBFillColor(c, 0, 0, 255, 0.6);
//            CGContextSetRGBStrokeColor(c, 0, 0, 255, 0.4);
        }
        else
        {
            CGContextSetRGBFillColor(c, 140, 140, 140, 0.4);
//            CGContextSetRGBStrokeColor(c, 40, 40, 40, 0.4);
//            CGContextSetShadowWithColor(c, CGSizeZero, 0, nil);
        }
    
        CGContextFillEllipseInRect(c, circle);
//        CGContextStrokeEllipseInRect(c, circle);
    
        circle.origin.x += kBuffer + circle.size.width;
    }

//    CGColorRelease (myColor);// 13
//    CGColorSpaceRelease (myColorSpace);     
    CGContextRestoreGState(c);
        
    [super drawRect:rect];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_delegate breadcrumbViewWasTapped:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}




@end
