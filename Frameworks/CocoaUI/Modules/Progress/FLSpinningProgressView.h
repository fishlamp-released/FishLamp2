//
//  FLSpinningProgressView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimatedImageView.h"

//@interface FLSpinningProgressView : FLAnimatedImageView {
//@private
//    NSProgressIndicator* _spinner;
//} 
//
//- (void) setRespondsToGlobalNetworkActivity;
//
//@end

@interface FLSpinningProgressView : NSProgressIndicator {
}
- (void) setRespondsToGlobalNetworkActivity;
@end