//
//  FLNormalPresentationBehavior.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>
#import "FishLampCore.h"
#import "UIViewController+FLPresentationBehavior.h"

@interface FLNormalPresentationBehavior : NSObject<FLPresentationBehavior> {
}

FLSingletonProperty(FLNormalPresentationBehavior);
@end
