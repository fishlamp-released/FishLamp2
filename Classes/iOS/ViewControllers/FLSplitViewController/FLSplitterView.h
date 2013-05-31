//
//  FLSplitterView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"

@protocol FLSplitterViewDelegate;

@interface FLSplitterView : FLWidgetView {
@private    
    __unsafe_unretained id<FLSplitterViewDelegate> _splitterViewDelegate;
}

@property (readwrite, assign, nonatomic) id<FLSplitterViewDelegate> delegate;

@end


@protocol FLSplitterViewDelegate <NSObject>
- (void) splitterViewWasMoved:(FLSplitterView*) splitterView;
@end