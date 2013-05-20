//
//	GtImageThumbnailBarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/18/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageThumbnailBarView.h"
#import "GtImageFrameWidget.h"
#import "GtImageWidget.h"

#define Buffer 1.0f
#define FirstAndLastButtonPadding 20.0f
#define TopBottomPaddingForSelected 10.0f

#define ThumbnailToImageIndex(idx) ((NSUInteger) roundf(((CGFloat) idx) * m_indexScale))
#define ImageToThumbnailIndex(idx) ((NSUInteger) roundf(((CGFloat) idx) / m_indexScale))


@interface GtThumbnailBarCell : GtImageFrameWidget {
@private
	NSUInteger m_index;
}

@property (readwrite, assign, nonatomic) NSUInteger index;

@end

@implementation GtThumbnailBarCell

@synthesize index = m_index;

- (id) init
{
	if((self = [super init]))
	{
		self.showFrame = YES;
		self.frameWidth = 2.0f;
		self.contentMode = GtWidgetContentModeScaleAspectFill;
		self.imageWidget = [GtImageWidget imageWidgetWithFrame:CGRectZero];
		self.imageWidget.backgroundColor = [UIColor lightGrayColor];
		self.imageWidget.contentMode = GtWidgetContentModeScaleAspectFill;
	}
	
	return self;
}

@end

@implementation GtImageThumbnailBarView

@synthesize delegate = m_delegate;
@synthesize enabled = m_enabled;

- (void) _initSelf
{
	m_thumbnails = [[NSMutableArray alloc] initWithCapacity:50]; // TODO: unhard code this
	self.enabled = YES;
	self.userInteractionEnabled = YES;
	self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	self.autoresizesSubviews = NO;
	self.backgroundColor = [UIColor clearColor];
	
	m_selectedThumbnail = [[GtThumbnailBarCell alloc] init];
	m_selectedThumbnail.index = 0;
    [self addWidget:m_selectedThumbnail];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:CGRectZero]))
	{
		[self _initSelf];
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		[self _initSelf];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_selectedThumbnail);
	GtRelease(m_thumbnails);
	GtSuperDealloc();
}

- (BOOL) hasAllThumbnails
{	
	if(!m_selectedThumbnail.image /*|| m_needsSelectedThumbnail*/)
	{
		return NO;
	}

	for(GtThumbnailBarCell* cell in m_thumbnails)
	{
		if(cell.image == nil)
		{
			return NO;
		}
	}
	
	return YES;
}

- (NSInteger) nextThumbnailIndex
{
	if(!m_selectedThumbnail.image /* || m_needsSelectedThumbnail*/)
	{
		return m_selectedThumbnail.index;
	}

	for(GtThumbnailBarCell* cell in m_thumbnails)
	{		
		if(!cell.image)
		{
			return (NSInteger) cell.index;
		}
	}
	
	return NSNotFound;
}

- (void) _setSelectedThumbnailPosition
{
	NSUInteger scaledIndex = ImageToThumbnailIndex(m_selectedThumbnail.index);
	GtThumbnailBarCell* cell =[m_thumbnails objectAtIndex:scaledIndex];
	m_selectedThumbnail.frame = CGRectIntegral(GtRectCenterRectInRectHorizontally(cell.frame, m_selectedThumbnail.frame));

	if(m_selectedThumbnail.index == cell.index)
	{
		m_selectedThumbnail.image = cell.image;
	}
}

- (void) setThumbnail:(UIImage*) image atIndex:(NSUInteger) atIndex
{
	if(m_selectedThumbnail.index == atIndex)
	{
//		m_needsSelectedThumbnail = NO;
		m_selectedThumbnail.image = image;
	}

	for(GtThumbnailBarCell* cell in m_thumbnails)
	{
		if(cell.index == atIndex)
		{
			cell.image = image;
			break;
		}
		if(cell.index > atIndex)
		{
			break;
		}
	}
}

