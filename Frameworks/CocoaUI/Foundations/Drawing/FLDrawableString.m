//
//  FLDrawableString.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDrawableString.h"

@implementation FLDrawableString

@synthesize textAlignment = _textAlignment;

- (id) initWithString:(NSString*) string {
    self = [super initWithString:string];
    if(self) {
    }
    return self;
}

- (void) drawRect:(CGRect) drawRect 
        withFrame:(CGRect) frame 
         inParent:(id) parent
drawEnclosedBlock:(void (^)(void)) drawEnclosedBlock {

	if(FLStringIsNotEmpty(self.string)) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
#if IOS    
        UIColor* color = self.colorForState;
        if(color) {
            [color set];
        }
        UIColor* shadowColor = self.shadowColorForState;
        CGContextSetShadowWithColor(context, 
                        self.shadowOffset, 
                        2,	
                        shadowColor.CGColor);

        [self.string drawInRect:frame withFont:self.textFont lineBreakMode:_lineBreakMode alignment:_textAlignment];
#else 
        [FLCoreText drawString:self.attributedString withTextAlignment:_textAlignment inBounds:frame];
#endif        
        CGContextRestoreGState(context);
	}
}

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif

@end


