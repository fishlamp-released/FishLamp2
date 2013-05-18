//
//  GtEditableDataProtocol.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

@protocol GtEditableDataProtocol <NSObject>

@property (readonly, assign, nonatomic) BOOL isCommitting;
@property (readonly, assign, nonatomic) BOOL isDirty;
@property (readwrite, assign, nonatomic) BOOL isEditable;

- (void) commit;
- (void) beginCommit;
- (void) endCommit;
- (void) rollbackCommit;
- (void) revert;

@end
