//
//  FLLogPacket_Internal.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogEntry.h"

@interface FLLogEntry () 
- (void) preparePacketForDelivery:(NSString*) log 
                       forLogType:(NSString*) logType 
                       forLogName:(NSString*) logName 
                       stackTrace:(FLStackTrace*) stackTrace
                         logCount:(int32_t) logCount;
@end
