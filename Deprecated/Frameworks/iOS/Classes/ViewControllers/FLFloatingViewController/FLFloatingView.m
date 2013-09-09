//
//	FLPopoverView.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFloatingView.h"
#import "FLPathUtilities.h"
#import "UIColor+FLUtils.h"
#import "FLColorRange.h"

@implementation FLFloatingView

@synthesize contentView = _contentView;
@synthesize containerView = _containerView;
@synthesize arrowDirection = _arrowDirection;
@synthesize targetRect = _targetRect;
@synthesize frameWidth = _frameWidth;
@synthesize arrowWidth = _arrowWidth;
@synthesize cornerRadius = _cornerRadius;

- (void) setCornerRadius:(CGFloat) radius
{
    _cornerRadius = radius;
    [self setNeedsLayout];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
        self.cornerRadius = FLFloatingViewDefaultCornerRadius;
        self.arrowWidth = FLFloatingViewDefaultArrowWidth;
        self.frameWidth = FLFloatingViewDefaultFrameWidth;
    
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.autoresizesSubviews = NO;
        
        _containerView = [[UIView alloc] initWithFrame:frame];
		_containerView.autoresizingMask = UIViewAutoresizingNone;
		_containerView.autoresizesSubviews = NO;
		_containerView.userInteractionEnabled = YES;
        _containerView.layer.borderColor = [UIColor gray10Color].CGColor;
		_containerView.backgroundColor = [UIColor clearColor];
        
		_topGradient = [[FLGradientWidget alloc] initWithFrame:CGRectZero];
//		_topGradient.themeAction = nil;
        [self addWidget:_topGradient];
        
		[_topGradient setColorRange:[FLColorRange colorRange:[UIColor grayColor] endColor:[UIColor blackColor]] forControlState:UIControlStateNormal];
		_topGradient.alpha = 0.65;
		
		_lineGradient = [[FLGradientWidget alloc] initWithFrame:CGRectZero];
//		_lineGradient.themeAction = nil;
		
        [self addWidget:_lineGradient];
		[_lineGradient setColorRange:[FLColorRange colorRange:[UIColor gray33Color] endColor:[UIColor darkGrayColor]] forControlState:UIControlStateNormal];

        [self addSubview:_containerView];
        
        [self setNeedsLayout];
	}
	
	return self;
}	

- (void) setContentView:(UIView *) view
{
	if(_contentView != view)
	{
        if(_contentView)
        {
            [_contentView removeFromSuperview];
        }
    
		FLSetObjectWithRetain(_contentView, view);
		[_containerView addSubview:_contentView];
        
        [self setNeedsLayout];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
    
    _containerView.layer.cornerRadius = self.cornerRadius;

	_contentView.newFrame = _containerView.bounds;

	_topGradient.frame = CGRectMake(0,0, self.bounds.size.width, 60);
	
    [self setNeedsDisplay];
}

- (void) getPathForTop:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = FLRectGetCenter(_targetRect);
	point.y = rect.origin.y; 
	FLCreateRectPathWithTopArrow(path, rect, point, self.arrowWidth, self.cornerRadius);
}

- (void) getPathForBottom:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = FLRectGetCenter(_targetRect);
	point.y = FLRectGetBottom(rect);
	FLCreateRectPathWithBottomArrow(path, rect, point, self.arrowWidth, self.cornerRadius);
}

- (void) getPathForRight:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = FLRectGetCenter(_targetRect);
	point.x = FLRectGetRight(rect);
	FLCreateRectPathWithRightArrow(path, rect, point, self.arrowWidth, self.cornerRadius);
}

- (void) getPathForLeft:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = FLRectGetCenter(_targetRect);
	point.x = rect.origin.x;
	FLCreateRectPathWithLeftArrow(path, rect, point, self.arrowWidth, self.cornerRadius);
}

- (void) pathForRect:(CGMutablePathRef) path rect:(CGRect) rect
{
    switch(_arrowDirection)
	{
		case FLFloatingViewArrowDirectionUp:
			[self getPathForTop:path rect:rect];
		break;
		case FLFloatingViewArrowDirectionDown:
			[self getPathForBottom:path rect:rect];
		break;
		case FLFloatingViewArrowDirectionLeft:
			[self getPathForLeft:path rect:rect];
		break;
		case FLFloatingViewArrowDirectionRight:
			[self getPathForRight:path rect:rect];
		break;

		case FLFloatingViewArrowDirectionNone:
			FLCreateRectPath(path, rect, self.cornerRadius);
		break;
	}
}

- (void) drawOuterPath:(CGContextRef) context
{
	_lineGradient.frame = self.bounds;
	CGRect outerRect = CGRectInset(self.bounds, 1, 1);
	CGMutablePathRef path =	 CGPathCreateMutable();
	[self pathForRect:path rect:outerRect];
	CGContextAddPath(context, path);
	CGContextClip(context);
	[_lineGradient drawWidget:outerRect];
	CGPathRelease(path);
}

#if DEBUG
- (void) setFrame:(CGRect) frame
{
    [super setFrame:frame];
}
#endif

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	[self drawOuterPath:context];
	CGContextRestoreGState(context);
	CGContextSaveGState(context);
	  
	CGRect innerRect = CGRectInset(self.bounds, self.frameWidth + 1.0f, self.frameWidth + 1.0f);
	CGMutablePathRef path =	 CGPathCreateMutable();
	[self pathForRect:path rect:innerRect];
	 
	CGContextAddPath(context, path);
	CGContextClip(context);
	CGContextClearRect(context, innerRect);
	
	CGContextAddPath(context, path);
    [[UIColor clearColor] setFill];
    
	FLColorValues fillRgb = self.backgroundColor.rgbColorValues;
	CGContextSetRGBFillColor(context, fillRgb.red, fillRgb.green, fillRgb.blue, 0.8);
	CGContextFillPath(context);

	CGContextAddPath(context, path);
	CGContextClip(context);
	[_topGradient drawWidget:innerRect];

	CGContextRestoreGState(context);
	CGPathRelease(path);
}

- (void) dealloc
{	
	FLRelease(_lineGradient);
	FLRelease(_topGradient);
	FLRelease(_containerView);
	FLRelease(_contentView);
	FLSuperDealloc();
}


@end
