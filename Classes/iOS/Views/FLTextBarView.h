//
//	FLTextBarView.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
