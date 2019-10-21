//
//  GoodGameplay.h
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameplayDeligate.h"

@interface GoodGameplay : NSObject <GameplayDeligate>

@property NSDictionary *dict;
@property NSMutableDictionary *mdict;
@property (assign, nonatomic, readwrite) int nguessed;

@end
