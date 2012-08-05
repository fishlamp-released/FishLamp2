//
//  FLFacebookStatusTableCell.h
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#if 0
#import "FLStatusWidget.h"
#import "FLFacebookPost.h"
#import "FLFacebookStatusLinkWidget.h"

@interface FLFacebookStatusTableCellWidget : FLStatusWidget {
@private
	FLFacebookPost* m_post;
	
	FLLabelWidget* m_likesAndCommentsWidget;
//	FLFacebookStatusLinkWidget* m_linkWidget;
}

@property (readwrite, retain, nonatomic) FLFacebookPost* post;

@end
#endif