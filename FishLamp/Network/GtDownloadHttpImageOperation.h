//
//  GtDownloadHttpImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtHttpOperation.h"

@interface GtDownloadHttpImageOperation : GtHttpOperation {
}

- (id) initWithUrlInput:(NSString*) url;

// TODO improve API
// input is url
// output is NSData

@end
