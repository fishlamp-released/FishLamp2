//
//	FLLabel.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTextDescriptor.h"

@interface FLLabel : UILabel {
@private
	BOOL _underline;
	FLTextDescriptor* _textDescriptor;
	FLTextDescriptorState _state;
}

@property (readwrite, assign, nonatomic) BOOL willUnderline;
@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;

@property (readwrite, copy, nonatomic) FLTextDescriptor* textDescriptor;

@end