- (NSUInteger) selectedThumbnailIndex
{
	return m_selectedThumbnail.index;
}

- (void) setSelectedThumbnailIndex:(NSUInteger) idx
{
	if(m_selectedThumbnail.index != idx)
	{
		m_selectedThumbnail.index = idx;
		m_selectedThumbnail.image = nil;
		
#if LOG
		GtLog(@"selected index at %d", idx);
#endif
		
		[self _setSelectedThumbnailPosition];
	}
}

- (void) _adjustThumbCellCount:(NSUInteger) thumbcount
{
	if(m_thumbnails.count < thumbcount)
	{
		for(NSUInteger i = m_thumbnails.count; i < thumbcount; i++)
		{
			GtThumbnailBarCell* cell = [[GtThumbnailBarCell alloc] init];
		    [self addWidget:cell];
            [m_thumbnails addObject:cell];
			GtRelease(cell);
		}
	}
	else if(m_thumbnails.count > thumbcount)
	{
		for(NSUInteger i = m_thumbnails.count-1; i >= thumbcount; i--)
		{
			[m_thumbnails removeObjectAtIndex:i];
		}
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	m_widgetFrame = CGRectMake(0,0, 22, 18); 
	m_thumbCount = [m_delegate thumbnailBarViewGetThumbnailCount:self];
	m_maxThumbCount = (self.bounds.size.width - FirstAndLastButtonPadding) / m_widgetFrame.size.width;

	NSUInteger thumbnailCount = MIN(m_maxThumbCount, m_thumbCount);
	[self _adjustThumbCellCount:thumbnailCount];
	
	m_indexScale = m_thumbCount > m_maxThumbCount ? ((CGFloat)m_thumbCount-1) / ((CGFloat)thumbnailCount-1) : 1.0f; // math needs to be on last index, not count
	 
	m_selectedThumbnail.frame = CGRectMake(0,4, m_widgetFrame.size.width*2, m_widgetFrame.size.height*2);
	m_selectedThumbnail.index = [self.delegate thumbnailBarViewGetSelectedThumbnailIndex:self];
	[m_selectedThumbnail setNeedsLayout];	 
	
	CGFloat width = m_widgetFrame.size.width * thumbnailCount;
	m_leftSide = GtRectGetCenter(self.bounds).x;
	m_leftSide -= (width / 2.0);
	m_leftSide = floorf(m_leftSide);
	if(fmodf(m_leftSide, 2.0f) == 1.0f)
	{
		--m_leftSide;
	} 
	
	CGFloat left = m_leftSide;
	   
	NSUInteger count = 0.0;
	for(GtThumbnailBarCell* view in m_thumbnails)
	{
		view.index = ThumbnailToImageIndex(count); 
		
//		GtLog(@"Set image index %d of %d, thumbnail index: %d, converts back to %d, scale: %f", view.index, m_thumbCount, count, ImageToThumbnailIndex(view.index), m_indexScale);
		
		GtAssert(count == ImageToThumbnailIndex(view.index), @"thumbnail indexes not roundtripping");
		
		//ScaledThumbnailIndex(count);
		view.frame = GtRectSetOrigin(m_widgetFrame, left, 12.0f);
//		  GtRectCenterRectInRectVertically(self.bounds, GtRectSetLeft(m_widgetFrame, left));
		[view setNeedsLayout];
		left = GtRectGetRight(view.frame);
		count++;
	}
	
	[self _setSelectedThumbnailPosition];
	
	[self setNeedsDisplay];
	
}

- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	
//	  CGContextRef context = UIGraphicsGetCurrentContext();
//	  CGContextSaveGState(context);
//		  [[UIColor redColor] setFill];
//		  CGContextFillRect( context , rect );
	
	for(GtThumbnailBarCell* view in m_thumbnails)
	{
		if(CGRectIntersectsRect(view.frame, rect))
		{
			[view drawInRect:rect];
		}
	}
	
	if(CGRectIntersectsRect(m_selectedThumbnail.frame, rect))
	{
//		  [[UIColor blueColor] setFill];
//		  CGContextFillRect( context , m_selectedThumbnail.frame );
		[m_selectedThumbnail drawInRect:rect];
	}
	
//	  CGContextRestoreGState(context);
	
}

