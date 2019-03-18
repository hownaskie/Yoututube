//
//  ViewController.h
//  Yoututube
//
//  Created by JonasC on 15/02/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Setting.h"

@interface HomeController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

- (void)showControllerForSettings:(Setting *)setting;
- (void)scrollToMenuIndex:(NSInteger)index;

@end

