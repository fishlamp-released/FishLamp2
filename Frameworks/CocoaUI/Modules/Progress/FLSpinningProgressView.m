//
//  FLSpinningProgressView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSpinningProgressView.h"
#import "FLRotateAnimation.h"
#import "FLGlobalNetworkActivityIndicator.h"

@implementation FLSpinningProgressView

@synthesize image = _image;
@synthesize animate = _animate;

- (id) initSelf {
    self.wantsLayer = YES;
    self.layer = [CALayer layer];
    
    _animation = [[FLSomersaultAnimation alloc] init];
    _animation.duration = 0.1f;
    _animation.direction = FLAnimationDirectionForward;
    _animation.axis = FLAnimationAxisZ;
    _animation.timing = FLAnimationTimingLinear;
    _animation.duration = 1.0f;
    
    _rotationLayer = [[CALayer alloc] init];
    _rotationLayer.position = CGPointMake(self.bounds.size.width/2.0,self.bounds.size.height/2.0);
    _rotationLayer.bounds = CGRectMake(0,0,self.bounds.size.width, self.bounds.size.height);
    [self.layer addSublayer:_rotationLayer];
       
    if(OSXVersionIsAtLeast10_7()) {
        self.image = [[NSBundle mainBundle] imageForResource:@"chasingarrows"];
    }
    else {
        NSString* defaultImagePath = [[NSBundle mainBundle] pathForImageResource:@"chasingarrows.png"];
        self.image = FLAutorelease([[NSImage alloc] initWithContentsOfFile:defaultImagePath]);
    }

    self.hidden = YES;

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

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [[super initWithCoder:aDecoder] initSelf];
}

- (id)initWithFrame:(NSRect)frame {
    return [[super initWithFrame:frame] initSelf];
}

- (NSImage*) image {
    return _rotationLayer.contents;
}

- (void) setImage:(NSImage*) image {
    _rotationLayer.contents = image;
}

- (void) viewDidMoveToSuperview {
    [super viewDidMoveToSuperview];
    
    if(_animate) {
        [self performSelector:@selector(startAnimating) withObject:nil afterDelay:1.0];
    }
}

- (void) startAnimating {
    _animate = YES;
    self.hidden = NO;
       
    if(!_animation.isAnimating) {
        [_animation startAnimating:_rotationLayer completion:^{
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
    self.hidden = YES;
    [self setNeedsDisplay:YES];
}

- (void) showNetworkProgress:(id) sender {
    FLLog(@"got start message");
    [self startAnimating];
}

- (void) hideNetworkProgress:(id) sender {
    FLLog(@"got stop message");
    [self stopAnimating];
}

- (void) setRespondsToGlobalNetworkActivity:(BOOL) responds {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNetworkProgress:) name:FLGlobalNetworkActivityShow object:[FLGlobalNetworkActivityIndicator instance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNetworkProgress:) name:FLGlobalNetworkActivityHide object:[FLGlobalNetworkActivityIndicator instance]];

}


@end

