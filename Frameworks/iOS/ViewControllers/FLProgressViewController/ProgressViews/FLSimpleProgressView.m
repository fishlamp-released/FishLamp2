//
//  FLSimpleProgressView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimpleProgressView.h"
#import "FLGradientView.h"
#import "FLGradientWidget.h"
#import "FLRoundRectWidget.h"

#define kHeight 44
#define kWidth 128

@implementation FLSimpleProgressView

@synthesize minSize = _minSize;
@synthesize textLabel = _textLabel;
@synthesize spinner = _spinner;

- (id)initWithFrame:(CGRect)frame {
    if(CGRectEqualToRect(CGRectZero, frame)) {
        frame = CGRectMake(0,0,kWidth, kHeight);
    }

    self = [super initWithFrame:frame];
    if (self) {
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
//        self.layer.shadowColor = [UIColor grayColor].CGColor;
//        self.layer.shadowOpacity = 0.5;
//        self.layer.shadowRadius = 20.0;
//        self.layer.shadowOffset = CGSizeMake(0,0);
//        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = 1.0f;
//        self.layer.borderWidth = 1.0;
//        self.layer.borderColor = [UIColor darkGrayColor].CGColor;

        FLRoundRectWidget* roundRect = [FLRoundRectWidget widgetWithFrame:self.bounds];
        roundRect.contentMode = FLRectLayoutFill;
        roundRect.cornerRadius = 8.0;
        [self addWidget:roundRect];
        
        FLGradientWidget* widget = [FLGradientWidget widgetWithFrame:self.bounds];
        widget.contentMode = FLRectLayoutFill;
        [roundRect addWidget:widget];
        [widget setColorRange:[FLColorRange lightLightGrayGradientColorRange] forControlState:UIControlStateNormal];
                            
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 18)];
        _textLabel.textColor = [UIColor gray10Color];
        _textLabel.shadowColor = [UIColor whiteColor];
        _textLabel.shadowOffset = CGSizeMake(0,1);
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = UITextAlignmentLeft;
        _textLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
        _textLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
        _textLabel.lineBreakMode = UILineBreakModeClip;
        [self addSubview:_textLabel];	  

		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_spinner startAnimating];
		_spinner.frame = CGRectMake(10,0,20,20);
		_spinner.autoresizingMask = UIViewAutoresizingNone;
        _spinner.hidesWhenStopped = NO;
	    [_spinner startAnimating];
        [self addSubview:_spinner];
        
        _statusMessage = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 18)];
        _statusMessage.textColor = [UIColor gray10Color];
        _statusMessage.shadowColor = [UIColor whiteColor];
        _statusMessage.shadowOffset = CGSizeMake(0,1);
        _statusMessage.backgroundColor = [UIColor clearColor];
        _statusMessage.textAlignment = UITextAlignmentCenter;
        _statusMessage.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]]; 
        _statusMessage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
        _statusMessage.lineBreakMode = UILineBreakModeClip;
        _statusMessage.hidden = YES;
        [self addSubview:_statusMessage];	  
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_textLabel);
    FLRelease(_spinner);
    FLSuperDealloc();
}
#endif

- (void) layoutProgressViews {

    CGRect topRect = CGRectMake(0,0,self.bounds.size.width, kHeight);

    CGRect titleRect = CGRectZero;
    titleRect.origin.x = FLRectGetRight(_spinner.frame) + 10.0f;
    titleRect.size.height = 18;
    titleRect.size.width = self.bounds.size.width - titleRect.origin.x;
    
    titleRect = FLRectCenterRectInRectVertically(topRect, titleRect);
    _textLabel.frameOptimizedForLocation = titleRect;
    
    _spinner.frameOptimizedForLocation = FLRectCenterRectInRectVertically(topRect, _spinner.frame);
    _statusMessage.frame = FLRectSetTop(topRect, topRect.size.height);
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self layoutProgressViews];
}

- (void) setTitle:(NSString*) title {
    _textLabel.text = title;
    [self setNeedsLayout];
}

- (NSString*) title {
    return _textLabel.text;
}

- (CGSize)sizeThatFits:(CGSize) inSize {
    CGSize size = [_textLabel sizeThatFitsText];
    CGSize outSize = self.bounds.size;
    outSize.height = MAX(_minSize.height, kHeight);
    outSize.width = MAX(_minSize.width, 100.0f + size.width + 20.0f);
    return outSize;
}

- (void)animationDidStart:(CAAnimation *)anim {
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _statusMessage.hidden = NO;
}


- (void) showStatusMessage:(NSString*) string 
                 animated:(BOOL) animated {

    if(_statusMessage.isHidden) {
        
        self.frame = FLRectSetHeight(self.frame, kHeight * 2);
       
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size.height"];
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = 0.3f;
        animation.values = [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:(kHeight * 2) * 0.6f],
                                   [NSNumber numberWithFloat:(kHeight * 2) * 1.1f],
                                   [NSNumber numberWithFloat:(kHeight * 2) * 0.9f],
                                   [NSNumber numberWithFloat:(kHeight * 2)], 
                                    nil];
        animation.keyTimes = [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:0.0],
                                   [NSNumber numberWithFloat:0.6],
                                   [NSNumber numberWithFloat:0.8],
                                   [NSNumber numberWithFloat:1.0], 
                                   nil];	
        animation.delegate = self;

        [self.layer addAnimation:animation forKey:nil];	
    }
    _statusMessage.text = string;
    [self setNeedsLayout];
}

- (void) hideStatusMessageAnimated:(BOOL) animated {
    
    if(!_statusMessage.isHidden) {
        _statusMessage.text = nil;
        _statusMessage.hidden = YES;

        self.frame = FLRectSetHeight(self.frame, kHeight);
       
        CALayer *viewLayer = self.layer;
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];

        animation.duration = 0.3f;
        animation.values = [NSArray arrayWithObjects:
                                 [NSValue valueWithCGRect:CGRectMake(0,0,self.bounds.size.width, kHeight - 4)],
                                 [NSValue valueWithCGRect:CGRectMake(0,0,self.bounds.size.width, kHeight + 3)],
                                 [NSValue valueWithCGRect:CGRectMake(0,0,self.bounds.size.width, kHeight - 2)],
                                 [NSValue valueWithCGRect:CGRectMake(0,0,self.bounds.size.width, kHeight)],
                                 nil];
        animation.keyTimes = [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:0.0],
                                   [NSNumber numberWithFloat:0.6],
                                   [NSNumber numberWithFloat:0.8],
                                   [NSNumber numberWithFloat:1.0], 
                                   nil];	

        [viewLayer addAnimation:animation forKey:@"bounds"];
    }
}

@end

@implementation FLLargerSimpleProgressView 

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    return self;

}

- (void) layoutProgressViews {

    self.textLabel.frameOptimizedForLocation = CGRectMake(0, self.bounds.size.height * 0.15, self.bounds.size.width, 20);
    self.spinner.frameOptimizedForLocation = FLRectCenterRectInRectHorizontally(self.bounds, FLRectSetTop(self.spinner.frame, FLRectGetBottom(self.textLabel.frame)));

//    _statusMessage.frame = FLRectSetTop(topRect, topRect.size.height);
}


- (CGSize)sizeThatFits:(CGSize) inSize {
    CGSize outSize = [self.textLabel sizeThatFitsText];
    outSize.width = MAX(self.minSize.width, outSize.width*2);
    outSize.height = MAX(self.minSize.height, outSize.width * 0.40);
    return outSize;
}

@end








