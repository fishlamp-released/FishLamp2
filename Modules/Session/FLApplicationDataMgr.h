//
//  FLApplicationDataMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLObjectDatabase.h"
#import "FLUserLogin.h"

@interface FLApplicationDataMgr : NSObject {
@private
	FLObjectDatabase* _database;
}

@property (readonly, retain, atomic) FLObjectDatabase* database;

FLSingletonProperty(FLApplicationDataMgr);

- (void) openDatabase;

@end

