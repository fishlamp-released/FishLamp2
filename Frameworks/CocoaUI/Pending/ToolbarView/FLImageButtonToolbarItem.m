//
//  FLImageButtonToolbarItem.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageButtonToolbarItem.h"

#if IOS
#import "SDKImage+FLColorize.h"
#import "SDKImage+Resize.h"
#import "FLButton.h"
#endif

@implementation FLImageButtonToolbarItem

- (void) setSubviewSize:(CGSize) size {
}

- (CGSize) subviewSizeThatFitsInBounds:(CGRect) bounds {
    return [self.view frame].size;
}

- (id) initWithImage:(SDKImage*) image 
       onChosenBlock:(FLToolbarViewBlock)onChosenBlock {

    if((self = [super init])) {
        self.onChosen = onChosenBlock;

// FIXME

#if IOS
        FLButton* button = [FLButton button];
        button.frame = [image proportionalBoundsWithMaxSize:CGSizeMake(26,26)];
        [button setImage:image forState:UIControlStateNormal];
        button.onPress = onChosenBlock;
        button.enabled = YES;
        button.showsTouchWhenHighlighted = YES;
        
        self.view = button;
#endif

    }
    
    return self;
}

- (id) initWithImageName:(NSString*) imageName         
           onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

// FIXME @"image needs themeing");

    SDKImage* image = [SDKImage whiteImageNamed:imageName];
    FLAssertIsNotNil(image);

    return [self initWithImage:image onChosenBlock:onChosenBlock];
}

+ (id) imageButtonToolbarItemWithImage:(SDKImage*) image         
                onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    return FLAutorelease([[FLImageButtonToolbarItem alloc] initWithImage:image onChosenBlock:onChosenBlock]);

}

+ (id) imageButtonToolbarItemWithImageName:(NSString*) imageName         
                onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    return FLAutorelease([[FLImageButtonToolbarItem alloc] initWithImageName:imageName onChosenBlock:onChosenBlock]);

}

@end