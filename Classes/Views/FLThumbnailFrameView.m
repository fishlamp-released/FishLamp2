//
//	FLThumbnailFrameView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLThumbnailFrameView.h"
#import "FLImage+Resize.h"

CGFloat kFrameSize = 0; //5.0f

@implementation FLThumbnailFrameView

@synthesize thumbnailButton = _thumbnailButton;
@synthesize foregroundThumbnail = _foregroundThumbnail;
@synthesize backgroundThumbnail = _backgroundThumbnail;
@synthesize maxSize = _maxSize;

+ (void) initialize {
	if(kFrameSize == 0.0f) {
		kFrameSize = DeviceIsPad() ? 4.0f : 2.0f;
	}
}


- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.showFrame = YES;
		
		_maxSize = FLSizeMake(120,120);
		
		_thumbnailButton = [[FLThumbnailButton alloc] initWithFrame:CGRectZero];
		_thumbnailButton.autoresizingMask = UIViewAutoresizingNone;
		_thumbnailButton.autoresizesSubviews = NO;
		[self addSubview:_thumbnailButton];

//		_thumbnailButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//		  _thumbnailButton.layer.shadowOpacity = 0.5;
//		  _thumbnailButton.layer.shadowRadius = 5.0;
//		  _thumbnailButton.layer.shadowOffset = FLSizeMake(0,3);
//		  _thumbnailButton.clipsToBounds = NO;
	}
	return self;
}

- (void) drawRect:(FLRect) rect
{
	[super drawRect:rect];
	
	if(self.showFrame) // SyncCGContextOriginWithPort
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		[[UIColor blackColor] setStroke];
		[[UIColor whiteColor] setFill];
		
		FLRect thumbFrame = _thumbnailButton.frame;
		thumbFrame.size.width += (kFrameSize*2);
		thumbFrame.size.height += (kFrameSize*2);
		thumbFrame.origin.x -= kFrameSize;
		thumbFrame.origin.y -= kFrameSize;
 //	  thumbFrame = FLRectMove(thumbFrame, rect.origin.x, rect.origin.y);
		
		if(_frameViewFlags.showStack)
		{
			FLRect stackFrame = thumbFrame;
			stackFrame.origin.x += kFrameSize;
			stackFrame.origin.y -= kFrameSize;
			CGContextClearRect( context , stackFrame );
			CGContextFillRect( context , stackFrame );
			CGContextStrokeRectWithWidth( context , stackFrame , 1.0 );
		}
		
		CGContextClearRect( context , thumbFrame );
		CGContextFillRect( context , thumbFrame );
		CGContextStrokeRectWithWidth( context , thumbFrame , 1.0 );
		
		
		[_thumbnailButton drawRect:thumbFrame];
		
		[self.backgroundColor setFill];
	}
}

- (void)addTarget:(id)target action:(SEL)action
{
	if(_thumbnailButton)
	{
		[_thumbnailButton addTarget:target action:action];
	}
}

- (BOOL) showFrame
{
	return _frameViewFlags.showFrame;
}

- (void) setShowFrame:(BOOL) showFrame
{
	_frameViewFlags.showFrame = showFrame;
   [self setNeedsLayout];
}

- (BOOL) showStack
{
	return _frameViewFlags.showStack;
}

- (void) setShowStack:(BOOL) showStack
{
	_frameViewFlags.showStack = showStack;
   [self setNeedsLayout];
}

- (void) dealloc
{
	mrc_release_(_thumbnailButton);
	mrc_release_(_backgroundThumbnail);
	mrc_release_(_foregroundThumbnail);
	mrc_release_(_scaledForegroundThumbnail);
	mrc_super_dealloc_();
}

- (BOOL) ownsSenderOfEvent:(id) sender
{
	return sender != nil && _thumbnailButton == sender;
}

- (FLRect) thumbnailImageFrame
{
	return _thumbnailButton ? _thumbnailButton.frame : CGRectZero;
}

- (void) clearThumbnails
{	
	FLReleaseWithNil_(_backgroundThumbnail);
	FLReleaseWithNil_(_foregroundThumbnail);

	if(_scaledForegroundThumbnail)
	{
		[_scaledForegroundThumbnail removeFromSuperview];
		FLReleaseWithNil_(_scaledForegroundThumbnail);
	}

	[_thumbnailButton clearImages];
}

- (BOOL) showBothThumbnails {
	return _frameViewFlags.showBothThumbnails;
}

- (void) setShowBothThumbnails:(BOOL) showBoth {
	_frameViewFlags.showBothThumbnails = showBoth;
	[self setNeedsLayout];
}

- (void) setShowBothThumbnails:(BOOL) showBoth 
	foregroundThumbnailScale:(CGFloat) scale 
	positionOffset:(FLPoint) offset {
	
    self.showBothThumbnails = showBoth;
	_foregoundThumbnailScale = scale;
	_scaledForegroundThumbnailOffset = offset;
}

