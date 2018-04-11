//
//  DataStore.h
//  uDay
//
//  Created by Andriko on 2/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Entry.h"

@interface DataStore : NSObject
+(DataStore *)main;
-(void)addEntry:(Entry *)entry;
-(RLMResults<Entry *>*) fetchEntries;
-(RLMResults<Entry *>*) fetchEntriesWhere:(NSString *)clause;
-(void)write:(void (^)(void))updates;
-(void)removeAllEntries;
-(void)removeEntry:(RLMObject *)object;
@end
