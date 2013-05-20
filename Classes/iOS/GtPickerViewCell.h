//
//	GtPickerViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectTableViewCell.h"

@interface GtPickerViewCell : GtEditObjectTableViewCell {
	UIPickerView* m_pickerView;
}

- (UIPickerView*) pickerView;

@end
