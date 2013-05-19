//
//	FLLabel.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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