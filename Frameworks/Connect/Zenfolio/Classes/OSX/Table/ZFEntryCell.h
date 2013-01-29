//
//  ZFEntryCell.h
//  ZenfolioDownloader
//
//  Created by patrick machielse on 22-8-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZFGroupElement.h"
#import "ZFGroupElementSelection.h"
#import "FLTextFieldCell.h"

/*!
    @header		ZFEntryCell
    @abstract   Cell for displaying a ZFGroupElement.
    @discussion An object of this class draws the first column of the content selection table. It displays a checkbox, an image, and the entry's title.
*/

//@protocol ZFEntryCellDelegate <NSObject>
//- (void)toggleSelectionForItemAtRow:(int)itemRow;
//@property (readonly, strong, nonatomic) ZFGroupElementSelection* selection;
//@end

@interface ZFEntryCell : FLTextFieldCell {
@private
    __unsafe_unretained ZFGroupElement* _groupElement;
}
@property (readwrite, assign, nonatomic) id groupElement;
+ (id)cell;
@end

//@interface ZFGroupElement (OutlineView)
//- (NSCellStateValue) cellStateForSelection:(ZFGroupElementSelection*) selection;
//@end
