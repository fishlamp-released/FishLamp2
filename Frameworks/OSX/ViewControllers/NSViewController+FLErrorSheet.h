//
//  NSViewController+FLErrorSheet.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSViewController (FLErrorSheet)
- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error;
- (void) didHideErrorAlertForError:(NSError*) error;
@end
