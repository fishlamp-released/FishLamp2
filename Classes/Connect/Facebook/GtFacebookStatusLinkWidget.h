//
//  GtFacebookStatusLinkWidget.h
//  Affable
//
//  Created by Mike Fullerton on 7/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTwoColumnWidget.h"
#import "GtServerSideImageWidget.h"
#import "GtLabelWidget.h"
#import "GtFacebookPost.h"
#import "GtFacebookStatusLinkWidget.h"

@interface GtFacebookStatusLinkWidget : GtWidget {
@private
	GtServerSideImageWidget* m_picture;
	GtWidget* m_rightColumn;
//	GtFacebookStatusLinkWidget* m_link;
	GtLabelWidget* m_name;
	GtLabelWidget* m_caption;
}

- (void) setInfoWithPost:(GtFacebookPost*) post;

@end
