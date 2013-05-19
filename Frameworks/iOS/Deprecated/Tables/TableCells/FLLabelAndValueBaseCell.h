//
//	FLLabelAndValueBaseCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/24/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLEditObjectTableViewCell.h"
#import "FLLabel.h"
#import "FLDeprecatedTextViewProxy.h"

#define FLDefaultRowHeight 40

@interface FLLabelAndValueBaseCell : FLEditObjectTableViewCell {
@private;
	FLDeprecatedTextViewProxy* _value;
	UIActivityIndicatorView* _spinner;
	struct {
		unsigned int updateTextWithRowData:1;
		unsigned int autoShowSpinner: 1;
		unsigned int trimWhiteSpace: 1; 
	} _baseFlags;
}
//@property (readwrite, assign, nonatomic) BOOL trimWhiteSpace;

@property (readonly, retain, nonatomic) UIActivityIndicatorView* spinner;
@property (readwrite, assign, nonatomic) BOOL autoShowSpinner;

@property (readwrite, assign, nonatomic) BOOL updateTextWithRowData;

@property (readonly, retain, nonatomic) FLDeprecatedTextViewProxy* valueLabel;
@property (readwrite, retain, nonatomic) NSString* valueLabelText;

- (UIView*) createValueLabel; // for subclasses, defaults to a FLLabel.

- (void) startSpinnerInValueCell;
- (void) stopSpinnerInValueCell;

- (void) adjustSpinnerFrame;

- (CGSize) valueTextSizeForContentViewWidth:(CGFloat) width;
	
@end

