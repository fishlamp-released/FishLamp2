//
//  GtTwoColumnWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"

@interface GtTwoColumnWidget : GtWidget {
@private
	GtWidget* m_leftColumn;
	GtWidget* m_rightColumn;
}

@property (readonly, retain, nonatomic) GtWidget* leftColumn;
@property (readonly, retain, nonatomic) GtWidget* rightColumn;

@end
