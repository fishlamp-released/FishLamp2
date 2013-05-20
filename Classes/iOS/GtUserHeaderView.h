//
//  GtUserHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLabel.h"

@class GtUserHeaderView;

@protocol GtUserHeaderViewTheme <NSObject>
- (void) applyThemeToUserHeaderView:(GtUserHeaderView*) view;
	// note that the thumbnailView uses the layer for the border, rounded edges, etc.
@end

@interface GtUserHeaderView : UIView {
@private
	UIImageView* m_thumbnail;
	GtLabel* m_nameLabel;
	UIActivityIndicatorView* m_spinner;
	UIImageView* m_logo;
}
@property (readonly, retain, nonatomic) UIImageView* logoView;

@property (readonly, retain, nonatomic) UIImageView* thumbnailView;
@property (readonly, retain, nonatomic) GtLabel* nameLabel;

@property (readwrite, retain, nonatomic) NSString* name;
@property (readwrite, retain, nonatomic) UIImage* thumbnail;

- (void) startSpinner;
- (void) stopSpinner;

@end
