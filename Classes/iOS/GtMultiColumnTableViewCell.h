//
//	GtMultiColumnBlockTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtTableViewCell.h"
#import "GtMultiColumnWidget.h"

@interface GtMultiColumnTableViewCell : GtTableViewCell {
@private
	BOOL m_selectedStates[32];
}
@property (readonly, retain, nonatomic) GtMultiColumnWidget* widget;
@end