- (void) _notifySelectedChanged
{
	[m_delegate thumbnailBarView:self didChangeSelectedThumbnail:m_selectedThumbnail.index];
				
}

- (void) _handleTouch:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled)
	{
		UITouch* touch = [touches anyObject];
		CGPoint pt = [touch locationInView:self];
//		  if([m_selectedThumbnail hitTest:pt interactiveCellsOnly:NO])
//		  {
//			  return;
//		  }
		
		for(GtThumbnailBarCell* view in m_thumbnails)
		{
			if([view hitTest:pt interactiveCellsOnly:NO])
			{
				if(m_selectedThumbnail.index != view.index)
				{
					m_selectedThumbnail.index = view.index;
					m_selectedThumbnail.image = nil;
	
//					  m_selectedThumbnail.frame = GtRectSetLeft(m_selectedThumbnail.frame, view.frame.origin.x);
				
					m_selectedThumbnail.frame =
						CGRectIntegral(
							GtRectCenterRectInRectHorizontally(view.frame, m_selectedThumbnail.frame));
				}
				
				[m_delegate thumbnailBarView:self didChangeSelectedThumbnail:m_selectedThumbnail.index];
				return;
			}
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled)
	{
		[m_delegate thumbnailBarViewTouchesStarted:self];
	}

//	  [super touchesBegan:touches withEvent:event];
	[self _handleTouch:touches withEvent:event];
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
//	  [super touchesMoved:touches withEvent:event];
	[self _handleTouch:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled)
	{
		[m_delegate thumbnailBarViewTouchesStopped:self];
	}
}


-(void) touchesEnded: (NSSet *) touches 
		   withEvent: (UIEvent *) event 
{	
	if(self.enabled)
	{
		[m_delegate thumbnailBarViewTouchesStopped:self];
	}
}

- (void) selectPrevThumbnail:(id) sender
{
	if(self.enabled)
	{
		[m_delegate thumbnailBarViewPreviousButtonPressed:self];
	}
}

- (void) selectNextThumbnail:(id) sender
{
	if(self.enabled)
	{
		[m_delegate thumbnailBarViewNextButtonPressed:self];
	}
}

- (void) resetThumbnails
{
	[self setNeedsLayout];
}

@end

@implementation GtThumbnailBarCountView

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = YES;
		self.backgroundColor = [UIColor clearColor];
	
		m_view = [[GtRoundRectView alloc] initWithFrame:frame];
		
		m_view.borderColor = [UIColor grayColor];
		m_view.borderLineWidth = 2.0;
		m_view.fillColor = [UIColor blackColor];
		m_view.fillAlpha = 0.5;
		
		[self addSubview:m_view];
		
		m_label = [[UILabel alloc] initWithFrame:frame];
		m_label.backgroundColor = [UIColor clearColor];
		m_label.textColor = [UIColor whiteColor];
		m_label.shadowColor = [UIColor blackColor];
		m_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		m_label.textAlignment = UITextAlignmentCenter;
		m_label.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		
		[self addSubview:m_label];
	}
	
	return self;
}

- (void) updateCount:(NSUInteger) count total:(NSUInteger) total
{
	m_label.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), count, total];
//	  [m_label sizeToFitText];
//	  [self setNeedsLayout];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	m_view.frame = self.bounds;
	
//	  m_label.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, m_label.frame);
}

- (void) dealloc
{
	GtRelease(m_label);
	GtRelease(m_view);
	GtSuperDealloc();
}

@end
