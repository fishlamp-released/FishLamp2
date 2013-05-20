//
//	GtTableViewCellDisclosureRectangle.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewCellAccessoryWidget.h"
#import "UIColor+More.h"
#import "UIImage+GtColorize.h"

@implementation GtTableViewCellAccessoryWidget

@synthesize color = m_color;
@synthesize highlightedColor = m_highlightedColor;
@synthesize checkmarkSize = m_checkmarkSize;
@synthesize type = m_type;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.color = [UIColor whiteColor];
//		  m_checkmarkSize = [UIFont buttonFontSize]* 1.4;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_font);
	GtRelease(m_check);
	GtRelease(m_highlightedColor);
	GtRelease(m_color);
	GtSuperDealloc();
}

- (void) setType:(UITableViewCellAccessoryType) type
{
	m_type = type;
	[self setNeedsDisplay];
}


#define ArrowSize 6
#define ArrowThickness 2.5


- (UIImage*) checkMarkImage
{
	static UIImage* s_image = nil;
	if(!s_image)
	{ /*GtRgbColor(171,197,225, 1.0)*/
		s_image = [UIImage imageNamed:@"check.png"];
		s_image = [s_image colorizeImage:[UIColor whiteColor] blendMode:kCGBlendModeLighten];
		s_image = [s_image colorizeImage:GtRgbColor(171,197,225, 1.0) blendMode:kCGBlendModeMultiply]; // TODO: hard coded color from dark them
		GtRetain(s_image);
//		  s_image = [s_image colorizeImage:[UIColor lightGrayColor] blendMode:kCGBlendModeOverlay ];
	}
	
	return s_image;
}

- (void) resizeToAccessorySize
{
	
	switch(m_type)
	{
		case UITableViewCellAccessoryNone:
		break;
	
		case UITableViewCellAccessoryDetailDisclosureButton:
		break;
	
		case UITableViewCellAccessoryDisclosureIndicator:
		self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, CGSizeMake(ArrowSize,ArrowSize*2));
		break;
	
		case UITableViewCellAccessoryCheckmark:
		self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, CGSizeMake(16,18));
		//self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, CGSizeMake(m_checkmarkSize,m_checkmarkSize));
		break;
	}

}


- (void) drawRect:(CGRect) rect
{
	switch(m_type)
	{
		case UITableViewCellAccessoryNone:
		break;
	
		case UITableViewCellAccessoryDetailDisclosureButton:
		break;
	
		case UITableViewCellAccessoryDisclosureIndicator:
		{
			CGContextRef ctx = UIGraphicsGetCurrentContext();

			CGRect frame = self.frame;
			GtColorStruct rgb = self.isHighlighted? m_highlightedColor.colorStruct : m_color.colorStruct;
			CGContextSetRGBStrokeColor(ctx, rgb.red, rgb.green, rgb.blue, 1.0); 
			CGContextSetLineWidth(ctx, ArrowThickness);
			
			CGContextMoveToPoint(ctx, frame.origin.x, frame.origin.y);
			CGContextAddLineToPoint(ctx , GtRectGetRight(frame), GtRectGetBottom(frame) - (frame.size.height * 0.5));
			CGContextAddLineToPoint(ctx , frame.origin.x, GtRectGetBottom(frame));
			CGContextStrokePath(ctx);
		}
		break;
		
		case UITableViewCellAccessoryCheckmark:
		{
			//if(!m_checkMarkImage)
//			  {
//				  m_checkMarkImage = [UIImage
//			  }
//		  
//			  static unichar check = 0x2713;
//			  if(!m_check)
//			  {
//				  m_font = [[UIFont fontWithName:@"ZapfDingbatsITC" size:m_checkmarkSize] retain]; //(self.label.font.pointSize*1.6
//				  m_check = [[NSString stringWithCharacters:&check length:1UL] retain];
//				  
//			  }
			
			[m_color set];
			[[self checkMarkImage] drawInRect:self.frame];
		}
		break;
	}

	[super drawRect:rect];
}

@end
