//
//  GtCustomButton.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/20/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//



#import "GtCustomButton.h"
#import "GtColors.h"

@implementation GtCustomButton

- (GtCustomButtonColor) defaultColor
{
    return GtCustomButtonColorGray;
}

- (void) onSetupButton
{
    self.customButtonColor = self.defaultColor;
}

- (id) initWithCustomColor:(GtCustomButtonColor) color
{
    if(self = [super initWithFrame:CGRectZero])
    {
        self.customButtonColor = color;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self onSetupButton];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) 
    {
        [self onSetupButton];
    }
	
	return self;
}


- (void) setMinSize
{
    CGRect frame = self.frame;
    if(frame.size.height != m_minSize.height)
    {
        frame.size.height = m_minSize.height;
    }
    if(frame.size.width < m_minSize.width)
    {
        frame.size.width = m_minSize.width;
    }
    self.frame = frame;
}

- (void) sizeToFit
{
    [self setMinSize];

    CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                    constrainedToSize:CGSizeMake(1000, 1000)
                    lineBreakMode:UILineBreakModeMiddleTruncation];
    size.width += 24;
    
    CGRect myFrame = self.frame;
    myFrame.size.width = size.width;
    self.frame = myFrame;
}


- (void) setNormalImage:(NSString*) name
{
	UIImage* image = [UIImage imageNamed:name];
    GtAssertNotNil(image);

    UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:12 topCapHeight:12];
	[self setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    
    m_minSize = image.size;
    
    [self setMinSize];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self setMinSize];
}

- (GtCustomButtonColor) customButtonColor
{
    return m_color;
}

- (void) setCustomButtonColor:(GtCustomButtonColor) color
{
    m_color = color;
    CGFloat fontSize = [UIFont buttonFontSize];
    UIColor* lightColor = [UIColor whiteColor];
    UIColor* darkColor = [UIColor darkTextColor];
    switch(m_color)
    {
        case GtCustomButtonColorGreen:
            [self setNormalImage:@"greenbutton.png"];
            
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
            [self setTitleColor:lightColor forState:UIControlStateNormal];
            [self setTitleShadowColor:darkColor forState:UIControlStateNormal];
        
        break;
        
        case GtCustomButtonColorRed:
    
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
            [self setNormalImage:@"redbutton.png"];
    
            [self setTitleColor:lightColor forState:UIControlStateNormal];
            [self setTitleShadowColor:darkColor forState:UIControlStateNormal];
        break;
        
        case GtCustomButtonColorBlack:
    
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    
            [self setNormalImage:@"blackbutton.png"];
    
            [self setTitleColor:lightColor forState:UIControlStateNormal];
            [self setTitleShadowColor:darkColor forState:UIControlStateNormal];
        break;
        
        case GtCustomButtonColorYellow:
            
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
            [self setNormalImage:@"yellowbutton.png"];
    
            [self setTitleColor:darkColor forState:UIControlStateNormal];
            [self setTitleShadowColor:lightColor forState:UIControlStateNormal];
        break;
        
        case GtCustomButtonColorGray:
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            
            [self setNormalImage:@"lightgraybutton.png"];
    
            [self setTitleColor:darkColor forState:UIControlStateNormal];
            [self setTitleShadowColor:lightColor forState:UIControlStateNormal];
        break;
    }
}

@end

@implementation GtRedButton

- (GtCustomButtonColor) defaultColor
{
    return GtCustomButtonColorRed;
}

@end

@implementation GtGrayButton

- (GtCustomButtonColor) defaultColor
{
    return GtCustomButtonColorGray;
}

@end

@implementation GtBlackButton

- (GtCustomButtonColor) defaultColor
{
    return GtCustomButtonColorBlack;
}
@end

@implementation GtGreenButton

- (GtCustomButtonColor) defaultColor
{
    return GtCustomButtonColorGreen;
}
@end


@implementation GtYellowButton

- (GtCustomButtonColor) defaultColor
{
    return GtCustomButtonColorYellow;
}
@end