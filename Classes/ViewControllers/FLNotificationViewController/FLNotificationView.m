//
//  FLNotificationView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLNotificationView.h"
#import "FLGradientView.h"

@implementation FLNotificationView

- (id)initWithFrame:(FLRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//		self.userInteractionEnabled = YES;
//		self.multipleTouchEnabled = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
//		self.exclusiveTouch = YES;
//		self.themeAction = @selector(applyThemeToProgressView:);
		
//		_roundRectView = [[FLRoundRectView alloc] initWithFrame:self.bounds];
//        _roundRectView.autoresizesSubviews  = YES;
//        _roundRectView.cornerRadius = 2.0;

        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 20.0;
        self.layer.shadowOffset = FLSizeMake(0,0);
        self.clipsToBounds = NO;
//        self.layer.borderWidth = 1.0;
//        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.backgroundColor = [UIColor clearColor];

        _gradient = [FLGradientView viewWithFrame:self.bounds];
		[self addSubview:_gradient];
        
//        [self addSubview:_roundRectView];

        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset	= FLSizeMake (0.0, 1.0);
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]; 
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        _titleLabel.lineBreakMode = UILineBreakModeClip;
        [self addSubview:_titleLabel];	  
    }
    return self;

}

- (void) setFrame:(FLRect) frame
{
    [super setFrame:frame];
}

#if FL_MRC
- (void) dealloc
{
    mrc_release_(_gradient);
    mrc_release_(_titleLabel);
    mrc_super_dealloc_();
}
#endif

- (void) layoutSubviews
{
    [super layoutSubviews];

    _gradient.frame = self.bounds;
    _titleLabel.frame = self.bounds;
}

- (void) setTitle:(NSString*) title
{
    _titleLabel.text = title;
    [self setNeedsLayout];
}

- (NSString*) title
{
    return _titleLabel.text;
}

- (FLSize)sizeThatFits:(FLSize) size
{
    size.height = [_titleLabel sizeThatFitsWidth:size.width - 40.0f].height;
    return size;
}

@end
