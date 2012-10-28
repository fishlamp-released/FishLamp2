//
//  FLTouchableString.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTouchableString.h"


@implementation FLTouchableString

@synthesize textColor = _color;
@synthesize highlightedTextColor = _highlightedColor;
@synthesize text = _text;
@synthesize touchedCallback = _callback;
@synthesize textFont = _font;
@synthesize runFrames = _runFrames;

FLSynthesizeStructProperty(isHighlighted, setHighlighted, BOOL, _flags);
FLSynthesizeStructProperty(isTouchable, setTouchable, BOOL, _flags);
FLSynthesizeStructProperty(isEnabled, setEnabled, BOOL, _flags);
FLSynthesizeStructProperty(isHidden, setHidden, BOOL, _flags);

+ (FLTouchableString*) touchableString
{
    return FLReturnAutoreleased([[FLTouchableString alloc] init]);
}

- (id) init
{
    if((self = [super init]))
    {
        _runFrames = [[NSMutableArray alloc] init];
        self.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        self.textColor = [UIColor whiteColor];
        self.highlightedTextColor = [UIColor blueColor];
    }

    return self;
}

- (void) resetRunFrames
{
    [_runFrames removeAllObjects];
}   

- (void) addRunFrame:(FLRect) frame
{
    [_runFrames addObject:[NSValue valueWithCGRect:frame]];
}

- (BOOL) pointInString:(FLPoint) point
{
    for(NSValue* value in _runFrames)
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
    FLRelease(_runFrames);
    FLRelease(_color);
    FLRelease(_highlightedColor);
    FLRelease(_text);
    FLRelease(_font);
    FLSuperDealloc();
}

- (NSAttributedString*) attributedString
{
    NSRange range = NSMakeRange(0, self.text.length);

    NSMutableAttributedString* string =
        FLReturnAutoreleased([[NSMutableAttributedString alloc] initWithString:self.text]);
    
    CTFontRef fontRef = CTFontCreateWithName((__bridge_fl CFStringRef)self.textFont.fontName, self.textFont.pointSize, NULL);
    FLAssertIsNotNil_(fontRef);
    
    if(fontRef)
    {
        [string addAttribute:(NSString*) kCTFontAttributeName
            value:(__bridge_fl id) fontRef 
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
