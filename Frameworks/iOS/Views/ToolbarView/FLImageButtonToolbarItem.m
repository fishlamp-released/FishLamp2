//
//  FLImageButtonToolbarItem.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLImageButtonToolbarItem.h"
#import "FLImage+Colorize.h"
#import "FLImage+Resize.h"
#import "FLButton.h"

@implementation FLImageButtonToolbarItem

- (void) setSubviewSize:(CGSize) size {
}

- (CGSize) subviewSizeThatFitsInBounds:(CGRect) bounds {
    return [self.view frame].size;
}

- (id) initWithImage:(UIImage*) image 
       onChosenBlock:(FLToolbarViewBlock)onChosenBlock {

    if((self = [super init])) {
        self.onChosen = onChosenBlock;

        FLButton* button = [FLButton button];
        button.frame = [image proportionalBoundsWithMaxSize:FLSizeMake(26,26)];
        [button setImage:image forState:UIControlStateNormal];
        button.onPress = onChosenBlock;
        button.enabled = YES;
        button.showsTouchWhenHighlighted = YES;
        
        self.view = button;
    }
    
    return self;
}

- (id) initWithImageName:(NSString*) imageName         
           onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    FLFixMe_v(@"image needs themeing");

    UIImage* image = [UIImage whiteImageNamed:imageName];
    FLAssertIsNotNil_(image);

    return [self initWithImage:image onChosenBlock:onChosenBlock];
}

+ (id) imageButtonToolbarItemWithImage:(UIImage*) image         
                onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    return FLAutorelease([[FLImageButtonToolbarItem alloc] initWithImage:image onChosenBlock:onChosenBlock]);

}

+ (id) imageButtonToolbarItemWithImageName:(NSString*) imageName         
                onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    return FLAutorelease([[FLImageButtonToolbarItem alloc] initWithImageName:imageName onChosenBlock:onChosenBlock]);

}

@end