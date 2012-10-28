//
//	FLImageThumbnailBarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/18/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLImageThumbnailBarView.h"
#import "FLImageFrameWidget.h"
#import "FLImageWidget.h"

#define Buffer 1.0f
#define FirstAndLastButtonPadding 20.0f
#define TopBottomPaddingForSelected 10.0f

#define ThumbnailToImageIndex(idx) ((NSUInteger) roundf(((CGFloat) idx) * _indexScale))
#define ImageToThumbnailIndex(idx) ((NSUInteger) roundf(((CGFloat) idx) / _indexScale))


@interface FLThumbnailBarCell : FLImageFrameWidget {
@private
	NSUInteger _index;
}

@property (readwrite, assign, nonatomic) NSUInteger index;

@end

@implementation FLThumbnailBarCell

@synthesize index = _index;

- (id) init
{
	if((self = [super init]))
	{
		self.showFrame = YES;
		self.frameWidth = 2.0f;
		self.contentMode = FLContentModeFill;
		self.imageWidget = [FLImageWidget imageWidgetWithFrame:CGRectZero];
		self.imageWidget.backgroundColor = [UIColor lightGrayColor];
		self.imageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFill;
	}
	
	return self;
}

@end

@implementation FLImageThumbnailBarView

@synthesize delegate = _delegate;
@synthesize enabled = _enabled;

- (void) _initSelf
{
	_thumbnails = [[NSMutableArray alloc] initWithCapacity:50]; // TODO: unhard code this
	self.enabled = YES;
	self.userInteractionEnabled = YES;
	self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	self.autoresizesSubviews = NO;
	self.backgroundColor = [UIColor clearColor];
	
	_selectedThumbnail = [[FLThumbnailBarCell alloc] init];
	_selectedThumbnail.index = 0;
    [self.rootWidget addWidget:_selectedThumbnail];
}

- (id) initWithFrame:(FLRect) frame
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
	FLRelease(_selectedThumbnail);
	FLRelease(_thumbnails);
	FLSuperDealloc();
}

- (BOOL) hasAllThumbnails
{	
	if(!_selectedThumbnail.image /*|| _needsSelectedThumbnail*/)
	{
		return NO;
	}

	for(FLThumbnailBarCell* cell in _thumbnails)
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
	if(!_selectedThumbnail.image /* || _needsSelectedThumbnail*/)
	{
		return _selectedThumbnail.index;
	}

	for(FLThumbnailBarCell* cell in _thumbnails)
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
	NSUInteger scaledIndex = ImageToThumbnailIndex(_selectedThumbnail.index);
	FLThumbnailBarCell* cell =[_thumbnails objectAtIndex:scaledIndex];
	_selectedThumbnail.frame = CGRectIntegral(FLRectCenterRectInRectHorizontally(cell.frame, _selectedThumbnail.frame));

	if(_selectedThumbnail.index == cell.index)
	{
		_selectedThumbnail.image = cell.image;
	}
}

- (void) setThumbnail:(UIImage*) image atIndex:(NSUInteger) atIndex
{
	if(_selectedThumbnail.index == atIndex)
	{
//		_needsSelectedThumbnail = NO;
		_selectedThumbnail.image = image;
	}

	for(FLThumbnailBarCell* cell in _thumbnails)
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
	return _selectedThumbnail.index;
}

- (void) setSelectedThumbnailIndex:(NSUInteger) idx
{
	if(_selectedThumbnail.index != idx)
	{
		_selectedThumbnail.index = idx;
		_selectedThumbnail.image = nil;
		
#if LOG
		FLLog(@"selected index at %d", idx);
#endif
		
		[self _setSelectedThumbnailPosition];
	}
}

