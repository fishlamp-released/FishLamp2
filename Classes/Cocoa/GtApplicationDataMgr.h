//
//  GtApplicationDataMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectDatabase.h"
#import "GtUserLogin.h"

@interface GtApplicationDataMgr : NSObject {
@private
	GtObjectDatabase* m_database;
}

@property (readonly, retain, atomic) GtObjectDatabase* database;

GtSingletonProperty(GtApplicationDataMgr);

- (void) openDatabase;

@end

