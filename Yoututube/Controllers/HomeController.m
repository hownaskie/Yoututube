//
//  ViewController.m
//  Yoututube
//
//  Created by JonasC on 15/02/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "HomeController.h"
#import "FeedCell.h"
#import "TrendingCell.h"
#import "SubscriptionCell.h"
#import "MenuBar.h"

#import "SettingsLauncher.h"

#import "Video.h"
#import "Channel.h"

#import "UIView+Constraints.h"
#import "UIColor+RgbColor.h"

@interface HomeController ()

@property (nonatomic, strong) MenuBar *menuBar;
@property (nonatomic, strong) SettingsLauncher *settingsLauncher;

@property (nonatomic, strong) NSArray *titles;

@end

static NSString *const kCellId = @"cellId";
static NSString *const kTrendingCellId = @"kTrendingCellId";
static NSString *const kSubscriptionCellId = @"kSubscriptionCellId";

@implementation HomeController

- (MenuBar *)menuBar {
    if(!_menuBar) {
        _menuBar = [[MenuBar alloc] init];
        _menuBar.homeController = self;
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

- (NSArray *)titles {
    if(!_titles) {
        _titles = @[@"Home", @"Trending", @"Subscriptions", @"Account"];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 32, self.view.frame.size.height)];
    titleLabel.text = @"  Home";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titleLabel;
    
    [self setupCollectionView];
    [self setupMenuBar];
    [self setupNavBar];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if(flowLayout) {
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0.0f;
    }
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:kCellId];
    [self.collectionView registerClass:[TrendingCell class] forCellWithReuseIdentifier:kTrendingCellId];
    [self.collectionView registerClass:[SubscriptionCell class] forCellWithReuseIdentifier:kSubscriptionCellId];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    self.collectionView.pagingEnabled = YES;
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

- (void)scrollToMenuIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    [self setTitleForIndex:index];
}

- (void)setTitleForIndex:(NSInteger)index {
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.text = [NSString stringWithFormat:@"  %@", [self.titles objectAtIndex:index]];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.menuBar.horizontalBarLeftAnchorConstraint.constant = scrollView.contentOffset.x / 4;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger index = (NSInteger)(floor(targetContentOffset->x / self.view.frame.size.width));
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.menuBar.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    [self setTitleForIndex:index];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = nil;
    if(indexPath.item == 1) {
        identifier = kTrendingCellId;
    } else if(indexPath.item == 2) {
        identifier = kSubscriptionCellId;
    } else {
        identifier = kCellId;
    }
    
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 50);
}

@end
