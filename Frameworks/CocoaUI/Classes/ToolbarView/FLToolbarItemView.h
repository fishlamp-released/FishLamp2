//
//  FLToolbarItemView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaUIRequired.h"

#import "FLToolbarItem.h"

@interface FLToolbarItemView : FLToolbarItem {
}
+ (id) toolbarItemView:(SDKView*) view 
         onChosenBlock:(FLToolbarViewBlock) onChosenBlock ;
@end
