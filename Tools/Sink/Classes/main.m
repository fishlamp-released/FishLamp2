//
//  main.m
//  Fluffy
//
//  Created by Mike Fullerton on 6/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLSyncFishLampTool.h"
#import "FLToolMain.h"

int main(int argc, const char *argv[]) {
    FLToolMain(argc, argv, [FLSyncFishLampTool class]);
    return 0;
}
