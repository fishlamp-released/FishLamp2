//
//  FLToolbarItemView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#import "FLToolbarItem.h"

@interface FLToolbarItemView : FLToolbarItem {
}
+ (id) toolbarItemView:(UIView*) view 
         onChosenBlock:(FLToolbarViewBlock) onChosenBlock ;
@end
