//
//	FLCountView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLRoundRectView.h"

@interface FLCountView : FLRoundRectView {
@private
	UILabel* _countView;
}

@property (readwrite, assign, nonatomic) NSInteger count;


@end
