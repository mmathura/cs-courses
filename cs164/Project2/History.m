//
//  History.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import "History.h"

@implementation History


- (void)save: (id) arr {
    
    NSError *error;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"highscore.plist"];
    
    // NSLog(@"%@", plistPath);
    
    
    // NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
    //                           [NSArray arrayWithObjects: @"LAMB", @6, nil]
    //                                                      forKeys:[NSArray arrayWithObjects: @"Item 0", @"Item 1", nil]];
    
    NSArray *plistDict = arr;

    // NSLog(@"plistDict = %@", plistDict);
    
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:0
                                                                    error: &error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"%@", error);
    }

}

- (void) retrieve {
    
    NSString *errorDesc = nil;
    
    NSPropertyListFormat format;
    
    NSString *plistPath;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    plistPath = [rootPath stringByAppendingPathComponent:@"highscore.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
       
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    
    // NSLog(@"Temp = %@", temp);
    
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %u", errorDesc, format);
    }
    
    // NSLog(@"%@", temp);
    
}

@end
