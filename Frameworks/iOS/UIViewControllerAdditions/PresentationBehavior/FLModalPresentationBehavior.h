//
//  FLModalPresentationBehavior.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FishLampCore.h"
#import "UIViewController+FLPresentationBehavior.h"

@interface FLModalPresentationBehavior : NSObject<FLPresentationBehavior> {
@private
    UIViewController* _shieldViewController;
}

FLSingletonProperty(FLModalPresentationBehavior);

@end
