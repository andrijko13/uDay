//
//  DataStore.m
//  uDay
//
//  Created by Andriko on 2/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore
+ (DataStore *)main {
    static DataStore *mainStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainStore = [[self alloc] init];
    });
    return mainStore;
}

-(void)addEntry:(Entry *)entry {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:entry];
    }];

//    dispatch_async(dispatch_queue_create("background", 0), ^{
//        @autoreleasepool {
//            En *theDog = [[Dog objectsWhere:@"age == 1"] firstObject];
//            RLMRealm *realm = [RLMRealm defaultRealm];
//            [realm beginWriteTransaction];
//            theDog.age = 3;
//            [realm commitWriteTransaction];
//        }
//    });
}

-(RLMResults<Entry *>*) fetchEntries {
    return [Entry allObjects];
}

-(RLMResults<Entry *>*) fetchEntriesWhere:(NSString *)clause {
    return [Entry objectsWhere:clause];
}

- (id)init {
    if (self = [super init]) {
        // custom init
    }
    return self;
}
@end
