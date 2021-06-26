//
//  GenreGridViewController.m
//  Flix
//
//  Created by Amrutha Srikanth on 6/25/21.
//

#import "GenreGridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "SVProgressHUD.h"

@interface GenreGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSNumber *specialGenre;


@end

@implementation GenreGridViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.specialGenre = @16;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"darkSwitch"])
    {
        self.overrideUserInterfaceStyle = 2;
    }
    else
    {
        self.overrideUserInterfaceStyle = 1;
    }
    
    [SVProgressHUD show];
    
    [self fetchMovies];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}

-(void)fetchMovies {
    NSLog(@"Out");
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               [self sendError];
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSArray *allMovies = dataDictionary[@"results"];
               NSMutableArray *animated = [[NSMutableArray alloc] init];
               for(NSDictionary *movie in allMovies)
               {
                   NSArray *genres = movie[@"genre_ids"];
                   NSInteger count = 0;
                   while (count < genres.count) {
                       if([genres[count] doubleValue] == [self.specialGenre doubleValue])
                       {
                           [animated addObject:movie];
                           count = genres.count;
                       }
                       else
                       {
                           count = count + 1;
                       }
                   }
               }
               self.movies = animated;
               [self.collectionView reloadData];
               

               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
           }
        [SVProgressHUD dismiss];
       }];
    [task resume];
}

-(void)sendError {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Movies Not Accessible"
                                                                               message:@"The internet connection appears to be offline."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        //optional code after error message is removed
        
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.item];

    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([sender isKindOfClass:[UICollectionViewCell class]])
    {
        UICollectionViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        NSDictionary *movie = self.movies[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.movie = movie;
    }
}

@end

