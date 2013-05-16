//
//  GtWsdlAction.h
//  seemeBaseball
//
//  Created by Mike Fullerton on 2/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtAction.h"

@interface GtWsdlAction : GtAction {

}

- (void) begin:(id) delegate
    superview:(UIView*) superview
    busyText:(NSString*) busyText;
    
- (void) setProgressInfo:(NSString*) busyText 
                 isModal:(BOOL) isModal;

@end
