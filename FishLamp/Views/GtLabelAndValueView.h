//
//  GtLabelAndValueView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#define GtDefaultLabelWidth 60
#define GtDefaultLabelHeight 20

@interface GtLabelAndValueView : UIView {
@private
	UILabel* m_label;
	UILabel* m_value;
	NSUInteger m_labelWidth;
}

@property (readwrite, assign, nonatomic) NSUInteger labelWidth;

@property (readonly, assign, nonatomic) UILabel* label;
@property (readonly, assign, nonatomic) UILabel* value;
	
@end
