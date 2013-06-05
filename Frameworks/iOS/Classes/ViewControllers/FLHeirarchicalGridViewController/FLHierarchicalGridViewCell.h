//
//  FLHeirarchicalGridViewCell.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGridCell.h"

@interface FLHierarchicalGridViewCell : FLGridCell {
@private
    BOOL _discloseFromLeft;
}
+ (FLHierarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject;
@end
