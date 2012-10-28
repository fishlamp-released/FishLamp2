//
//	FLPickerViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEditObjectTableViewCell.h"

@interface FLPickerViewCell : FLEditObjectTableViewCell {
	UIPickerView* _pickerView;
}

- (UIPickerView*) pickerView;

@end
