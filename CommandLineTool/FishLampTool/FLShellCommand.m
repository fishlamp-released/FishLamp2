//
//  FLShellCommand.m
//  FishLampOSXTool
//
//  Created by Mike Fullerton on 5/27/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLShellCommand.h"

@implementation FLShellCommand

@end

/*

NSString* getPipedData()
{
    NSPipe* pipe = [NSPipe pipe];
    NSFileHandle* file = [pipe fileHandleForReading];
    NSData* data = [file readDataToEndOfFile];
    
    return autorelease_([[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);ß
}


 NSTask *theProcess = [[NSTask alloc] init];
    
    NSMutableArray* args = [NSMutableArray array];
    
    [args addObject:@"-u"];
    [args addObject:@"fimblegait:Teddy65"];
  //  [args addObject:@"-X"];
  //  [args addObject:@"POST"];
  //  [args addObject:@"-v"];
    
    [args addObject:@"-d"];
    // @"status=\"d otenay ";
    NSMutableString* msg = [NSMutableString string];
    for(int i = 1; i < argc; i++)
    {
        [msg appendString:
            [NSMutableString stringWithFormat:@" %@", 
                [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding]]];
    }
        
    [args addObject:[NSMutableString stringWithFormat:@"status=d otenay%@", msg]];
    [args addObject:@"http://api.twitter.com/1/statuses/update.xml"];
   
    [theProcess setLaunchPath:@"/usr/bin/curl"];
    
    printf("args: %s", [[args description] cStringUsingEncoding:NSASCIIStringEncoding]);
    [theProcess setArguments:args];
    [theProcess launch];
    
    printf("sending...");
    while(theProcess.isRunning)
    {
        ".";
    }
    printf("done.\n");

    release_(theProcess);
    
*/
