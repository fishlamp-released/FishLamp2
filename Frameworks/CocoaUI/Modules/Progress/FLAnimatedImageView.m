//
//  FLAnimatedImageView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimatedImageView.h"
#import "FLGlobalNetworkActivityIndicator.h"

@implementation FLAnimatedImageView

@synthesize image = _image;
@synthesize animate = _animate;
@synthesize displayedWhenStopped = _displayedWhenStopped;
@synthesize animation = _animation;

- (id) setupAnimatedImageView {
    if(!_animation) {
        self.wantsLayer = YES;
        self.layer = [CALayer layer];
        
        _animation = [[FLSomersaultAnimation alloc] init];
        _animation.duration = 0.1f;
        _animation.direction = FLAnimationDirectionRight;
        _animation.axis = FLAnimationAxisZ;
        _animation.timing = FLAnimationTimingLinear;
        _animation.duration = 1.0f;
        
        _rotationLayer = [[CALayer alloc] init];
        _rotationLayer.position = CGPointMake(self.bounds.size.width/2.0,self.bounds.size.height/2.0);
        _rotationLayer.bounds = CGRectMake(0,0,self.bounds.size.width, self.bounds.size.height);
        [self.layer addSublayer:_rotationLayer];
           
        self.hidden = YES;   
    }
       
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if FL_MRC
    [_animation release];
    [_rotationLayer release];
    [super dealloc];
#endif
}

- (void) setDisplayedWhenStopped:(BOOL) visible {
    _displayedWhenStopped = visible;
    if(_displayedWhenStopped) {
        self.hidden = NO;
    }
    else {
        self.hidden = !_animate;
    }
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [[super initWithCoder:aDecoder] setupAnimatedImageView];
}

- (id)initWithFrame:(NSRect)frame {
    return [[super initWithFrame:frame] setupAnimatedImageView];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setupAnimatedImageView];
}

- (NSImage*) image {
    return _rotationLayer.contents;
}

- (void) setImage:(NSImage*) image {
    _rotationLayer.contents = image;
}

- (void) viewDidMoveToSuperview {
    [super viewDidMoveToSuperview];
    
    if(self.superview) {
        if(_animate) {
            [self performSelector:@selector(startAnimating) withObject:nil afterDelay:1.0];
        }
        if(_displayedWhenStopped) {
            self.hidden = NO;
        }
    }
    else {
        _animate = NO;
        _animationIsAnimating = NO;
    }
    
}

- (void) startAnimating {
    _animate = YES;
    self.hidden = NO;
          
    if(!_animationIsAnimating) {
        _animationIsAnimating = YES;
        [_animation startAnimating:_rotationLayer completion:^{
            _animationIsAnimating = NO;
            if(_animate) {
                [self startAnimating];
            }
            else {
                [self stopAnimating];
            }
        }];
    }
    
    [self setNeedsDisplay:YES];
}

- (void) stopAnimating {
    _animate = NO;
    if(!_displayedWhenStopped) {
        self.hidden = YES;
    }
    
    [self setNeedsDisplay:YES];
}

- (void) showNetworkProgress:(id) sender {
    [self startAnimating];
}

- (void) hideNetworkProgress:(id) sender {
    [self stopAnimating];
}

- (void) setRespondsToGlobalNetworkActivity:(BOOL) responds {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNetworkProgress:) name:FLGlobalNetworkActivityShow object:[FLGlobalNetworkActivityIndicator instance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNetworkProgress:) name:FLGlobalNetworkActivityHide object:[FLGlobalNetworkActivityIndicator instance]];

}

- (void) setImageWithNameInBundle:(NSString*) name {
    if(OSXVersionIsAtLeast10_7()) {
        self.image = [[NSBundle mainBundle] imageForResource:[name stringByDeletingPathExtension]];
    }
    else {
        NSString* defaultImagePath = [[NSBundle mainBundle] pathForImageResource:name];
        self.image = FLAutorelease([[NSImage alloc] initWithContentsOfFile:defaultImagePath]);
    }
}


@end
