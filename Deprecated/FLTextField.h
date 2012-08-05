//
//	FLTextField.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTextDescriptor.h"
#import "FLArrangement.h"

@interface FLTextField : UITextField {
@private
	BOOL _canResign;
	FLTextDescriptor* _textDescriptor;
	FLTextDescriptor* _placeholderTextDescriptor;
	FLTextDescriptorState _state;
	UIEdgeInsets _viewLayoutMargins;
}

@property (readwrite, assign, nonatomic) BOOL canResignFirstResponder;
@property (readwrite, copy, nonatomic) FLTextDescriptor* textDescriptor;
@property (readwrite, copy, nonatomic) FLTextDescriptor* placeholderTextDescriptor;
@property (readwrite, assign, nonatomic) UIEdgeInsets viewLayoutMargins;// these are deltas when used with 

@end
