//
//  FLTcpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLinkedListElement.h"
#import "FLTcpConnectionReader.h"
#import "FLTcpConnectionWriter.h"

@interface FLTcpRequest : FLLinkedListElement {
@private
    BOOL _wantsWrite;
    BOOL _wantsRead;
}

@property (readwrite, assign, nonatomic) BOOL wantsWrite;

@property (readwrite, assign, nonatomic) BOOL wantsRead;

- (BOOL) readData:(FLTcpConnectionReader*) reader;

- (BOOL) writeData:(FLTcpConnectionWriter*) writer;

@end