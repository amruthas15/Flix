//
//  main.m
//  Flix
//
//  Created by Amrutha Srikanth on 6/23/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"darkSwitch"];
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
