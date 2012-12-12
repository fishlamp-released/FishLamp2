//
//  FLBreadcrumb.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLBreadcrumb.h"

@implementation FLBreadcrumb

@synthesize enabledTextColor = _enabledTextColor;
@synthesize disabledTextColor = _disabledTextColor;
@synthesize highlightedTextColor = _highlightedTextColor;
@synthesize textFont = _textFont;
@synthesize string = _string;
@synthesize touchedBlock = _touchedBlock;
@synthesize runFrames = _runFrames;
@synthesize highlighted = _highlighted;
@synthesize touchable = _touchable;
@synthesize enabled = _enabled;
@synthesize hidden = _hidden;

- (id) init {
    return [self initWithString:@""];
}

- (id) initWithString:(NSString*) string {
    self = [super init];
    if(self) {
        _runFrames = [[NSMutableArray alloc] init];
        self.string = string;
    }
    
    return self;
}

+ (FLBreadcrumb*) breadcrumb {
    return FLAutorelease([[FLBreadcrumb alloc] initWithString:@""]);
}

+ (FLBreadcrumb*) breadcrumb:(NSString*) string {
    return FLAutorelease([[FLBreadcrumb alloc] initWithString:string]);
}

- (void) resetRunFrames {
    [_runFrames removeAllObjects];
}   

- (void) addRunFrame:(CGRect) frame {
    [_runFrames addObject:[NSValue valueWithCGRect:frame]];
}

- (BOOL) pointInString:(CGPoint) point {
    for(NSValue* value in _runFrames) {
        if(CGRectContainsPoint([value CGRectValue], point)) {
            return YES;
        }
    }
    
    return NO;
}

#if FL_MRC
- (void) dealloc {
    [_touchedBlock release];
    [_runFrames release];
    [_enabledTextColor release];
    [_disabledTextColor release];
    [_highlightedTextColor release];
    [_textFont release];
    [_string release];
    [super dealloc];
}
#endif

- (FLColor*) colorForState {
    if(self.isEnabled) {
        if(self.isHighlighted) {
            return self.highlightedTextColor;
        }
        else {
            return self.enabledTextColor;
        }
    }
    else {
        return self.disabledTextColor;
    }
}

- (NSAttributedString*) attributedString {
    NSRange range = NSMakeRange(0, self.string.length);

    NSMutableAttributedString* string =
        FLAutorelease([[NSMutableAttributedString alloc] initWithString:self.string]);
    
    CTFontRef fontRef = CTFontCreateWithName(bridge_(CFStringRef, self.textFont.fontName), self.textFont.pointSize, NULL);
    FLAssertIsNotNil_(fontRef);
    
    if(fontRef) {
        [string addAttribute:(NSString*) kCTFontAttributeName
            value:bridge_(id, fontRef) 
            range:range];

        CFRelease(fontRef);
    }

    [string addAttribute:(NSString*) kCTForegroundColorAttributeName 
        value:bridge_(id, [[self colorForState] CGColor])
        range:range];
    
    [string addAttribute:@"com.fishlamp.breadcrumb" value:self range:range];
    
    return string;
}

@end
