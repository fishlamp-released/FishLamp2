//
//  GtFacebookStatusTableCell.h
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtStatusWidget.h"
#import "GtFacebookPost.h"
#import "GtFacebookStatusLinkWidget.h"

@interface GtFacebookStatusTableCellWidget : GtStatusWidget {
@private
	GtFacebookPost* m_post;
	
	GtLabelWidget* m_likesAndCommentsWidget;
	GtFacebookStatusLinkWidget* m_linkWidget;
}

@property (readwrite, retain, nonatomic) GtFacebookPost* post;

@end
