//
//  FLImageButtonToolbarItem.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLImageButtonToolbarItem.h"
#import "UIImage+FLColorize.h"
#import "UIImage+Resize.h"
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
        button.frame = [image proportionalBoundsWithMaxSize:CGSizeMake(26,26)];
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

FLFixMe(@"image needs themeing");

    UIImage* image = [UIImage whiteImageNamed:imageName];
    FLAssertIsNotNil(image);

    return [self initWithImage:image onChosenBlock:onChosenBlock];
}

+ (id) imageButtonToolbarItemWithImage:(UIImage*) image         
                onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    return FLReturnAutoreleased([[FLImageButtonToolbarItem alloc] initWithImage:image onChosenBlock:onChosenBlock]);

}

+ (id) imageButtonToolbarItemWithImageName:(NSString*) imageName         
                onChosenBlock:(FLToolbarViewBlock) onChosenBlock {

    return FLReturnAutoreleased([[FLImageButtonToolbarItem alloc] initWithImageName:imageName onChosenBlock:onChosenBlock]);

}

@end