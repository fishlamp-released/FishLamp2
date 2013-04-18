//
//  ZFBreadCrumbsBar.m
//  FishLamp
//
//  Created by patrickm on 20-11-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#if REFACTOR
#if OSX

#import "ZFBreadCrumbsBar.h"


@implementation ZFBreadCrumbsBar

@synthesize labels = _labels;

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if ( self ) {
		[self setLabels:[NSArray arrayWithObjects:@"Login", @"Destination", @"Options", @"Results", nil]];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_labels release];
    [_tabView release];
    [super dealloc];
}
#endif
					
//	[private]
- (NSBezierPath*)maskInRect:(NSRect)aRect
                     radius:(float) radius
{
	NSBezierPath* path = [NSBezierPath bezierPath];
	
    float minRectSize = MIN(NSWidth(aRect), NSHeight(aRect));
    
	radius = MIN(radius, 0.5f * minRectSize);
	
    NSRect rect = NSInsetRect(aRect, radius, radius);
	
    NSPoint arc = NSMakePoint(NSMinX(rect), NSMinY(rect));
	
    [path appendBezierPathWithArcWithCenter:arc radius:radius startAngle:180.0 endAngle:270.0];
	arc = NSMakePoint(NSMaxX(rect), NSMinY(rect));
	
    [path appendBezierPathWithArcWithCenter:arc radius:radius startAngle:270.0 endAngle:360.0];
	arc = NSMakePoint(NSMaxX(rect), NSMaxY(rect));
	
    [path appendBezierPathWithArcWithCenter:arc radius:radius startAngle:0.0 endAngle:90.0];
	arc = NSMakePoint(NSMinX(rect), NSMaxY(rect));
	
    [path appendBezierPathWithArcWithCenter:arc radius:radius startAngle:90.0 endAngle:180.0];
	[path closePath];
	
	return path;
}

//	[private]
- (NSBezierPath *)arrowHeadInRect:(NSRect)aRect offset:(float)offset
{
	NSBezierPath* path = [NSBezierPath bezierPath];
	
	[path moveToPoint:NSMakePoint(NSMinX(aRect), NSMinY(aRect))];
	[path lineToPoint:NSMakePoint(NSMaxX(aRect), NSMinY(aRect))];
	[path lineToPoint:NSMakePoint(NSMaxX(aRect) + offset, NSMinY(aRect) + aRect.size.height / 2.0)];
	[path lineToPoint:NSMakePoint(NSMaxX(aRect), NSMaxY(aRect))];	
	[path lineToPoint:NSMakePoint(NSMinX(aRect), NSMaxY(aRect))];
	[path lineToPoint:NSMakePoint(NSMinX(aRect) + offset, NSMinY(aRect) + aRect.size.height / 2.0)];
	[path closePath];
	return path;
}

//	[private]
- (int)selectedCrumb
{
	return [_tabView indexOfTabViewItem:[_tabView selectedTabViewItem]];
}

//	[private]
- (NSRect)frameForRange:(NSRange)range inLenght:(int)total
{
	NSRect frame = [self bounds];
	float  unit  = NSWidth(frame) / total;
	return NSMakeRect(roundf(unit * range.location), NSMinX(frame), roundf(unit * range.length), NSHeight(frame));
}

//	[private]
- (NSColor *)textColorForLabel:(int)number
{
	if ( [self selectedCrumb] == number ) {
		return [NSColor whiteColor];
	}
	return [NSColor colorWithCalibratedWhite:0.95 alpha:1.0];
}

//	[private]
- (NSColor *)backgroundColorForLabel:(int)number
{
	if ( [self selectedCrumb] == number ) {
//		return [NSColor colorWithCalibratedRed:204/255.0 green:102/255.0 blue: 11/255.0 alpha:1.0]; // orange
		return [NSColor colorWithCalibratedRed:119/255.0 green:153/255.0 blue:204/255.0 alpha:1.0]; // blue
	}
	return [NSColor lightGrayColor];
}

//	[private]
- (NSDictionary *)attributesForLabel:(int)number
{
	NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
		[self textColorForLabel:number],	NSForegroundColorAttributeName,
		[NSNumber numberWithFloat:0.4],		NSKernAttributeName, nil];
	
	if ( number != [self selectedCrumb] ) {
		NSShadow *shadow = FLAutorelease([NSShadow new]);
		[shadow setShadowOffset:NSMakeSize(1.5, -1.5)];
		[shadow setShadowBlurRadius:1.5];
		
		[attrs setObject:shadow forKey:NSShadowAttributeName];
		[attrs setObject:[SDKFont boldSystemFontOfSize:12] forKey:SDKFontAttributeName];
	} else {
		[attrs setObject:[SDKFont systemFontOfSize:12] forKey:SDKFontAttributeName];
	}
	return attrs;
}

//	[private]
- (NSAttributedString *)attributedStringForLabel:(int)number
{
	NSDictionary *attrs = [self attributesForLabel:number];
	NSString *label = [[self labels] objectAtIndex:number];
	return FLAutorelease([[NSAttributedString alloc] initWithString:label attributes:attrs]);
}

- (void)drawRect:(NSRect)rect
{
	NSBezierPath *outmask = [self maskInRect:NSInsetRect([self bounds], 0.0, 0.0) radius:7.0];
	NSBezierPath *inmask  = [self maskInRect:NSInsetRect([self bounds], 1.0, 1.0) radius:5.0];
	NSBezierPath *inbord  = [self maskInRect:NSInsetRect([self bounds], 0.5, 0.5) radius:5.0];
	
	//	background
	[[NSColor colorWithCalibratedWhite:0.80 alpha:1.0] set];
	[inmask fill];
	[[NSColor colorWithCalibratedWhite:0.75 alpha:1.0] set];
	[inbord stroke];
	
	int total  = [[[self labels] valueForKeyPath:@"@sum.length"] intValue];
	int offset = 0;
	int SPACE  = 5; // simulate separator space around label texts: better alligment
	
	int i, nlabels = [[self labels] count];
	for ( i = 0; i < nlabels; i++ ) {
		NSString *label = [[self labels] objectAtIndex:i];
		NSRect frame = [self frameForRange:NSMakeRange(offset, [label length] + SPACE) inLenght:total + 4*SPACE];
		
		if ( i == [self selectedCrumb] ) {
			NSColor *crumbColor = [self backgroundColorForLabel:i];
			[[NSGraphicsContext currentContext] saveGraphicsState];
			[crumbColor set];
			[NSBezierPath clipRect:frame];
			[outmask fill];
			[[NSGraphicsContext currentContext] restoreGraphicsState];
			
			[[crumbColor highlightWithLevel:0.2] set];
			if ( i != 0 ) {
				[[self arrowHeadInRect:NSMakeRect(NSMinX(frame) - 8, 0, 8, rect.size.height) offset:5] fill];
			}
			if ( i != nlabels - 1 ) {
				[[self arrowHeadInRect:NSMakeRect(NSMaxX(frame) - 8, 0, 8, rect.size.height) offset:5] fill];
			}
		}
		
		NSAttributedString *astr = [self attributedStringForLabel:i];
		[astr drawAtPoint:NSMakePoint(frame.origin.x + (frame.size.width - [astr size].width)/2.0, frame.origin.y + 3)];
		offset += [label length] + SPACE;
	}
}

@end
#endif
#endif