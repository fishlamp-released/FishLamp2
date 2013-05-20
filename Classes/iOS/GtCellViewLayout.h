//
//  GtCellViewLayout.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/18/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewLayout.h"

@protocol GtCellViewLayoutDelegate;

@interface GtCellViewLayout : GtViewLayout {
@private
    id<GtCellViewLayoutDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtCellViewLayoutDelegate> delegate;

- (id) initWithDelegate:(id<GtCellViewLayoutDelegate>) delegate;

@end


@protocol GtCellViewLayoutDelegate <NSObject>
- (CGSize) cellViewLayoutGetCellSize:(GtCellViewLayout*) layout;
@end