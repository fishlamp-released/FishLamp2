//
//	GtCountView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtRoundRectView.h"

@interface GtCountView : GtRoundRectView {
@private
	UILabel* m_countView;
}

@property (readwrite, assign, nonatomic) NSInteger count;


@end
