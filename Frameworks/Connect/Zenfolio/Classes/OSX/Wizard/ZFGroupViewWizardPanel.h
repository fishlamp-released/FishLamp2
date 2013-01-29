//
//  ZFGroupViewWizardPanel.h
//  ZenLib
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardPanel.h"
#import "ZFGroupElementSelection.h"
#import "ZFEntryCell.h"
#import "ZFWizardViewController.h"

@protocol ZFGroupViewWizardPanelDelegate;

@interface ZFGroupViewWizardPanel : FLWizardPanel<NSOutlineViewDataSource, NSOutlineViewDelegate> {
@private
    IBOutlet NSTableColumn* _nameColumn;
    IBOutlet NSTableColumn* _photosColumn;
    IBOutlet NSTableColumn* _sizeColumn;
    IBOutlet NSTableColumn* _createdColumn;
    IBOutlet NSTableColumn* _modifiedColumn;
    IBOutlet NSScrollView* _scrollView;
    IBOutlet NSOutlineView* _outlineView;
    ZFGroup* _rootGroup;
    id<ZFGroupViewWizardPanelDelegate> _delegate;
    BOOL _expandedFirstTime;
    id context;
}
+ (id) groupViewWizardPanel;
@end

