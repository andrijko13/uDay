//
//  AppDelegate.h
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

@import UIKit;
@import CoreData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end