- (void) _updateThumbnailFrame:(UIImage*) image {
	
    FLAssert_v(_maxSize.width != 0.0f && _maxSize.height != 0.0f, @"invalid max size");
	
    FLRect thumbnailFrame =[image proportionalBoundsWithMaxSize:_maxSize];
	FLPoint thumbOrigin = {0.0f, 0.0f};
	FLSize frameSize = {0,0};
	
	if(_frameViewFlags.showFrame)
	{
		thumbOrigin.x += kFrameSize;
		thumbOrigin.y += kFrameSize;
		frameSize.width += (kFrameSize*2);
		frameSize.height += (kFrameSize*2);
	}
	if(_frameViewFlags.showStack)
	{
		thumbOrigin.x += kFrameSize;
		thumbOrigin.y += kFrameSize;
		frameSize.width += (kFrameSize*2);
		frameSize.height += (kFrameSize*2);
	}
	thumbnailFrame.origin = thumbOrigin;
	
	FLSize thumbSize = thumbnailFrame.size;
	thumbSize.width -=	 frameSize.width;
	thumbSize.height -=	  frameSize.height;
	thumbnailFrame.size = thumbSize;
	
	frameSize.width += thumbSize.width;
	frameSize.height += thumbSize.height;
	
	self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, frameSize);
	_thumbnailButton.frameOptimizedForSize = thumbnailFrame;
 }

//- (void) _adjustViewSizeWithImage:(UIImage*) image
//{
//	  FLSize size = FLSizeMake(FLRectGetRight(_thumbnailButton.frame), FLRectGetBottom(_thumbnailButton.frame));
//	  size.width += kFrameSize + (_frameViewFlags.showStack ? kFrameSize : 0.0) + 2.0f;
//	  size.height += kFrameSize + (_frameViewFlags.showStack ? kFrameSize : 0.0) + 2.0f; 
//	  if([self setFrameIfChanged:FLRectSetSizeWithSize(self.frame, size)])
//	  {
//		  [self setNeedsLayout];
//	  }
//}

//- (void) updateLayout
//{
//	if(_foregroundThumbnail && !_frameViewFlags.showBothThumbnails)
//	  {
//		_thumbnailButton.foregroundImage = _foregroundThumbnail;
//	  
//		  [self _updateThumbnailFrame:_foregroundThumbnail];
//		  [self _adjustViewSizeWithImage:_foregroundThumbnail];   
//	  }
//	  else if(_backgroundThumbnail)
//	  {
//		  _thumbnailButton.backgroundImage = _backgroundThumbnail;
//
//		  [self _updateThumbnailFrame:_backgroundThumbnail];	
//		  [self _adjustViewSizeWithImage:_backgroundThumbnail];   
//	  }
//	  
//	  [self setNeedsDisplay];
//}

- (void) _updateLayout
{
	if(_foregroundThumbnail && !_frameViewFlags.showBothThumbnails)
	{
		_thumbnailButton.foregroundImage = _foregroundThumbnail;
	
		[self _updateThumbnailFrame:_foregroundThumbnail];
	}
	else if(_foregroundThumbnail && _frameViewFlags.showBothThumbnails)
	{
		_thumbnailButton.foregroundImage = nil;
		[self _updateThumbnailFrame:_backgroundThumbnail];
	
	   if(!_scaledForegroundThumbnail)
		{
			_scaledForegroundThumbnail = [[UIImageView alloc] initWithFrame:CGRectZero];
			_scaledForegroundThumbnail.contentMode = UIViewContentModeScaleAspectFit;
			[_thumbnailButton addSubview:_scaledForegroundThumbnail];
		}
		_scaledForegroundThumbnail.image = _foregroundThumbnail;
		FLRect frame = FLRectSetSizeWithSize(_scaledForegroundThumbnail.frame, _foregroundThumbnail.size);
		frame = FLRectFitInRectInRectProportionally(_thumbnailButton.bounds, frame);
		frame = FLRectScale(frame, _foregoundThumbnailScale);
		frame = FLRectCenterRectInRect(_thumbnailButton.bounds, frame);
		frame = FLRectMoveWithPoint(frame, _scaledForegroundThumbnailOffset);
		
		_scaledForegroundThumbnail.newFrame = frame;
	}
	else if(_backgroundThumbnail)
	{
		_thumbnailButton.foregroundImage = nil;
		_thumbnailButton.backgroundImage = _backgroundThumbnail;

		[self _updateThumbnailFrame:_backgroundThumbnail];	  
	}
	
	if(!_frameViewFlags.showBothThumbnails && _scaledForegroundThumbnail)
	{
		[_scaledForegroundThumbnail removeFromSuperview];
		FLReleaseWithNil_(_scaledForegroundThumbnail);
	}	 
}

- (void) setMaxSize:(FLSize) size
{
	_maxSize = size;
	self.frame = CGRectMake(0,0,_maxSize.width,_maxSize.height);
	[self _updateLayout];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	[self _updateLayout];
	[self setNeedsDisplay];
}

- (void) setBackgroundThumbnail:(UIImage*) image
{
	FLRetainObject_(_backgroundThumbnail, image);
	[self _updateLayout];
	[self setNeedsLayout];	
}

- (void) setForegroundThumbnail:(UIImage*) image
{
	FLRetainObject_(_foregroundThumbnail, image);
	[self _updateLayout];
	[self setNeedsLayout];	
	
}

@end

