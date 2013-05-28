//
//	FLTableCellBackground.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

@interface FLTableCellBackgroundWidget : FLWidget {
@private
	UITableViewCellSelectionStyle _selectionStyle;
}
@property(nonatomic) UITableViewCellSelectionStyle	selectionStyle;
@end
