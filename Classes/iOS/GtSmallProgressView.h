//
//  GtSmallProgressView.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtProgressView.h"
#import "GtGradientView.h"

@interface GtSmallProgressView : GtProgressView {
@private
	GtGradientView* m_gradientView;
}

+ (GtSmallProgressView*) smallProgressView;

@end
