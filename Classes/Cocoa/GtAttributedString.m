//
//  GtAttributedString.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAttributedString.h"


@implementation GtAttributedString

@synthesize textColor = m_color;
@synthesize highlightedTextColor = m_highlightedColor;
@synthesize text = m_text;
@synthesize touchedCallback = m_callback;
@synthesize textFont = m_font;
@synthesize runFrames = m_runFrames;

GtSynthesizeStructProperty(isHighlighted, setHighlighted, BOOL, m_flags);
GtSynthesizeStructProperty(isTouchable, setTouchable, BOOL, m_flags);
GtSynthesizeStructProperty(isEnabled, setEnabled, BOOL, m_flags);
GtSynthesizeStructProperty(isHidden, setHidden, BOOL, m_flags);

+ (GtAttributedString*) attributedString
{
    return GtReturnAutoreleased([[GtAttributedString alloc] init]);
}

- (id) init
{
    if((self = [super init]))
    {
        m_runFrames = [[NSMutableArray alloc] init];
        self.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        self.textColor = [UIColor whiteColor];
        self.highlightedTextColor = [UIColor blueColor];
    }

    return self;
}

- (void) resetRunFrames
{
    [m_runFrames removeAllObjects];
}   

- (void) addRunFrame:(CGRect) frame
{
    [m_runFrames addObject:[NSValue valueWithCGRect:frame]];
}

- (BOOL) pointInString:(CGPoint) point
{
    for(NSValue* value in m_runFrames)
    {
        if(CGRectContainsPoint([value CGRectValue], point))
        {
            return YES;
        }
    }
    
    return NO;
}

- (void) dealloc 
{   
    GtRelease(m_runFrames);
    GtRelease(m_color);
    GtRelease(m_highlightedColor);
    GtRelease(m_text);
    GtRelease(m_font);
    GtSuperDealloc();
}

- (NSAttributedString*) attributedString
{
    NSRange range = NSMakeRange(0, self.text.length);

    NSMutableAttributedString* string =
        GtReturnAutoreleased([[NSMutableAttributedString alloc] initWithString:self.text]);
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.textFont.fontName, self.textFont.pointSize, NULL);
    GtAssertNotNil(fontRef);
    
    if(fontRef)
    {
        [string addAttribute:(NSString*) kCTFontAttributeName
            value:(id) fontRef 
            range:range];

        CFRelease(fontRef);
    }

    [string addAttribute:(NSString*) kCTForegroundColorAttributeName 
        value:(id) (self.isHighlighted ? self.highlightedTextColor.CGColor : self.textColor.CGColor) 
        range:range];
    
    [string addAttribute:@"attr_str" value:self range:range];
    
    return string;
}

@end
