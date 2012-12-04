//
//	FLTableCellBackground.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

@interface FLTableCellBackgroundWidget : FLWidget {
@private
	UITableViewCellSelectionStyle _selectionStyle;
}
@property(nonatomic) UITableViewCellSelectionStyle	selectionStyle;
@end
