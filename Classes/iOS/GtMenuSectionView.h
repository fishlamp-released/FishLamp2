//
//  GtMenuViewSection.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientView.h"
#import "GtMenuHeaderView.h"

@interface GtMenuSectionView : UIView {
@private
    GtMenuSectionHeaderView* m_header;
}

- (id) initWithSectionTitle:(NSString*) sectionTitle;

@property (readwrite, retain,nonatomic) NSString* sectionTitle;

@end
