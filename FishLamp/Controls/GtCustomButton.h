//
//  GtCustomButton.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/20/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GtCustomButtonHeight 46

typedef enum {
    GtCustomButtonColorGray,
    GtCustomButtonColorBlack,
    GtCustomButtonColorGreen,
    GtCustomButtonColorYellow,
    GtCustomButtonColorRed
} GtCustomButtonColor;


@interface GtCustomButton : UIButton {
    CGSize m_minSize;
    GtCustomButtonColor m_color;
}

- (id) initWithCustomColor:(GtCustomButtonColor) color; 

@property (readwrite, assign, nonatomic) GtCustomButtonColor customButtonColor;

@end

// these are just here for use in Inteface builder. The only
// difference between these and the GtCustomButton is the starting
// color

@interface GtRedButton : GtCustomButton {}
@end

@interface GtGrayButton : GtCustomButton {}
@end

@interface GtBlackButton : GtCustomButton {}
@end

@interface GtGreenButton : GtCustomButton {}
@end

@interface GtYellowButton : GtCustomButton {}
@end
