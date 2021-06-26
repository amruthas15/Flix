//
//  SettingsViewController.m
//  Flix
//
//  Created by Amrutha Srikanth on 6/25/21.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"darkSwitch"])
    {
        self.darkSwitch.on = true;
        self.overrideUserInterfaceStyle = 2;

    }
    else
    {
        self.darkSwitch.on = false;
        self.overrideUserInterfaceStyle = 1;
    }    // Do any additional setup after loading the view.
}

- (IBAction)buttonClicked:(id)sender {
    if(self.darkSwitch.on)
    {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"darkSwitch"];
        self.overrideUserInterfaceStyle = 2;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"darkSwitch"];
        self.overrideUserInterfaceStyle = 1;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
