//
//  FLImageButtonToolbarItem.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#import "FLToolbarItemView.h"

@interface FLImageButtonToolbarItem : FLToolbarItemView {
}

- (id) initWithImage:(UIImage*) image 
       onChosenBlock:(FLToolbarViewBlock)onChosenBlock;

- (id) initWithImageName:(NSString*) imageName          
           onChosenBlock:(FLToolbarViewBlock) onChosenBlock;

+ (id) imageButtonToolbarItemWithImage:(UIImage*) image         
                         onChosenBlock:(FLToolbarViewBlock) onChosenBlock;

+ (id) imageButtonToolbarItemWithImageName:(NSString*) imageName         
                             onChosenBlock:(FLToolbarViewBlock) onChosenBlock;

@end