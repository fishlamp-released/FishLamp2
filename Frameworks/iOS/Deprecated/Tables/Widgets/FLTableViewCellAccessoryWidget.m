//
//	FLTableViewCellDisclosureRectangle.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableViewCellAccessoryWidget.h"
#import "UIColor+FLUtils.h"
#import "UIImage+Colorize.h"

#define ArrowSize 6
#define ArrowThickness 2.5

@implementation FLTableViewCellAccessoryWidget

@synthesize color = _color;
@synthesize highlightedColor = _highlightedColor;
@synthesize checkmarkSize = _checkmarkSize;
@synthesize type = _type;
@synthesize arrowLineSize = _arrowLineSize;
@synthesize arrowSize = _arrowSize;
@synthesize selectedColor = _selectedColor;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.color = [UIColor whiteColor];
        self.arrowLineSize = ArrowThickness;
        self.arrowSize = ArrowSize;
	}
	return self;
}

- (void) dealloc
{
    FLRelease(_selectedColor);
	FLRelease(_highlightedColor);
	FLRelease(_color);
	FLSuperDealloc();
}

- (void) setType:(UITableViewCellAccessoryType) type
{
	_type = type;
	[self setNeedsDisplay];
}


- (UIImage*) checkMarkImage
{
	static UIImage* s_image = nil;
	if(!s_image)
	{ /*FLColorCreateWithRGBColorValues(171,197,225, 1.0)*/
		s_image = [UIImage imageNamed:@"check.png"];
		s_image = [s_image colorizeImage:[UIColor whiteColor] blendMode:kCGBlendModeLighten];
		s_image = [s_image colorizeImage:FLColorCreateWithRGBColorValues(171,197,225, 1.0) blendMode:kCGBlendModeMultiply]; // TODO: hard coded color from dark them
		mrc_retain_(s_image);
//		  s_image = [s_image colorizeImage:[UIColor lightGrayColor] blendMode:kCGBlendModeOverlay ];
	}
	
	return s_image;
}

- (void) resizeToAccessorySize
{
	
	switch(_type)
	{
		case UITableViewCellAccessoryNone:
		break;
	
		case UITableViewCellAccessoryDetailDisclosureButton:
		break;
	
		case UITableViewCellAccessoryDisclosureIndicator:
		self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, CGSizeMake(self.arrowSize,self.arrowSize*2));
		break;
	
		case UITableViewCellAccessoryCheckmark:
		self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, CGSizeMake(16,18));
		//self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, CGSizeMake(_checkmarkSize,_checkmarkSize));
		break;
	}

}


- (void) drawSelf:(CGRect) rect
{
	switch(_type)
	{
		case UITableViewCellAccessoryNone:
		break;
	
		case UITableViewCellAccessoryDetailDisclosureButton:
		break;
	
		case UITableViewCellAccessoryDisclosureIndicator:
		{
			CGContextRef ctx = UIGraphicsGetCurrentContext();

			CGRect frame = self.frame;
            
            FLColorValues rgb = self.color.rgbColorValues;
            
            if(self.isHighlighted && self.highlightedColor)
            {
                rgb = self.highlightedColor.rgbColorValues;
            }
            else if(self.isSelected && self.selectedColor)
            {
                rgb = self.selectedColor.rgbColorValues;
            }
            
            CGContextSetRGBStrokeColor(ctx, rgb.red, rgb.green, rgb.blue, 1.0); 
			CGContextSetLineWidth(ctx, self.arrowLineSize);
			
			CGContextMoveToPoint(ctx, frame.origin.x, frame.origin.y);
			CGContextAddLineToPoint(ctx , FLRectGetRight(frame), FLRectGetBottom(frame) - (frame.size.height * 0.5));
			CGContextAddLineToPoint(ctx , frame.origin.x, FLRectGetBottom(frame));
			CGContextStrokePath(ctx);
		}
		break;
		
		case UITableViewCellAccessoryCheckmark:
			[_color set];
			[[self checkMarkImage] drawInRect:self.frame];
		break;
	}

	[super drawSelf:rect];
}

@end
