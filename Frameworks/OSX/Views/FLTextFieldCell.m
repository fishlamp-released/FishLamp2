//
//  FLTextField.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 1/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTextFieldCell.h"

// from http://stackoverflow.com/questions/1235219/is-there-a-right-way-to-have-nstextfieldcell-draw-vertically-centered-text

@implementation FLTextFieldCell

-(void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSAttributedString *attrString = self.attributedStringValue;

//    /* if your values can be attributed strings, make them white when selected */
//    if (self.isHighlighted && self.backgroundStyle==NSBackgroundStyleDark) {
//        NSMutableAttributedString *whiteString = attrString.mutableCopy;
//        [whiteString addAttribute: NSForegroundColorAttributeName
//                            value: [NSColor whiteColor]
//                            range: NSMakeRange(0, whiteString.length) ];
//        attrString = whiteString;
//    }

    [attrString drawWithRect: [self titleRectForBounds:cellFrame] 
                     options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin];
}

- (NSRect)titleRectForBounds:(NSRect)theRect {
    /* get the standard text content rectangle */
    NSRect titleFrame = [super titleRectForBounds:theRect];

    /* find out how big the rendered text will be */
    NSAttributedString *attrString = self.attributedStringValue;
    NSRect textRect = [attrString boundingRectWithSize: titleFrame.size
                                               options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin ];

    textRect.origin.x = titleFrame.origin.x;

    /* If the height of the rendered text is less then the available height,
     * we modify the titleRect to center the text vertically */
    if (textRect.size.height < titleFrame.size.height) {
        titleFrame.origin.y = theRect.origin.y + (theRect.size.height - textRect.size.height) / 2.0;
        titleFrame.size.height = textRect.size.height;
    }
    return titleFrame;
}

@end

/*

- (NSRect)titleRectForBounds:(NSRect)theRect 
 {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
     // test to see if the text height is bigger then the cell, if it is,
     // don't try to center it or it will be pushed up out of the cell!
     if ( titleSize.height < theRect.size.height ) {
         titleFrame.origin.y = theRect.origin.y + (theRect.size.height - titleSize.height) / 2.0;
     }
    return titleFrame;
}

*/