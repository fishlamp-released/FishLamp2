//
//	GtThumbnailFrameView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThumbnailFrameView.h"
#import "UIImage+Resize.h"

CGFloat kFrameSize = 0; //5.0f

@implementation GtThumbnailFrameView

@synthesize thumbnailButton = m_thumbnailButton;
@synthesize foregroundThumbnail = m_foregroundThumbnail;
@synthesize backgroundThumbnail = m_backgroundThumbnail;
@synthesize maxSize = m_maxSize;

+ (void) initialize
{
	if(kFrameSize == 0)
	{
		kFrameSize = DeviceIsPad() ? 4.0f : 2.0f;
	}
}


- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.showFrame = YES;
		
		m_maxSize = CGSizeMake(120,120);
		
		m_thumbnailButton = [[GtThumbnailButton alloc] initWithFrame:CGRectZero];
		m_thumbnailButton.autoresizingMask = UIViewAutoresizingNone;
		m_thumbnailButton.autoresizesSubviews = NO;
		[self addSubview:m_thumbnailButton];

//		m_thumbnailButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//		  m_thumbnailButton.layer.shadowOpacity = 0.5;
//		  m_thumbnailButton.layer.shadowRadius = 5.0;
//		  m_thumbnailButton.layer.shadowOffset = CGSizeMake(0,3);
//		  m_thumbnailButton.clipsToBounds = NO;
	}
	return self;
}

- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	
	if(self.showFrame) // SyncCGContextOriginWithPort
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		[[UIColor blackColor] setStroke];
		[[UIColor whiteColor] setFill];
		
		CGRect thumbFrame = m_thumbnailButton.frame;
		thumbFrame.size.width += (kFrameSize*2);
		thumbFrame.size.height += (kFrameSize*2);
		thumbFrame.origin.x -= kFrameSize;
		thumbFrame.origin.y -= kFrameSize;
 //	  thumbFrame = GtRectMove(thumbFrame, rect.origin.x, rect.origin.y);
		
		if(m_frameViewFlags.showStack)
		{
			CGRect stackFrame = thumbFrame;
			stackFrame.origin.x += kFrameSize;
			stackFrame.origin.y -= kFrameSize;
			CGContextClearRect( context , stackFrame );
			CGContextFillRect( context , stackFrame );
			CGContextStrokeRectWithWidth( context , stackFrame , 1.0 );
		}
		
		CGContextClearRect( context , thumbFrame );
		CGContextFillRect( context , thumbFrame );
		CGContextStrokeRectWithWidth( context , thumbFrame , 1.0 );
		
		
		[m_thumbnailButton drawRect:thumbFrame];
		
		[self.backgroundColor setFill];
	}
}

- (void)addTarget:(id)target action:(SEL)action
{
	if(m_thumbnailButton)
	{
		[m_thumbnailButton addTarget:target action:action];
	}
}

- (BOOL) showFrame
{
	return m_frameViewFlags.showFrame;
}

- (void) setShowFrame:(BOOL) showFrame
{
	m_frameViewFlags.showFrame = showFrame;
   [self setNeedsLayout];
}

- (BOOL) showStack
{
	return m_frameViewFlags.showStack;
}

- (void) setShowStack:(BOOL) showStack
{
	m_frameViewFlags.showStack = showStack;
   [self setNeedsLayout];
}

- (void) dealloc
{
	GtRelease(m_thumbnailButton);
	GtRelease(m_backgroundThumbnail);
	GtRelease(m_foregroundThumbnail);
	GtRelease(m_scaledForegroundThumbnail);
	GtSuperDealloc();
}

- (BOOL) ownsSenderOfEvent:(id) sender
{
	return sender != nil && m_thumbnailButton == sender;
}

- (CGRect) thumbnailImageFrame
{
	return m_thumbnailButton ? m_thumbnailButton.frame : CGRectZero;
}

- (void) clearThumbnails
{	
	GtReleaseWithNil(m_backgroundThumbnail);
	GtReleaseWithNil(m_foregroundThumbnail);

	if(m_scaledForegroundThumbnail)
	{
		[m_scaledForegroundThumbnail removeFromSuperview];
		GtReleaseWithNil(m_scaledForegroundThumbnail);
	}

	[m_thumbnailButton clearImages];
}

- (BOOL) showBothThumbnails
{
	return m_frameViewFlags.showBothThumbnails;
}

- (void) setShowBothThumbnails:(BOOL) showBoth
{
	m_frameViewFlags.showBothThumbnails = showBoth;
	[self setNeedsLayout];
}

- (void) setShowBothThumbnails:(BOOL) showBoth 
	foregroundThumbnailScale:(CGFloat) scale 
	positionOffset:(CGPoint) offset
{
	self.showBothThumbnails = showBoth;
	m_foregoundThumbnailScale = scale;
	m_scaledForegroundThumbnailOffset = offset;
}

