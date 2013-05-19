//
//  FLSmallProgressView.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLLegacyProgressView.h"
#import "FLGradientView.h"

@interface FLSmallProgressView : FLLegacyProgressView {
@private
	FLGradientView* _gradientView;
}

+ (FLSmallProgressView*) smallProgressView;

@end
