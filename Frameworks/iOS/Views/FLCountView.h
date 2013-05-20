//
//	FLCountView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLRoundRectView.h"

@interface FLCountView : FLRoundRectView {
@private
	UILabel* _countView;
}

@property (readwrite, assign, nonatomic) NSInteger count;


@end