- (void) _updateThumbnailFrame:(UIImage*) image
{
	GtAssert(m_maxSize.width != 0 && m_maxSize.height != 0, @"invalid max size");
	CGRect thumbnailFrame =[image proportionalBoundsWithMaxSize:m_maxSize];
	CGPoint thumbOrigin = {0.0f, 0.0f};
	CGSize frameSize = {0,0};
	
	if(m_frameViewFlags.showFrame)
	{
		thumbOrigin.x += kFrameSize;
		thumbOrigin.y += kFrameSize;
		frameSize.width += (kFrameSize*2);
		frameSize.height += (kFrameSize*2);
	}
	if(m_frameViewFlags.showStack)
	{
		thumbOrigin.x += kFrameSize;
		thumbOrigin.y += kFrameSize;
		frameSize.width += (kFrameSize*2);
		frameSize.height += (kFrameSize*2);
	}
	thumbnailFrame.origin = thumbOrigin;
	
	CGSize thumbSize = thumbnailFrame.size;
	thumbSize.width -=	 frameSize.width;
	thumbSize.height -=	  frameSize.height;
	thumbnailFrame.size = thumbSize;
	
	frameSize.width += thumbSize.width;
	frameSize.height += thumbSize.height;
	
	self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, frameSize);
	m_thumbnailButton.frameOptimizedForSize = thumbnailFrame;
 }

//- (void) _adjustViewSizeWithImage:(UIImage*) image
//{
//	  CGSize size = CGSizeMake(GtRectGetRight(m_thumbnailButton.frame), GtRectGetBottom(m_thumbnailButton.frame));
//	  size.width += kFrameSize + (m_frameViewFlags.showStack ? kFrameSize : 0.0) + 2.0f;
//	  size.height += kFrameSize + (m_frameViewFlags.showStack ? kFrameSize : 0.0) + 2.0f; 
//	  if([self setFrameIfChanged:GtRectSetSizeWithSize(self.frame, size)])
//	  {
//		  [self setNeedsLayout];
//	  }
//}

//- (void) updateLayout
//{
//	if(m_foregroundThumbnail && !m_frameViewFlags.showBothThumbnails)
//	  {
//		m_thumbnailButton.foregroundImage = m_foregroundThumbnail;
//	  
//		  [self _updateThumbnailFrame:m_foregroundThumbnail];
//		  [self _adjustViewSizeWithImage:m_foregroundThumbnail];   
//	  }
//	  else if(m_backgroundThumbnail)
//	  {
//		  m_thumbnailButton.backgroundImage = m_backgroundThumbnail;
//
//		  [self _updateThumbnailFrame:m_backgroundThumbnail];	
//		  [self _adjustViewSizeWithImage:m_backgroundThumbnail];   
//	  }
//	  
//	  [self setNeedsDisplay];
//}

- (void) _updateLayout
{
	if(m_foregroundThumbnail && !m_frameViewFlags.showBothThumbnails)
	{
		m_thumbnailButton.foregroundImage = m_foregroundThumbnail;
	
		[self _updateThumbnailFrame:m_foregroundThumbnail];
	}
	else if(m_foregroundThumbnail && m_frameViewFlags.showBothThumbnails)
	{
		m_thumbnailButton.foregroundImage = nil;
		[self _updateThumbnailFrame:m_backgroundThumbnail];
	
	   if(!m_scaledForegroundThumbnail)
		{
			m_scaledForegroundThumbnail = [[UIImageView alloc] initWithFrame:CGRectZero];
			m_scaledForegroundThumbnail.contentMode = UIViewContentModeScaleAspectFit;
			[m_thumbnailButton addSubview:m_scaledForegroundThumbnail];
		}
		m_scaledForegroundThumbnail.image = m_foregroundThumbnail;
		CGRect frame = GtRectSetSizeWithSize(m_scaledForegroundThumbnail.frame, m_foregroundThumbnail.size);
		frame = GtRectFitInRectInRectProportionally(m_thumbnailButton.bounds, frame);
		frame = GtRectScale(frame, m_foregoundThumbnailScale);
		frame = GtRectCenterRectInRect(m_thumbnailButton.bounds, frame);
		frame = GtRectMoveWithPoint(frame, m_scaledForegroundThumbnailOffset);
		
		m_scaledForegroundThumbnail.newFrame = frame;
	}
	else if(m_backgroundThumbnail)
	{
		m_thumbnailButton.foregroundImage = nil;
		m_thumbnailButton.backgroundImage = m_backgroundThumbnail;

		[self _updateThumbnailFrame:m_backgroundThumbnail];	  
	}
	
	if(!m_frameViewFlags.showBothThumbnails && m_scaledForegroundThumbnail)
	{
		[m_scaledForegroundThumbnail removeFromSuperview];
		GtReleaseWithNil(m_scaledForegroundThumbnail);
	}	 
}

- (void) setMaxSize:(CGSize) size
{
	m_maxSize = size;
	self.frame = CGRectMake(0,0,m_maxSize.width,m_maxSize.height);
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
	GtAssignObject(m_backgroundThumbnail, image);
	[self _updateLayout];
	[self setNeedsLayout];	
}

- (void) setForegroundThumbnail:(UIImage*) image
{
	GtAssignObject(m_foregroundThumbnail, image);
	[self _updateLayout];
	[self setNeedsLayout];	
	
}

@end

