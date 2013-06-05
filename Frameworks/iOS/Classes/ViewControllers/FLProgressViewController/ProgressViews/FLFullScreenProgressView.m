//
//  FLFullScreenProgress.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFullScreenProgressView.h"
#import "FLColorRange.h"

@implementation FLFullScreenProgressView

- (void) applyTheme:(FLTheme*) theme {
    [_backgroundWidget setColorRange:[FLColorRange lightLightGrayGradientColorRange]  forControlState:UIControlStateNormal];

    _titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textColor = [UIColor gray10Color];
    _titleLabel.shadowColor = [UIColor whiteColor];
    _titleLabel.shadowOffset = CGSizeMake(0,1);

    if(!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_spinner startAnimating];
        [self addSubview:_spinner];
    }
    
    // TODO: tint progress
    
    [self setNeedsLayout];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsApplyTheme = YES;
        self.autoresizesSubviews = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundWidget = [[FLGradientWidget alloc] init];
        _backgroundWidget.contentMode = FLRectLayoutFill;
        [self addWidget:_backgroundWidget];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,frame.size.width, 20.0f)]; 
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self addSubview:_progress];
    }
    return self;
}

- (NSString*) title {
    return _titleLabel.text;
}

- (void) setTitle:(NSString*) title {
    _titleLabel.text = title;
    [self setNeedsLayout];
}

- (BOOL) progressBarHidden {
    return _progress.hidden;
}

- (void) setProgressBarHidden:(BOOL) hidden {
    _progress.hidden = hidden;
}

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount {
            
}            

- (void) layoutSubviews {
    [super layoutSubviews];

    _spinner.frameOptimizedForLocation = FLRectPositionRectInRectVerticallyTopThird(self.bounds, 
        FLRectCenterRectInRectHorizontally(self.bounds, _spinner.frame));

    _titleLabel.frameOptimizedForLocation = FLRectPositionRectInRectVerticallyBottomThird(self.bounds, CGRectMake(0,0, self.bounds.size.width, 20.0f));

    _progress.frameOptimizedForLocation = FLRectCenterRectInRectHorizontally(self.bounds, CGRectMake(0,FLRectGetBottom(_titleLabel.frame) + 20.0f, self.bounds.size.width / 2.0f, 12.0f));
}

- (void) overrideViewPositionIfNeeded:(FLRectLayout *)position {
    if(position) {
        *position = FLRectLayoutFill;
    }
}

#if FL_MRC 
- (void) dealloc {
    FLRelease(_titleLabel);
    FLRelease(_spinner);
    FLRelease(_backgroundWidget);
    FLRelease(_progress);
    FLSuperDealloc();
}
#endif

@end
