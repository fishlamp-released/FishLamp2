//
//	FLMultiColumnBlockTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
