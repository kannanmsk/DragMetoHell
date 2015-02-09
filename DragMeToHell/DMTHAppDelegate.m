//
//  DMTHAppDelegate.m
//  DragMeToHell
//
//  Created by Robert Irwin on 2/18/12.
//  Copyright (c) 2012 Robert J. Irwin. All rights reserved.
//

#import "DMTHAppDelegate.h"
#import "DMTHViewController.h"

@implementation DMTHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.viewController = [[DMTHViewController alloc] initWithNibName:@"DMTHViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
