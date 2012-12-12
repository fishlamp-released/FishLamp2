//
//  FLToolbarItemView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLToolbarItem.h"

@interface FLToolbarItemView : FLToolbarItem {
}
+ (id) toolbarItemView:(SDKView*) view 
         onChosenBlock:(FLToolbarViewBlock) onChosenBlock ;
@end
