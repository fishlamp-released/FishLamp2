//
//	FLTextBarView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTextBarView : UIView {
@private
	UILabel* _text;
	UILabel* _label;
}

@property (readonly, retain, nonatomic) UILabel* textLabel;
@property (readonly, retain, nonatomic) UILabel* label;

@end
