//
//	FLMultiColumnBlockTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTableViewCell.h"
#import "FLMultiColumnWidget.h"

@interface FLMultiColumnTableViewCell : FLTableViewCell {
@private
	BOOL _selectedStates[32];
}
@property (readonly, retain, nonatomic) FLMultiColumnWidget* widget;
@end