- (void) _adjustThumbCellCount:(NSUInteger) thumbcount
{
	if(_thumbnails.count < thumbcount)
	{
		for(NSUInteger i = _thumbnails.count; i < thumbcount; i++)
		{
			FLThumbnailBarCell* cell = [[FLThumbnailBarCell alloc] init];
		    [self.rootWidget addWidget:cell];
            [_thumbnails addObject:cell];
			FLRelease(cell);
		}
	}
	else if(_thumbnails.count > thumbcount)
	{
		for(NSUInteger i = _thumbnails.count-1; i >= thumbcount; i--)
		{
			[_thumbnails removeObjectAtIndex:i];
		}
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	_widgetFrame = CGRectMake(0,0, 22, 18); 
	_thumbCount = [_delegate thumbnailBarViewGetThumbnailCount:self];
	_maxThumbCount = (self.bounds.size.width - FirstAndLastButtonPadding) / _widgetFrame.size.width;

	NSUInteger thumbnailCount = MIN(_maxThumbCount, _thumbCount);
	[self _adjustThumbCellCount:thumbnailCount];
	
	_indexScale = _thumbCount > _maxThumbCount ? ((CGFloat)_thumbCount-1) / ((CGFloat)thumbnailCount-1) : 1.0f; // math needs to be on last index, not count
	 
	_selectedThumbnail.frame = CGRectMake(0,4, _widgetFrame.size.width*2, _widgetFrame.size.height*2);
	_selectedThumbnail.index = [self.delegate thumbnailBarViewGetSelectedThumbnailIndex:self];
	[_selectedThumbnail setNeedsLayout];	 
	
	CGFloat width = _widgetFrame.size.width * thumbnailCount;
	_leftSide = FLRectGetCenter(self.bounds).x;
	_leftSide -= (width / 2.0);
	_leftSide = floorf(_leftSide);
	if(FLFloatMod(_leftSide, 2.0f) == 1.0f) {
		--_leftSide;
	} 
	
	CGFloat left = _leftSide;
	   
	NSUInteger count = 0.0;
	for(FLThumbnailBarCell* view in _thumbnails)
	{
		view.index = ThumbnailToImageIndex(count); 
		
//		FLLog(@"Set image index %d of %d, thumbnail index: %d, converts back to %d, scale: %f", view.index, _thumbCount, count, ImageToThumbnailIndex(view.index), _indexScale);
		
		FLAssert_v(count == ImageToThumbnailIndex(view.index), @"thumbnail indexes not roundtripping");
		
		//ScaledThumbnailIndex(count);
		view.frame = FLRectSetOrigin(_widgetFrame, left, 12.0f);
//		  FLRectCenterRectInRectVertically(self.bounds, FLRectSetLeft(_widgetFrame, left));
		[view setNeedsLayout];
		left = FLRectGetRight(view.frame);
		count++;
	}
	
	[self _setSelectedThumbnailPosition];
	
	[self setNeedsDisplay];
	
}

- (void) drawRect:(FLRect) rect
{
	[super drawRect:rect];
	
//	  CGContextRef context = UIGraphicsGetCurrentContext();
//	  CGContextSaveGState(context);
//		  [[UIColor redColor] setFill];
//		  CGContextFillRect( context , rect );
	
	for(FLThumbnailBarCell* view in _thumbnails)
	{
		if(CGRectIntersectsRect(view.frame, rect))
		{
			[view drawWidget:rect];
		}
	}
	
	if(CGRectIntersectsRect(_selectedThumbnail.frame, rect))
	{
//		  [[UIColor blueColor] setFill];
//		  CGContextFillRect( context , _selectedThumbnail.frame );
		[_selectedThumbnail drawWidget:rect];
	}
	
//	  CGContextRestoreGState(context);
	
}

- (void) _notifySelectedChanged
{
	[_delegate thumbnailBarView:self didChangeSelectedThumbnail:_selectedThumbnail.index];
				
}

- (void) _handleTouch:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled)
	{
		UITouch* touch = [touches anyObject];
		FLPoint pt = [touch locationInView:self];
//		  if([_selectedThumbnail hitTest:pt interactiveCellsOnly:NO])
//		  {
//			  return;
//		  }
		
		for(FLThumbnailBarCell* view in _thumbnails)
		{
			if([view hitTest:pt interactiveCellsOnly:NO])
			{
				if(_selectedThumbnail.index != view.index)
				{
					_selectedThumbnail.index = view.index;
					_selectedThumbnail.image = nil;
	
//					  _selectedThumbnail.frame = FLRectSetLeft(_selectedThumbnail.frame, view.frame.origin.x);
				
					_selectedThumbnail.frame =
						CGRectIntegral(
							FLRectCenterRectInRectHorizontally(view.frame, _selectedThumbnail.frame));
				}
				
				[_delegate thumbnailBarView:self didChangeSelectedThumbnail:_selectedThumbnail.index];
				return;
			}
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled)
	{
		[_delegate thumbnailBarViewTouchesStarted:self];
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
		[_delegate thumbnailBarViewTouchesStopped:self];
	}
}


-(void) touchesEnded: (NSSet *) touches 
		   withEvent: (UIEvent *) event 
{	
	if(self.enabled)
	{
		[_delegate thumbnailBarViewTouchesStopped:self];
	}
}

- (void) selectPrevThumbnail:(id) sender
{
	if(self.enabled)
	{
		[_delegate thumbnailBarViewPreviousButtonPressed:self];
	}
}

- (void) selectNextThumbnail:(id) sender
{
	if(self.enabled)
	{
		[_delegate thumbnailBarViewNextButtonPressed:self];
	}
}

- (void) resetThumbnails
{
	[self setNeedsLayout];
}

@end

@implementation FLThumbnailBarCountView

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = YES;
		self.backgroundColor = [UIColor clearColor];
	
		_view = [[FLRoundRectView alloc] initWithFrame:frame];
		
		_view.borderColor = [UIColor grayColor];
		_view.borderLineWidth = 2.0;
		_view.fillColor = [UIColor blackColor];
		_view.fillAlpha = 0.5;
		
		[self addSubview:_view];
		
		_label = [[UILabel alloc] initWithFrame:frame];
		_label.backgroundColor = [UIColor clearColor];
		_label.textColor = [UIColor whiteColor];
		_label.shadowColor = [UIColor blackColor];
		_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		_label.textAlignment = UITextAlignmentCenter;
		_label.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		
		[self addSubview:_label];
	}
	
	return self;
}

- (void) updateCount:(NSUInteger) count total:(NSUInteger) total
{
	_label.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), count, total];
//	  [_label sizeToFitText];
//	  [self setNeedsLayout];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	_view.frame = self.bounds;
	
//	  _label.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, _label.frame);
}

- (void) dealloc
{
	FLRelease(_label);
	FLRelease(_view);
	FLSuperDealloc();
}

@end
