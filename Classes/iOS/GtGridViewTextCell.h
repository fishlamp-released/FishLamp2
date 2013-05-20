//
//  GtTextGridViewCell.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/20/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewCellController.h"

@interface GtGridViewTextCell : GtGridViewCellController {
@private
    NSString* m_text;
    UILabel* m_label;
}
@property (readwrite, retain, nonatomic) NSString* text;
@end

