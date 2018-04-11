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

-(void)write:(void (^)(void))updates {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        updates();
    }];
}

-(void)removeEntry:(RLMObject *)object {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:object];
    }];
}

-(RLMResults<Entry *>*) fetchEntries {
    return [[Entry allObjects] sortedResultsUsingKeyPath:@"setDate" ascending:true];
}

-(RLMResults<Entry *>*) fetchEntriesWhere:(NSString *)clause {
    return [[Entry objectsWhere:clause] sortedResultsUsingKeyPath:@"setDate" ascending:true];
}

-(void)removeAllEntries {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteAllObjects];
    }];
}

- (id)init {
    if (self = [super init]) {
        // custom init
    }
    return self;
}
@end
