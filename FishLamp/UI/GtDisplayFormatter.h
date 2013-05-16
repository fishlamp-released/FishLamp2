//
//  GtDisplayFormatter.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

@protocol GtDisplayFormatterProtocol<NSObject>
- (NSString*) dataToString:(id) data; 
@optional
- (id) stringToData:(NSString*) string prevData:(id) prevData;
@end

