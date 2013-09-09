//
//  FLFacebookStatusTableCell.h
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#if 0
#import "FLStatusWidget.h"
#import "FLFacebookPost.h"
#import "FLFacebookStatusLinkWidget.h"

@interface FLFacebookStatusTableCellWidget : FLStatusWidget {
@private
	FLFacebookPost* _post;
	
	FLLabelWidget* _likesAndCommentsWidget;
//	FLFacebookStatusLinkWidget* _linkWidget;
}

@property (readwrite, retain, nonatomic) FLFacebookPost* post;

@end
#endif