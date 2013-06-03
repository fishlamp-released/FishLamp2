//
//	FLTextField.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
