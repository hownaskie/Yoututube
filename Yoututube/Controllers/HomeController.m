//
//  ViewController.m
//  Yoututube
//
//  Created by JonasC on 15/02/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "HomeController.h"
#import "VideoCell.h"
#import "MenuBar.h"

#import "SettingsLauncher.h"

#import "Video.h"
#import "Channel.h"

#import "UIView+Constraints.h"
#import "UIColor+RgbColor.h"

@interface HomeController ()

@property (nonatomic, strong) MenuBar *menuBar;

@property (nonatomic, strong) NSMutableArray<Video *> *videos;

@property (nonatomic, strong) SettingsLauncher *settingsLauncher;

@end

static NSString *const kCellId = @"cellId";

@implementation HomeController

- (NSMutableArray<Video *> *)videos {
    if(!_videos) {
        _videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (void)fetchVideos {
    NSURL *url = [NSURL URLWithString:@"https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) return;
        
        NSError *jsonError = nil;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(jsonError) return;
        
        
        for(NSDictionary *dictionary in json) {
            Video *video = [[Video alloc] init];
            video.title = dictionary[@"title"];
            video.thumbnailImageName = dictionary[@"thumbnail_image_name"];
            video.numberOfViews = dictionary[@"number_of_views"];
            
            NSDictionary *channelDictionary = dictionary[@"channel"];
            
            Channel *channel = [[Channel alloc] init];
            channel.name = channelDictionary[@"name"];
            channel.profileImageName = channelDictionary[@"profile_image_name"];
            video.channel = channel;
            
            [self.videos addObject:video];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }] resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchVideos];
    
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 32, self.view.frame.size.height)];
    titleLabel.text = @"  Home";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:kCellId];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    
    [self setupMenuBar];
    [self setupNavBar];
}

- (MenuBar *)menuBar {
    if(!_menuBar) {
        _menuBar = [[MenuBar alloc] init];
    }
    return _menuBar;
}

- (SettingsLauncher *)settingsLauncher {
    if(!_settingsLauncher) {
        _settingsLauncher = [[SettingsLauncher alloc] init];
        _settingsLauncher.homeController = self;
    }
    return _settingsLauncher;
}

- (void)setupMenuBar {
    self.navigationController.hidesBarsOnSwipe = YES;
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor rgbWithRed:230 green:32 blue:31];
    [self.view addSubview:redView];
    [self.view addConstraintsWithVisualFormat:@"H:|[v0]|" withViews:redView, nil];
    [self.view addConstraintsWithVisualFormat:@"V:[v0(50)]" withViews:redView, nil];
    
    [self.view addSubview:self.menuBar];
    [self.view addConstraintsWithVisualFormat:@"H:|[v0]|" withViews:_menuBar, nil];
    [self.view addConstraintsWithVisualFormat:@"V:[v0(50)]" withViews:_menuBar, nil];
    
    [self.menuBar.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor].active = YES;
}

- (void)setupNavBar {
    UIImage *searchImage = [[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithImage:searchImage style:UIBarButtonItemStylePlain target:self action:@selector(handleSearch)];
    searchBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIImage *menuImage = [[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuImage style:UIBarButtonItemStylePlain target:self action:@selector(handleMore)];
    menuBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    self.navigationItem.rightBarButtonItems = @[menuBarButtonItem, searchBarButtonItem];
}

- (void)handleSearch {
    
}

- (void)handleMore {
    [self.settingsLauncher showSettings];
}

- (void)showControllerForSettings:(Setting *)setting {
    UIViewController *dummySettingViewController = [[UIViewController alloc] init];
    dummySettingViewController.view.backgroundColor = [UIColor whiteColor];
    dummySettingViewController.navigationItem.title = setting.name;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController pushViewController:dummySettingViewController animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.videos.count > 0) {
        return self.videos.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    if(self.videos.count > 0) {
        cell.video = [self.videos objectAtIndex:indexPath.item];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = (self.view.frame.size.width - 16 - 16) * 9 / 16;
    return CGSizeMake(self.view.frame.size.width, height + 16 + 88);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
