//
//  DetailsViewController.m
//  Flix
//
//  Created by Amrutha Srikanth on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"


@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"darkSwitch"])
    {
        self.overrideUserInterfaceStyle = 2;
    }
    else
    {
        self.overrideUserInterfaceStyle = 1;
    }
    
    [SVProgressHUD show];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    
    [SVProgressHUD dismiss];

}

-(void) viewWillAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"darkSwitch"])
    {
        self.overrideUserInterfaceStyle = 2;
    }
    else
    {
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
